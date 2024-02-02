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

      if(pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
		}

    final pickedDate = _selectedDate ?? DateTime.now();
		// List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(DateTime.now(), pickedDate);
    int diffD = GregorianDate.differenceInDays(DateTime.now(), pickedDate);
    List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(diffD);

    if(pickedDate.isBefore(DateTime.now())) {
      period = "in the past";
    } else {
      period = "to the future";
    }

    dynamic pickedDateString = DateFormat("EEEE, d MMM yyyy").format(pickedDate).toString();
    dynamic todayString = DateFormat("EEEE, d MMM yyyy").format(DateTime.now()).toString();

		return Scaffold(
			appBar: AppBar(
				title: const Text("Day Calculator"),
				elevation: 4,
				shadowColor: Theme.of(context).shadowColor,
			),
			body: _selectedDate == null
					? const Padding(
              padding: EdgeInsets.all(30) ,
              child: Center(
                child: Text('Select the date by using the date picker button'),
              ),
          ) 
          
					: Padding(
							padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dates",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      )
                    ),

                    const Text(
                      "Chosen Date", 
                      style: TextStyle(fontSize: 14)
                    ),
                    Text(
                      pickedDateString,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Today", 
                      style: TextStyle(fontSize: 14)
                    ),
                    Text(
                      todayString,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Difference",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      )
                    ),

                    Text(
                      pickedDateString, 
                      style: const TextStyle(fontSize: 14)
                    ),
                    Text(
                      "${diffYMD[3]} days \n${diffYMD[2]} weeks \n${diffYMD[1]} months\n${diffYMD[0]} years",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      period, 
                      style: const TextStyle(fontSize: 14)
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Or in total is", 
                      style: TextStyle(fontSize: 14)
                    ),
                    Text("$diffD days $period", 
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
              )
						),
			// This button is used to show the date range picker
			floatingActionButton: FloatingActionButton(
				onPressed: showDateDialog,
				child: const Icon(Icons.today),
			),
		);
	}
}