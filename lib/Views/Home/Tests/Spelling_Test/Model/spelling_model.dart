class SpellingWord {
  final String word;
  final String? hint;
  final List<String> acceptablePronunciations;

  SpellingWord({
    required this.word,
    this.hint,
    this.acceptablePronunciations = const [],
  });
}

class SpellingTestModel {
  List<SpellingWord> words = [
    SpellingWord(
      word: 'قلم',
      acceptablePronunciations: ['قلم', 'أقلام', 'قلَم'],
    ),
    SpellingWord(
      word: 'كتاب',
      acceptablePronunciations: ['كتاب', 'كُتُب', 'كتابي'],
    ),
    SpellingWord(word: 'مدرسة', acceptablePronunciations: ['مدرسة']),
    SpellingWord(word: 'شمس', acceptablePronunciations: ['شمس']),
    SpellingWord(word: 'بحر', acceptablePronunciations: ['بحر']),
  ];

  int currentIndex = 0;
  int score = 0;
  int attempts = 0;
  bool showHint = false;
}
