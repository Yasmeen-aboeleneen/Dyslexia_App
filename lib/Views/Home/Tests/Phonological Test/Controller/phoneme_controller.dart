import 'package:flutter_tts/flutter_tts.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological%20Test/Model/test_model.dart';

class PhonemeController {
  final FlutterTts tts = FlutterTts();
  final List<PhonemeExercise> _exercises = [
    PhonemeExercise(
      instruction: "ما الكلمة التي تتكون من الأصوات: م / و / ز؟",
      correctAnswer: "موز",
      type: ExerciseType.BLENDING,
      soundPrompt: "ما الكلمة التي تتكون من الأصوات: م / و / ز؟",
    ),
    PhonemeExercise(
      instruction: "ما الكلمة التي تتكون من الأصوات: ك / ت / ا / ب؟",
      correctAnswer: "كتاب",
      type: ExerciseType.BLENDING,
      soundPrompt: "ما الكلمة التي تتكون من الأصوات: ك / ت / ا / ب؟",
    ),
    PhonemeExercise(
      instruction: "قل 'قطة' بدون حرف القاف",
      targetWord: "قطة",
      correctAnswer: "طة",
      type: ExerciseType.DELETION,
      soundPrompt: "قل 'قطة' بدون حرف القاف",
    ),
    PhonemeExercise(
      instruction: "ما الذي يبقى إذا حذفنا حرف الشين من 'شمس'؟",
      targetWord: "شمس",
      correctAnswer: "مس",
      type: ExerciseType.DELETION,
      soundPrompt: "ما الذي يبقى إذا حذفنا حرف الشين من 'شمس'؟",
    ),
  ];

  int _currentIndex = 0;
  int _score = 0;

  Future<void> speakExercise(PhonemeExercise exercise) async {
    await tts.setLanguage("ar-SA");
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.5);

    if (exercise.type == ExerciseType.BLENDING) {
      await tts.speak(exercise.soundPrompt);
    } else {
      await tts.speak("${exercise.instruction}. ${exercise.soundPrompt}");
    }
  }

  PhonemeExercise get currentExercise => _exercises[_currentIndex];
  int get currentIndex => _currentIndex;
  set currentIndex(int value) => _currentIndex = value;
  int get score => _score;
  int get totalExercises => _exercises.length;

  bool checkAnswer(String userAnswer) {
    final isCorrect = userAnswer.trim() == currentExercise.correctAnswer;
    if (isCorrect) _score++;
    return isCorrect;
  }

  bool moveToNext() {
    if (!isLastExercise) {
      currentIndex++;
      return true;
    }
    return false;
  }

  void reset() {
    _currentIndex = 0;
    _score = 0;
  }

  bool get isLastExercise => _currentIndex == _exercises.length - 1;
  bool get isFirstExercise => _currentIndex == 0;
}
