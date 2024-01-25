import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
       home: Home()
  ));
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

class Home extends  StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTimeRange? _selectedDateRange;

  // This function will be triggered when the floating button is pressed
  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      // print(result.start.toString());
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  Duration daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
     return to.difference(from);
  }

  @override
  Widget build(BuildContext context) {
    final startDate = _selectedDateRange?.start ?? DateTime(2020, 1, 1);
    final endDate= _selectedDateRange?.end ?? DateTime(2022, 1, 1);
    final difference = daysBetween(
      DateTime.parse(startDate.toString()),
      DateTime.parse(endDate.toString())
    );

    int diffDays = difference.inDays;
    int diffHours = difference.inHours % 24;
    int diffMinutes = difference.inMinutes % 60;
    int diffSeconds = difference.inSeconds % 60;

    return Scaffold(
         appBar: AppBar(
            title: 
              const 
                Text(
                  "Date App", 
                  style: TextStyle(color: Colors.white),
                ), 
            backgroundColor: Colors.blueAccent,
         ),
          body: _selectedDateRange == null
            ? const Center(
                child: Text('Press the button to show the picker'),
              )
            : Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${startDate.toString().split(' ')[0]}",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    
                    Text(
                        "${endDate.toString().split(' ')[0]}",
                        style: const TextStyle(fontSize: 14, color: Colors.black)),
                    
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                        "Difference: $diffDays day(s) - $diffHours hour(s) - $diffMinutes minute(s) - $diffSeconds second(s)",
                        style: const TextStyle(fontSize: 24, color: Colors.black))
                  ],
                ),
              ),
          // This button is used to show the date range picker
          floatingActionButton: FloatingActionButton(
            onPressed: _show,
            child: const Icon(Icons.date_range),
          ),
      );
  }
}