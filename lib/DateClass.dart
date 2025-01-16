class Date {
  int year;
  int month;
  int day;

  Date({required this.year, required this.month, required this.day});

  @override
  String toString() {
    int lastdigit = day % 10;
    String afterDay = "";
    if (day == 11 ||
        day == 12 ||
        day == 13 ||
        lastdigit >= 4 ||
        lastdigit == 0) {
      afterDay = "th";
    } else if (lastdigit == 1) {
      afterDay = "st";
    } else if (lastdigit == 2) {
      afterDay = "nd";
    } else {
      afterDay = "rd";
    }

    String months = "";
    if (month == 1) {
      months = "January";
    } else if (month == 2) {
      months = "February";
    } else if (month == 3) {
      months = "March";
    } else if (month == 4) {
      months = "April";
    } else if (month == 5) {
      months = "May";
    } else if (month == 6) {
      months = "June";
    } else if (month == 7) {
      months = "July";
    } else if (month == 8) {
      months = "August";
    } else if (month == 9) {
      months = "September";
    } else if (month == 10) {
      months = "October";
    } else if (month == 11) {
      months = "November";
    } else {
      months = "December";
    }

    return "$day$afterDay $months, $year";
  }
}
