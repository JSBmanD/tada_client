class DateHelper {
  static String getNormalizedTime(DateTime time) {
    final localTime = time.toLocal();
    return '${localTime.hour}:${(localTime.minute.toString().length == 1 ? '0' : '') + localTime.minute.toString()}';
  }
}
