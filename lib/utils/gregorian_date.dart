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

    // Calculate years
    int years = totalDays ~/ daysInYear;
    int remainingDays = totalDays % daysInYear;

    // Check for leap year
    int daysInCurrentYear = (years % 4 == 0 && (years % 100 != 0 || years % 400 == 0))
        ? daysInLeapYear
        : daysInYear;

    // Calculate months
    int months = 0;
    for (int i = 0; i < daysInMonth.length; i++) {
      if (remainingDays < daysInMonth[i]) {
        months = i;
        break;
      }
      remainingDays -= daysInMonth[i];
    }

    // Calculate weeks
    int weeks = remainingDays ~/ 7;
    remainingDays %= 7;

    // Output the result
    print('$years years, $months months, $weeks weeks, and $remainingDays days');
    return [years, months, weeks, remainingDays];
  }

  /* static List<int> differenceInMonths(DateTime dt1, DateTime dt2){
    List<int> inYears = differenceInYearsMonthsDays(dt1, dt2);
    int difMonths = (inYears[0]*12) + inYears[1];
    return [difMonths, inYears[2]];
  } */

  static int differenceInDays(DateTime dt1, DateTime dt2) {
    if(dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    } 
    return dt2.difference(dt1).inDays;
  }
}