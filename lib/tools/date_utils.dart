class DateUtils {
  /// 以日期字符串获取 [DateTime]
  static DateTime getDateTimeByStr(String dateStr, { bool isUtc = false }) {
    DateTime dateTime = DateTime.tryParse(dateStr);

    if (dateTime != null) {
      if (isUtc) {
        dateTime = dateTime.toUtc();
      } else {
        dateTime = dateTime.toLocal();
      }
    }

    return dateTime;
  }

  /// 以毫秒为单位获取 [DateTime] 
  static DateTime getDateTimeByMs(int milliseconds, { bool isUtc = false }) {
    return milliseconds == null ? null : DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
  }

  /// 通过 [DateTime] 格式化日期
  static String formatDate(DateTime dateTime, { String format = "yyyy/MM/dd HH:mm:ss" }) {
    if (dateTime == null) return "";

    Map<String, String> contrastTable = {
      "M+": dateTime.month.toString().padLeft(2, '0'),
      "d+": dateTime.day.toString().padLeft(2, '0'),
      "H+": dateTime.hour.toString().padLeft(2, '0'),
      "m+": dateTime.minute.toString().padLeft(2, '0'),
      "s+": dateTime.second.toString().padLeft(2, '0'),
      "S+": dateTime.millisecond.toString().padLeft(3, '0'),
    };

    var func = (String key, String value) {
      Iterable<Match> i = RegExp(key).allMatches(format);

      if (i != null) {
        for (Match m in i) {
          String match = m.group(0);
          format = format.replaceAll(match, value);
        }
      }
    };

    func("y+", dateTime.year.toString());
    contrastTable.forEach(func);

    return format;
  }

  /// 通过字符串格式化日期
  static String formatDateStr(String dateStr, { String format, bool isUtc = false }) {
    return formatDate(getDateTimeByStr(dateStr, isUtc: isUtc), format: format);
  }

  /// 通过毫秒为单位格式化日期
  static String formatDateMs(int milliseconds, { String format, bool isUtc = false }) {
    return formatDate(getDateTimeByMs(milliseconds, isUtc: isUtc), format: format);
  }

  /// 通过 [DateTime] 获取星期几
  static String getWeekDay(DateTime dateTime, { List<String> weekList }) {
    if (dateTime == null) return "";
    if (weekList == null) {
      weekList = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    }
    String weekday;
    weekday = weekList[dateTime.weekday - 1];
    return weekday;
  }

  /// 通过字符串获取星期几
  static String getWeekDayByStr(String dateStr, { List<String> weekList, bool isUtc = false }) {
    DateTime dateTime = getDateTimeByStr(dateStr, isUtc: isUtc);
    return getWeekDay(dateTime, weekList: weekList);
  }

  /// 通过毫秒获取星期几
  static String getWeekDayByMs(int milliseconds, { List<String> weekList, bool isUtc = false }) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekDay(dateTime, weekList: weekList);
  }

  /// 通过 [DateTime] 获取第几季度
  static String getQuarter(DateTime dateTime, { List<String> quarterList }) {
    if (dateTime == null) return "";
    if (quarterList == null) {
      quarterList = ["一季度", "二季度", "三季度", "四季度"];
    }
    String quarter;
    quarter = quarterList[dateTime.month ~/ 4];
    return quarter;
  }

  /// 通过字符串获取第几季度
  static String getQuarterByStr(String dateStr, { List<String> quarterList, isUtc = false }) {
    DateTime dateTime = getDateTimeByStr(dateStr, isUtc: isUtc);
    return getQuarter(dateTime, quarterList: quarterList);
  }

  /// 通过毫秒获取第几季度
  static String getQuarterByMs(int milliseconds,{ List<String> quarterList, isUtc = false }) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getQuarter(dateTime, quarterList: quarterList);
  }
}
