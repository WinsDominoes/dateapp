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
    final textTheme = Theme.of(context).textTheme;

    int diffD = GregorianDate.differenceInDays(startDate, endDate);

    List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(diffD);

    dynamic startDateString =
        DateFormat("dd MMM yyyy").format(startDate).toString();
    dynamic endDateString =
        DateFormat("dd MMM yyyy").format(endDate).toString();

    return Scaffold(
      body: _selectedDateRange == null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.date_range_outlined,
                      size: 150,
                    ),
                    Text('Date Range',
                        style: TextStyle(
                            fontSize: textTheme.displaySmall?.fontSize,
                            fontWeight: FontWeight.bold)),
                    Text('Select a date range in the bottom right corner',
                        style: TextStyle(
                          fontSize: textTheme.bodyMedium?.fontSize,
                        ))
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text("Range",
                            style: TextStyle(
                                fontSize: textTheme.displayMedium?.fontSize,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
                Card(
                    elevation: 4,
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Full Format",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.titleMedium?.fontSize)),
                              Text(
                                  "${diffYMD[3]} days \n${diffYMD[2]} weeks \n${diffYMD[1]} months\n${diffYMD[0]} years",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.headlineMedium?.fontSize,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text("Days Format",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.titleMedium?.fontSize)),
                              Text("$diffD days",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.headlineMedium?.fontSize,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ))),
                const SizedBox(height: 16),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text("Dates",
                            style: TextStyle(
                                fontSize: textTheme.displaySmall?.fontSize,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Date",
                                style: TextStyle(
                                    fontSize: textTheme.titleMedium?.fontSize)),
                            Text(
                              startDateString,
                              style: TextStyle(
                                  fontSize: textTheme.headlineMedium?.fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text("End Date",
                                style: TextStyle(
                                    fontSize: textTheme.titleMedium?.fontSize)),
                            Text(endDateString,
                                style: TextStyle(
                                    fontSize:
                                        textTheme.headlineMedium?.fontSize,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                  ),
                )
              ])),
      // This button is used to show the date range picker
      floatingActionButton: FloatingActionButton(
        onPressed: showRangeDialog,
        child: const Icon(Icons.edit_calendar),
      ),
    );
  }
}
