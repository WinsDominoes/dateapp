import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/gregorian_date.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({Key? key}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  DateTime? _selectedDate;
  dynamic period;

  @override
  Widget build(BuildContext context) {
    void showDateDialog() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2100),
        locale: const Locale("en", "GB"),
      );

      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    }

    final pickedDate = _selectedDate ?? DateTime.now();
    final textTheme = Theme.of(context).textTheme;

    // List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(DateTime.now(), pickedDate);
    int diffD = GregorianDate.differenceInDays(DateTime.now(), pickedDate);
    List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(diffD);

    if (pickedDate.isBefore(DateTime.now())) {
      period = "in the past";
    } else {
      period = "to the future";
    }

    dynamic pickedDateString =
        DateFormat("EEEE, d MMM yyyy").format(pickedDate).toString();

    return Scaffold(
      body: _selectedDate == null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.today_outlined,
                      size: 150,
                    ),
                    Text('Days From Now',
                        style: TextStyle(
                            fontSize: textTheme.displaySmall?.fontSize,
                            fontWeight: FontWeight.bold)),
                    Text('Select a date in the bottom right corner',
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
                        Text("Results",
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
                              Text(
                                "$pickedDateString is",
                                style: TextStyle(
                                    fontSize:
                                        textTheme.headlineSmall?.fontSize),
                              ),
                              Text(
                                  "${diffYMD[3]} days \n${diffYMD[2]} weeks \n${diffYMD[1]} months\n${diffYMD[0]} years",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.headlineMedium?.fontSize,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text("or in total of",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.titleMedium?.fontSize)),
                              Text("$diffD days $period",
                                  style: TextStyle(
                                      fontSize:
                                          textTheme.headlineMedium?.fontSize,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ))),
              ])),
      // This button is used to show the date range picker
      floatingActionButton: FloatingActionButton(
        onPressed: showDateDialog,
        child: const Icon(Icons.border_color_outlined),
      ),
    );
  }
}
