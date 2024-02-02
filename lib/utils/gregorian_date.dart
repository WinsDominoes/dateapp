class GregorianDate {
  static bool leapYear(DateTime date) {
    if(date.year%4 == 0) {
      if(date.year%100 == 0){
        return date.year%400 == 0;
      }
      return true;
    }
    return false;
  }

  static List<int> differenceInYearsMonthsDays(int totalDays) {
    // Define constants
    const int daysInYear = 365;
    const int daysInLeapYear = 366;
    final List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    int years = totalDays ~/ daysInYear;
    int remainingDays = totalDays % daysInYear;

    int daysInCurrentYear = (years % 4 == 0 && (years % 100 != 0 || years % 400 == 0))
        ? daysInLeapYear
        : daysInYear;

    int months = 0;
    for (int i = 0; i < daysInMonth.length; i++) {
      if (remainingDays < daysInMonth[i]) {
        months = i;
        break;
      }
      remainingDays -= daysInMonth[i];
    }

    int weeks = remainingDays ~/ 7;
    remainingDays %= 7;

    return [years, months, weeks, remainingDays];
  }

  static int differenceInDays(DateTime dt1, DateTime dt2) {
    if(dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    } 
    return dt2.difference(dt1).inDays;
  }
}