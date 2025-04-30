// ignore_for_file: library_private_types_in_public_api
import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter_Discrimination_Test/Controller/voice_letter_test_controller.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter_Discrimination_Test/feedback_widget.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter_Discrimination_Test/progress_indicator.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter_Discrimination_Test/question_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoiceLetterTest extends StatefulWidget {
  const VoiceLetterTest({super.key});

  @override
  _VoiceLetterTestState createState() => _VoiceLetterTestState();
}

class _VoiceLetterTestState extends State<VoiceLetterTest> {
  final VoiceLetterTestController _controller = VoiceLetterTestController();
  int _currentQuestion = 0;
  int _score = 0;
  bool _isPlaying = false;
  bool _isListening = false;
  String _recognizedText = '';
  String _feedback = '';
  Color _feedbackColor = Colors.transparent;
  bool _showStopButton = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _controller.initTTS();
    bool speechInitialized = await _controller.initSpeech();
    if (!speechInitialized) {
      setState(() {
        _feedback = 'تعذر تهيئة التعرف الصوتي';
        _feedbackColor = kRed;
      });
    }
  }

  Future<void> _playCurrentLetter() async {
    setState(() => _isPlaying = true);
    try {
      await _controller
          .playLetterSound(_controller.questions[_currentQuestion].letter);
    } catch (e) {
      setState(() {
        _feedback = 'حدث خطأ أثناء تشغيل الصوت';
        _feedbackColor = kRed;
      });
    } finally {
      setState(() => _isPlaying = false);
    }
  }

  Future<void> _startListening() async {
    final hasPermission = await _controller.requestMicrophonePermission();
    if (!hasPermission) {
      setState(() {
        _feedback = 'يجب منح إذن الميكروفون';
        _feedbackColor = kRed;
      });
      return;
    }

    setState(() {
      _isListening = true;
      _showStopButton = true;
      _recognizedText = '';
      _feedback = '';
      _feedbackColor = Colors.transparent;
    });

    await _controller.startListening(
      onResult: (text) {
        setState(() {
          _recognizedText = text;
          _isListening = false;
          _showStopButton = false;
          _evaluateAnswer();
        });
      },
      onError: (error) {
        setState(() {
          _isListening = false;
          _showStopButton = false;
          _feedback = 'خطأ في التعرف: $error';
          _feedbackColor = kRed;
        });
      },
    );
  }

  Future<void> _stopListening() async {
    await _controller.stopListening();
    setState(() {
      _isListening = false;
      _showStopButton = false;
    });
    if (_recognizedText.isNotEmpty) {
      _evaluateAnswer();
    }
  }

  void _evaluateAnswer() {
    final currentQuestion = _controller.questions[_currentQuestion];
    final processedText = _controller.processArabicText(_recognizedText);
    final isCorrect = _controller.checkAnswer(processedText, currentQuestion);

    setState(() {
      if (isCorrect) {
        _score++;
        _feedback = 'إجابة صحيحة! 👏';
        _feedbackColor = kgreen;
      } else {
        _feedback = 'إجابة خاطئة، حاول مرة أخرى';
        _feedbackColor = kRed;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _controller.questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _recognizedText = '';
        _feedback = '';
        _feedbackColor = Colors.transparent;
      });
    } else {
      _showFinalResults();
    }
  }

  void _showFinalResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kveryWhite,
        title: Text('نتيجة الاختبار',
            style: GoogleFonts.cairo(
                color: kBlack, fontWeight: FontWeight.bold, fontSize: 18)),
        content: Text(
          'لقد حصلت على $_score من ${_controller.questions.length}',
          style: GoogleFonts.cairo(
              color: kBlack, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTest();
            },
            child: Text(
              'إعادة الاختبار',
              style: GoogleFonts.cairo(
                  color: kgreen2, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'حسناً',
              style: GoogleFonts.cairo(
                  color: kRed, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _resetTest() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
      _recognizedText = '';
      _feedback = '';
      _feedbackColor = Colors.transparent;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _controller.questions[_currentQuestion];
    final isLastQuestion = _currentQuestion == _controller.questions.length - 1;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: BuildAppBar(context, w, title: 'الاختبار الأول', actions: [
        IconButton(
          onPressed: _showInstructions,
          icon: Icon(Icons.info, color: kBlack),
        )
      ]),
      body: GestureDetector(
        onTap: () {
          if (_isListening) {
            _stopListening();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomProgressIndicator(
                  current: _currentQuestion + 1,
                  total: _controller.questions.length,
                ),
                SizedBox(height: h * .04),
                QuestionCard(
                  question: currentQuestion,
                  onPlaySound: _playCurrentLetter,
                  isPlaying: _isPlaying,
                ),
                SizedBox(height: h * .02),
                if (_recognizedText.isNotEmpty) ...[
                  Text(
                    'تم التعرف على: $_recognizedText',
                    style: GoogleFonts.cairo(
                        color: kveryWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: w * .065),
                  ),
                ],
                SizedBox(height: h * .022),
                if (_isListening)
                  Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: h * .02),
                      Text(
                        'جارٍ الاستماع... انطق الحرف الآن',
                        style: GoogleFonts.cairo(
                          color: kBlack,
                          fontSize: w * .04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: h * .02),
                      if (_showStopButton)
                        GestureDetector(
                          onTap: _stopListening,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: kRed,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'إيقاف التسجيل',
                              style: GoogleFonts.cairo(
                                color: kveryWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                else
                  GestureDetector(
                    onTap: _startListening,
                    child: Container(
                      height: h * .07,
                      width: w * .8,
                      decoration: BoxDecoration(
                        color: kBlack,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mic, color: kveryWhite),
                          SizedBox(width: w * .025),
                          Text(
                            'ابدأ التسجيل',
                            style: GoogleFonts.cairo(
                                color: kveryWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: w * .05),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_feedback.isNotEmpty) ...[
                  SizedBox(height: 20),
                  FeedbackWidget(
                    text: _feedback,
                    color: _feedbackColor,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _nextQuestion,
                    child: Container(
                      height: h * .07,
                      width: w * .8,
                      decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: BorderRadius.circular(35)),
                      child: Center(
                        child: Text(
                          isLastQuestion ? 'عرض النتائج' : 'السؤال التالي',
                          style: GoogleFonts.cairo(
                              color: kveryWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: w * .04),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kPrimary3,
        title: Center(
            child: Text(
          'تعليمات الاختبار',
          style: GoogleFonts.cairo(
              color: kBlack, fontWeight: FontWeight.bold, fontSize: 19.5),
        )),
        content: SingleChildScrollView(
          child: Text(
            '1. استمع للحرف بالضغط على أيقونة الصوت\n'
            '2. اضغط على زر التسجيل وأنطق الحرف بوضوح\n'
            '3. انتظر حتى يتم تقييم إجابتك\n'
            '4. تابع للأسئلة التالية بعد رؤية النتيجة',
            style: GoogleFonts.cairo(
                color: kveryWhite, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'حسناً',
              style: GoogleFonts.cairo(
                  color: kBlack, fontWeight: FontWeight.bold, fontSize: 18.5),
            ),
          ),
        ],
      ),
    );
  }
}
