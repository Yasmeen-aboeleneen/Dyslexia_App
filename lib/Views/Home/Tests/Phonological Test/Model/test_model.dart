class PhonemeExercise {
  final String instruction;
  final String? targetWord;
  final List<String>? options;
  final String correctAnswer;
  final ExerciseType type;
  final String soundPrompt;

  PhonemeExercise({
    required this.instruction,
    this.targetWord,
    this.options,
    required this.correctAnswer,
    required this.type,
    required this.soundPrompt,
  });
}

enum ExerciseType {
  BLENDING, // دمج الأصوات
  SEGMENTATION, // تجزئة الكلمات
  DELETION, // حذف الأصوات
  SUBSTITUTION, // استبدال الأصوات
  RHYMING // القوافي
}
