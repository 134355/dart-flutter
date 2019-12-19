class StringUtils {
  /// 字符串反转
  static String reverse(String text) {
    if (text == null) return "";
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }

    return sb.toString();
  } 

  /// 每隔 digit位 加 pattern
  static String patternLeft(String text, { int digit = 4, String pattern = ' '}) {
    if (text == null) return "";

    text = text.replaceAllMapped(RegExp(".{$digit}"), (Match match) {
      return "${match.group(0)}$pattern";
    });

    if (text.endsWith(pattern)) {
      text = text.substring(0, text.length - pattern.length);
    }

    return text;
  }

  /// 每隔 digit位 加 pattern
  static String patternRight(String text, { int digit = 4, String pattern = ' '}) {
    text = reverse(text);
    text = patternLeft(text, digit: digit, pattern: pattern);
    text = reverse(text);

    return text;
  }
  
  /// 隐藏指定范围的文字
  static String replaceRangeText(String text, { int start = 3, int end = 7, String repText = "****" }) {
    if (text == null) return "";
    return text.replaceRange(start, end, repText);
  }
}
