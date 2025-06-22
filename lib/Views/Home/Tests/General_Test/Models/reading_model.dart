class ReadingEvaluator {
  static int levenshteinDistance(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    List<List<int>> dp = List.generate(
      len1 + 1,
      (_) => List.filled(len2 + 1, 0),
    );

    for (int i = 0; i <= len1; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
      dp[0][j] = j;
    }

    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1, // حذف
          dp[i][j - 1] + 1, // إضافة
          dp[i - 1][j - 1] + cost, // تبديل
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[len1][len2];
  }

  static double calculateSimilarity(String a, String b) {
    // إزالة علامات الترقيم والمسافات الزائدة
    final normalizedA = a.replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), '').trim();
    final normalizedB = b.replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), '').trim();

    final distance = levenshteinDistance(normalizedA, normalizedB);
    final maxLength = normalizedA.isNotEmpty ? normalizedA.length : 1;

    return 1.0 - (distance / maxLength);
  }

  static String getLevel(double similarity) {
    if (similarity >= 0.9) return "مستواك ممتاز ✅";
    if (similarity >= 0.7) return "مستواك متوسط ⚠️";
    return "مستواك ضعيف ❌";
  }
}
