

///判断是否为今天
class TimeUtils {
  static determineTime(String movieTime) {
    var dateTime = DateTime.now();
    if (movieTime.contains(dateTime.month.toString()) &&
        movieTime.contains(dateTime.day.toString())) {
      return true;
    }
    return false;
  }
}
