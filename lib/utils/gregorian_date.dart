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

  /* static List<int> differenceInYearsMonthsDays(DateTime dt1, DateTime dt2) {
    List<int> simpleYear = [31,28,31,30,31,30,31,31,30,31,30,31];
    if(dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    }
    int totalMonthsDifference = ((dt2.year*12) + (dt2.month - 1)) - ((dt1.year*12) + (dt1.month - 1));
    int years = (totalMonthsDifference/12).floor();
    int months = totalMonthsDifference%12;
    late int days;
    if(dt2.day >= dt1.day) {days = dt2.day - dt1.day;}
    else {
      int monthDays = dt2.month == 3
          ? (leapYear(dt2)? 29: 28)
          : (dt2.month - 2 == -1? simpleYear[11]: simpleYear[dt2.month - 2]);
      int day = dt1.day;
      if(day > monthDays) day = monthDays;
      days = monthDays - (day - dt2.day);
      months--;
    }
    if(months < 0) {
      months = 11;
      years--;
    }
    int weeks = (months ~/ 4).toInt();
    return [years, months, weeks, days];
  } */

  static List<int> differenceInYearsMonthsDays(DateTime dt1, DateTime dt2) {
    List<int> simpleYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    if (dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    }

    int totalMonthsDifference = ((dt2.year * 12) + (dt2.month - 1)) - ((dt1.year * 12) + (dt1.month - 1));
    int years = (totalMonthsDifference / 12).floor();
    int months = totalMonthsDifference % 12;

    int daysInMonth1 = simpleYear[dt1.month - 1];

    int days;
    if (dt2.day >= dt1.day) {
      days = dt2.day - dt1.day;
    } else {
      int remainingDaysInMonth1 = daysInMonth1 - dt1.day;
      days = dt2.day + remainingDaysInMonth1;
      months--;

      if (months < 0) {
        months = 11;
        years--;
      }
    }

    int totalDays = (years * 365) + (months * 30) + days;
    int weeks = totalDays ~/ 7;
    days = totalDays % 7;

    return [years, months, weeks, days];
  }


  static List<int> differenceInMonths(DateTime dt1, DateTime dt2){
    List<int> inYears = differenceInYearsMonthsDays(dt1, dt2);
    int difMonths = (inYears[0]*12) + inYears[1];
    return [difMonths, inYears[2]];
  }

  static int differenceInDays(DateTime dt1, DateTime dt2) {
    if(dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    } 
    return dt2.difference(dt1).inDays + 1;
  }
}