import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';
import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Tests/Spelling_Test/Controller/spelling_controller.dart';

class VoiceSpellingTest extends StatefulWidget {
  const VoiceSpellingTest({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VoiceSpellingTestState createState() => _VoiceSpellingTestState();
}

class _VoiceSpellingTestState extends State<VoiceSpellingTest> {
  late SpellingTestViewModel _viewModel;
  bool _isInitialized = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initViewModel();
  }

  Future<void> _initViewModel() async {
    _viewModel = SpellingTestViewModel();
    try {
      await _viewModel.init();
      setState(() => _isInitialized = true);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    if (!_isInitialized) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      backgroundColor: kPrimary3,
      appBar: BuildAppBar(context, w, title: 'اختبار التهجئة', actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProgressIndicator(w),
              SizedBox(height: h * .03),
              _buildWordCard(w, h),
              SizedBox(height: h * .05),
              _buildControlsSection(w, h),
              if (_viewModel.showResult) _buildResultSection(w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(double width) {
    return LinearProgressIndicator(
      value: (_viewModel.currentIndex + 1) / _viewModel.words.length,
      color: kBlack,
      backgroundColor: kveryWhite,
      minHeight: 6,
    );
  }

  Widget _buildWordCard(double width, double height) {
    return Container(
      height: height * .3,
      width: width,
      decoration: BoxDecoration(
        color: kveryWhite,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [BoxShadow(blurRadius: 10, color: kveryWhite)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "الكلمة المراد نطقها",
            style: GoogleFonts.cairo(
              color: kDGrey,
              fontSize: width * .06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * .02),
          Text(
            _viewModel.words[_viewModel.currentIndex].word,
            style: GoogleFonts.cairo(
              color: kBlack,
              fontSize: width * .12,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_viewModel.showHint &&
              _viewModel.words[_viewModel.currentIndex].hint != null)
            Padding(
              padding: EdgeInsets.only(top: height * .02),
              child: Text(
                _viewModel.words[_viewModel.currentIndex].hint!,
                style: GoogleFonts.cairo(
                  color: kDGrey,
                  fontSize: width * .045,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlsSection(double width, double height) {
    return Column(
      children: [
        _buildActionButton(
          icon: Icons.volume_up,
          label: 'استمع للكلمة',
          color: kDGrey,
          onPressed: _handleSpeakWord,
          width: width,
        ),
        SizedBox(height: height * .03),
        _buildRecordButton(width),
        if (_viewModel.recordedFilePath != null) ...[
          SizedBox(height: height * .03),
          _buildPlaybackButton(width),
        ],
      ],
    );
  }

  Future<void> _handleSpeakWord() async {
    try {
      await _viewModel.speakWord();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تعذر تشغيل الكلمة', style: GoogleFonts.cairo()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildRecordButton(double width) {
    return _buildActionButton(
      icon: _viewModel.isRecording ? Icons.stop : Icons.mic,
      label: _viewModel.isRecording ? 'إيقاف التسجيل' : 'تسجيل إجابتك',
      color: _viewModel.isRecording ? kRed : kveryWhite,
      textColor: _viewModel.isRecording ? kveryWhite : kBlack,
      onPressed: _handleRecording,
      width: width,
    );
  }

  Future<void> _handleRecording() async {
    try {
      if (_viewModel.isRecording) {
        await _viewModel.stopRecording();
      } else {
        await _viewModel.startRecording();
      }
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء التسجيل', style: GoogleFonts.cairo()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildPlaybackButton(double width) {
    return _buildActionButton(
      icon: _viewModel.isPlaying ? Icons.volume_up : Icons.play_arrow,
      label: 'سماع تسجيلي',
      color: kDGrey,
      onPressed: _viewModel.isPlaying ? null : _handlePlayRecording,
      width: width,
    );
  }

  Future<void> _handlePlayRecording() async {
    try {
      await _viewModel.playRecording();
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تعذر تشغيل التسجيل', style: GoogleFonts.cairo()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildResultSection(double width) {
    return Column(
      children: [
        SizedBox(height: 20),
        _viewModel.isCorrect
            ? _buildSuccessWidget(width)
            : _buildErrorWidget(width),
        SizedBox(height: 20),
        _buildNextButton(width),
      ],
    );
  }

  Widget _buildSuccessWidget(double width) {
    return Column(
      children: [
        Icon(Icons.check_circle, color: kgreen2, size: 60),
        SizedBox(height: 10),
        Text(
          'أحسنت! النطق صحيح',
          style: GoogleFonts.cairo(
            color: kgreen2,
            fontSize: width * .06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(double width) {
    return Column(
      children: [
        Icon(Icons.error_outline, color: kRed, size: 60),
        SizedBox(height: 10),
        Text(
          'يحتاج لتحسين',
          style: GoogleFonts.cairo(
            color: kRed,
            fontSize: width * .06,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        if (_viewModel.userPronunciation.isNotEmpty)
          Text(
            'نطقك: ${_viewModel.userPronunciation}',
            style: GoogleFonts.cairo(
              color: kveryWhite,
              fontSize: width * .045,
            ),
          ),
        SizedBox(height: 5),
        Text(
          'الكلمة الصحيحة: ${_viewModel.words[_viewModel.currentIndex].word}',
          style: GoogleFonts.cairo(
            color: kveryWhite,
            fontSize: width * .045,
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(double width) {
    return _buildActionButton(
      icon: Icons.navigate_next,
      label: _viewModel.currentIndex < _viewModel.words.length - 1
          ? 'الكلمة التالية'
          : 'إنهاء الاختبار',
      color: kveryWhite,
      textColor: kBlack,
      onPressed: () {
        setState(() => _viewModel.nextWord());
        if (_viewModel.currentIndex == _viewModel.words.length - 1) {
          _showFinalResults();
        }
      },
      width: width * 0.8,
    );
  }

  void _showFinalResults() {
    final results = _viewModel.getTestResults();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('نتائج الاختبار', style: GoogleFonts.cairo()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'الإجابات الصحيحة: ${results['correct']}/${results['total']}',
              style: GoogleFonts.cairo(),
            ),
            Text(
              'النسبة: ${results['percentage']}%',
              style: GoogleFonts.cairo(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حسناً', style: GoogleFonts.cairo()),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: kPrimary3,
      body: Center(
        child: _errorMessage.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: kRed, size: 50),
                  SizedBox(height: 20),
                  Text(
                    _errorMessage,
                    style: GoogleFonts.cairo(color: kveryWhite),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _initViewModel,
                    child: Text('إعادة المحاولة', style: GoogleFonts.cairo()),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: kveryWhite),
                  SizedBox(height: 20),
                  Text(
                    'جاري تحميل الاختبار...',
                    style: GoogleFonts.cairo(color: kveryWhite),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    Color textColor = kveryWhite,
    required VoidCallback? onPressed,
    required double width,
  }) {
    return SizedBox(
      width: width * 0.74,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 28),
            SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: width * 0.045,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
