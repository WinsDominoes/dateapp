import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/gregorian_date.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    void showRangeDialog() async {
      final DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(0, 1, 1),
        lastDate: DateTime(3000, 12, 31),
        locale: const Locale('en', 'GB'),
        currentDate: DateTime.now(),
        saveText: 'Done',
      );

      if (result != null) {
        setState(() {
          _selectedDateRange = result;
        });
      }
    }

    final startDate = _selectedDateRange?.start ?? DateTime(2020, 1, 1);
    final endDate = _selectedDateRange?.end ?? DateTime(2022, 1, 1);

    int diffD = GregorianDate.differenceInDays(startDate, endDate);

    List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(diffD);

    dynamic startDateString =
        DateFormat("dd MMM yyyy").format(startDate).toString();
    dynamic endDateString =
        DateFormat("dd MMM yyyy").format(endDate).toString();

    return Scaffold(
      body: _selectedDateRange == null
          ? const Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child:
                    Text('Select the date range by using the calendar button'),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Dates",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const Text("Start Date", style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 5),
                    Text(
                      startDateString,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text("End Date", style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 5),
                    Text(endDateString,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    const Text("Difference",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const Text("Date Range", style: TextStyle(fontSize: 14)),
                    Text(
                        "${diffYMD[3]} days \n${diffYMD[2]} weeks \n${diffYMD[1]} months\n${diffYMD[0]} years",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Date Range in days",
                        style: TextStyle(fontSize: 14)),
                    Text("$diffD days",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
      // This button is used to show the date range picker
      floatingActionButton: FloatingActionButton(
        onPressed: showRangeDialog,
        child: const Icon(Icons.date_range),
      ),
    );
  }
}
