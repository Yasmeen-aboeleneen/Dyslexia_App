// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';
import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'spelling_controller.dart';
import 'dart:math';

class VoiceSpellingTest extends StatefulWidget {
  const VoiceSpellingTest({Key? key}) : super(key: key);

  @override
  State<VoiceSpellingTest> createState() => _VoiceSpellingTestState();
}

class _VoiceSpellingTestState extends State<VoiceSpellingTest> {
  late SpellingTestController _controller;
  bool _isLoading = true;
  String? _error;
  double _soundLevel = 0.0;
  bool _showTips = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    try {
      _controller = SpellingTestController();
      await _controller.initialize();
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_isLoading) return _buildLoadingView(size);
    if (_error != null) return _buildErrorView(size);

    return Scaffold(
      backgroundColor: kPrimary3,
      appBar: BuildAppBar(
        context,
        size.width,
        title: "تدريبات التهجئة",
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProgressIndicator(size),
            const SizedBox(height: 20),
            _buildWordCard(size),
            const SizedBox(height: 20),
            _buildSoundLevelIndicator(),
            const SizedBox(height: 20),
            _buildActionButtons(size),
            if (_controller.recordingState == RecordingState.processing)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            if (_controller.userPronunciation.isNotEmpty)
              _buildResultSection(size),
            if (_showTips) _buildTipsSection(size),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(Size size) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (_controller.currentIndex + 1) / _controller.words.length,
          backgroundColor: kveryWhite,
          color: kDGrey,
          minHeight: 8,
        ),
        const SizedBox(height: 8),
        Text(
          '${_controller.currentIndex + 1} / ${_controller.words.length}',
          style: GoogleFonts.cairo(
            color: kveryWhite,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildWordCard(Size size) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'تهجّي الكلمة التالية',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDGrey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _controller.currentWord.word,
              style: GoogleFonts.cairo(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: kBlack,
              ),
            ),
            const SizedBox(height: 12),
            _buildPhoneticPattern(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneticPattern() {
    return Wrap(
      spacing: 8,
      children:
          _controller.currentWord.phoneticPattern.split('-').map((phoneme) {
        return Chip(
          label: Text(phoneme),
          backgroundColor: kDGrey.withOpacity(0.1),
        );
      }).toList(),
    );
  }

  Widget _buildSoundLevelIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: _controller.recordingState == RecordingState.recording ? 12 : 0,
      child: LinearProgressIndicator(
        value: _soundLevel / 100,
        backgroundColor: Colors.transparent,
        color: kRed,
        minHeight: 8,
      ),
    );
  }

  Widget _buildActionButtons(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
          icon: Icons.volume_up,
          label: 'استمع',
          onPressed: _handleSpeak,
          color: kDGrey,
          size: size,
        ),
        _buildButton(
          icon: _controller.recordingState == RecordingState.recording
              ? Icons.stop
              : Icons.mic,
          label: _controller.recordingState == RecordingState.recording
              ? 'إيقاف'
              : 'تسجيل',
          onPressed: _handleRecording,
          color: _controller.recordingState == RecordingState.recording
              ? kRed
              : kveryWhite,
          textColor: _controller.recordingState == RecordingState.recording
              ? kveryWhite
              : kBlack,
          size: size,
        ),
      ],
    );
  }

  Widget _buildResultSection(Size size) {
    final isCorrect = _controller.currentWord
        .matchesPronunciation(_controller.userPronunciation);

    return Column(
      children: [
        const SizedBox(height: 20),
        Icon(
          isCorrect ? Icons.check_circle : Icons.help_outline,
          color: isCorrect ? kgreen2 : kPrimary1,
          size: 50,
        ),
        const SizedBox(height: 12),
        Text(
          isCorrect ? 'نطق صحيح!' : 'يحتاج تحسين',
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isCorrect ? kgreen2 : kPrimary1,
          ),
        ),
        const SizedBox(height: 16),
        _buildComparisonRow(
          'لقد قلت:',
          _controller.userPronunciation,
          kRed,
        ),
        const SizedBox(height: 8),
        _buildComparisonRow(
          'الصحيح:',
          _controller.currentWord.word,
          kgreen2,
        ),
        const SizedBox(height: 20),
        _buildNextButton(size),
      ],
    );
  }

  Widget _buildTipsSection(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kDGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نصائح للنطق:',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kDGrey,
            ),
          ),
          const SizedBox(height: 8),
          ..._buildPronunciationTips(),
        ],
      ),
    );
  }

  List<Widget> _buildPronunciationTips() {
    final word = _controller.currentWord.word;
    final tips = <Widget>[];

    if (word.contains('ق')) {
      tips.add(_buildTipItem('حرف القاف: انطقه من أقصى الحلق'));
    }
    if (word.contains('ض')) {
      tips.add(_buildTipItem('حرف الضاد: اضغط بلسانك على أسنانك الأمامية'));
    }
    if (word.length > 4) {
      tips.add(_buildTipItem('قسّم الكلمة: ${_splitWord(word)}'));
    }

    return tips.isNotEmpty
        ? tips
        : [_buildTipItem('استمع جيداً وحاول التقليد')];
  }

  String _splitWord(String word) {
    return word.split('').join('-');
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_left, size: 20, color: kDGrey),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.cairo(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.cairo(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(Size size) {
    final isLast = _controller.currentIndex == _controller.words.length - 1;

    return _buildButton(
      icon: isLast ? Icons.done : Icons.navigate_next,
      label: isLast ? 'النتائج' : 'التالي',
      onPressed: () => isLast ? _showResults() : _nextWord(),
      color: kveryWhite,
      textColor: kBlack,
      size: size,
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    Color textColor = kveryWhite,
    required Size size,
  }) {
    return SizedBox(
      width: size.width * 0.4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSpeak() async {
    await _controller.speakWord();
    setState(() => _showTips = true);
  }

  Future<void> _handleRecording() async {
    if (_controller.recordingState == RecordingState.recording) {
      final result = await _controller.stopRecording();
      _showFeedback(result.isCorrect);
      setState(() => _showTips = !result.isCorrect);
    } else {
      await _controller.startRecording();
      _startSoundLevelAnimation();
    }
    setState(() {});
  }

  void _startSoundLevelAnimation() {
    if (_controller.recordingState != RecordingState.recording) return;

    setState(() {
      _soundLevel = Random().nextDouble() * 80 + 20;
    });

    Future.delayed(
        const Duration(milliseconds: 100), _startSoundLevelAnimation);
  }

  void _nextWord() {
    _controller.nextWord();
    setState(() {
      _showTips = false;
      _soundLevel = 0.0;
    });
  }

  void _showResults() {
    final results = _controller.getTestResults();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('النتائج', style: GoogleFonts.cairo()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'الإجابات الصحيحة: ${results['correctAnswers']}/${results['totalWords']}',
              style: GoogleFonts.cairo(),
            ),
            const SizedBox(height: 8),
            Text(
              'النسبة: ${results['successPercentage']}%',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حسناً', style: GoogleFonts.cairo()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.resetTest();
              setState(() {});
            },
            child: Text('إعادة', style: GoogleFonts.cairo(color: kgreen2)),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('مساعدة', style: GoogleFonts.cairo()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpItem('1. اضغط "استمع" لسماع الكلمة'),
            _buildHelpItem('2. اضغط "تسجيل" وكرر الكلمة'),
            _buildHelpItem('3. استمع للنصائح لتحسين نطقك'),
            _buildHelpItem('4. تابع للكلمة التالية عند التمكن'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('فهمت', style: GoogleFonts.cairo(color: kgreen2)),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: kDGrey),
          const SizedBox(width: 8),
          Text(text, style: GoogleFonts.cairo()),
        ],
      ),
    );
  }

  void _showFeedback(bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'تم التسجيل بنجاح!' : 'حاول مرة أخرى',
          style: GoogleFonts.cairo(),
        ),
        backgroundColor: isCorrect ? kgreen2 : kPrimary1,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildLoadingView(Size size) {
    return Scaffold(
      backgroundColor: kPrimary3,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: kveryWhite),
            const SizedBox(height: 20),
            Text(
              'جاري التحميل...',
              style: GoogleFonts.cairo(
                color: kveryWhite,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(Size size) {
    return Scaffold(
      backgroundColor: kPrimary3,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: kRed, size: 50),
              const SizedBox(height: 20),
              Text(
                'حدث خطأ:',
                style: GoogleFonts.cairo(
                  color: kveryWhite,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _error ?? 'غير معروف',
                style: GoogleFonts.cairo(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildButton(
                icon: Icons.refresh,
                label: 'إعادة المحاولة',
                onPressed: _initController,
                color: kDGrey,
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
