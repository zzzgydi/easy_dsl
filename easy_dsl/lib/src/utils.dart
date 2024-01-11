import 'dart:math';

int easyEditDistance(List<String> str1, List<String> str2) {
  int len1 = str1.length;
  int len2 = str2.length;

  List<List<int>> dp = List.generate(
      len1 + 1, (i) => List.generate(len2 + 1, (j) => 0, growable: false),
      growable: false);

  for (int i = 0; i <= len1; i++) {
    for (int j = 0; j <= len2; j++) {
      if (i == 0) {
        dp[i][j] = j;
      } else if (j == 0) {
        dp[i][j] = i;
      } else if (str1[i - 1] == str2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = 1 + min(dp[i - 1][j], min(dp[i][j - 1], dp[i - 1][j - 1]));
      }
    }
  }

  return dp[len1][len2];
}
