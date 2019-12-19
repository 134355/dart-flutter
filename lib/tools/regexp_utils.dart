class RegExpUtils {

  static String regexpMobile = "^(1[3-9])\\d{9}\$";
  static final String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
  static final String regexIdCard15 = "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}\$";
  static final String regexIdCard18 = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9Xx])\$";

  static bool match(String regexp, String text) {
    if (text == null) return false;
    return RegExp(regexp).hasMatch(text);
  }

  static bool isMobile(String text) {
    return match(regexpMobile, text);
  }

  static bool isEmail(String text) {
    return match(regexEmail, text);
  }

  static bool isIDCard(String text) {
    if (text != null && text.length == 15) {
      return match(regexEmail, text);
    }
    if (text != null && text.length == 18) {
      return match(regexEmail, text);
    }
    return false;
  }
}
