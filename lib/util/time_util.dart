import 'package:common_utils/common_utils.dart';

class TimeUtil {
  static String convert2Timeline(var s) {
    var dateTime = DateTime.parse(s);
    var res = TimelineUtil.formatByDateTime(dateTime,
        locDateTime: DateTime.now(), dayFormat: DayFormat.Full);
    return res;
  }
}
