class Question {
  final String letter;
  final String hint;
  final List<String> similarLetters;

  Question({
    required this.letter,
    required this.hint,
    required this.similarLetters,
  });
}

class TestResult {
  final int score;
  final int totalQuestions;

  TestResult({
    required this.score,
    required this.totalQuestions,
  });

  double get percentage => (score / totalQuestions) * 100;
}