// ignore_for_file: constant_identifier_names, duplicate_ignore

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
  // ignore: constant_identifier_names
  BLENDING, // دمج الأصوات
  // ignore: constant_identifier_names
  SEGMENTATION, // تجزئة الكلمات
  // ignore: constant_identifier_names
  DELETION, // حذف الأصوات
  SUBSTITUTION, // استبدال الأصوات
  RHYMING // القوافي
}
