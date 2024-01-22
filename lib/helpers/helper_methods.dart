class HelperMethods {
  static String currentMonthAsString(DateTime dateTime) {
    final int currentMonth = dateTime.month;

    switch (currentMonth) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'Aprils';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  static String currentDayOfWeekAsString(DateTime dateTime) {
    final int dayOfWeek = dateTime.weekday;

    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  static String timeToShow(DateTime dateTime) {
    String hourToShow = "00:00:00";

    final int hour = dateTime.hour;
    final int minutes = dateTime.minute;
    final int seconds = dateTime.second;

    String hh = "00";
    String mm = "00";
    String ss = "00";

    if (hour == 0) {
    } else if (hour >= 1 && hour <= 9) {
      hh = "0$hour";
    } else {
      hh = hour.toString();
    }

    if (minutes == 0) {
    } else if (minutes >= 1 && minutes <= 9) {
      mm = "0$minutes";
    } else {
      mm = minutes.toString();
    }

    if (seconds == 0) {
    } else if (seconds >= 1 && seconds <= 9) {
      ss = "0$seconds";
    } else {
      ss = seconds.toString();
    }

    hourToShow = "$hh:$mm:$ss";

    return hourToShow;
  }

  static String differenceToShow(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
