import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils/gregorian_date.dart';

void main() {
	runApp(MaterialApp(
			title: 'Date Calculator',
			theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
			darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
			supportedLocales: const [
				Locale('en', 'GB'), // English, UK
				Locale('ar', 'AE'), // Arabic, UAE
				Locale('en', 'IN'), // English, India
			],
			home: Home()));
}

class Home extends StatefulWidget {
	@override
	State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
	DateTimeRange? _selectedDateRange;

	@override
	Widget build(BuildContext context) {
		void _show() async {
			final DateTimeRange? result = await showDateRangePicker(
				context: context,
				firstDate: DateTime(1970, 1, 1),
				lastDate: DateTime(2030, 12, 31),
				locale: const Locale("en", "GB"),
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

		GregorianDate customDate = new GregorianDate();

		List<int> diffYMD = GregorianDate.differenceInYearsMonthsDays(startDate, endDate);
		List<int> diffMD = GregorianDate.differenceInMonths(startDate, endDate);
		int diffD = GregorianDate.differenceInDays(startDate, endDate);

		return Scaffold(
			drawer: Drawer(
				child: Column(
					children: <Widget>[
						Expanded(
							child: ListView(),
						),
						Container(
								child: Align(
										alignment: FractionalOffset.bottomCenter,
										child: Container(
												child: const Column(
											children: <Widget>[
												Divider(),
												ListTile(
														leading: Icon(Icons.favorite),
														title: Text('Authors: Win & Amy')),
												ListTile(
														leading: Icon(Icons.description),
														title: Text('LGPL-2.1 license')),
												ListTile(
														leading: Icon(Icons.info),
														title: Text('Version: v0.0.2'))
											],
										))))
					],
				),
			),
			appBar: AppBar(
				title: const Text("Date Calculator"),
				elevation: 4,
				shadowColor: Theme.of(context).shadowColor,
			),
			body: _selectedDateRange == null
					? const Center(
							child: Text('Select the date range by using the calendar button'),
						)
					: Padding(
							padding: const EdgeInsets.all(30),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										"First Date: ${DateFormat("dd/MM/yyyy").format(startDate).toString().split(' ')[0]}",
										style: const TextStyle(fontSize: 24),
									),
									const SizedBox(
										height: 20,
									),
									Text(
											"Second Date: ${DateFormat("dd/MM/yyyy").format(endDate).toString().split(' ')[0]}",
											style: const TextStyle(fontSize: 24)),
									const SizedBox(
										height: 20,
									),
									Text("${diffYMD[3]} day(s)",
											style: const TextStyle(fontSize: 24)),
									const SizedBox(
										height: 10,
									),
									Text("${diffYMD[2]} week(s)",
											style: const TextStyle(fontSize: 24)),
									const SizedBox(
										height: 10,
									),
									Text("${diffYMD[1]} month(s)",
											style: const TextStyle(fontSize: 24)),
									const SizedBox(
										height: 10,
									),
									Text("${diffYMD[0]} year(s)",
											style: const TextStyle(fontSize: 24)),
									const SizedBox(
										height: 20,
									),
									Text("Total Days: ${diffD}",
											style: const TextStyle(fontSize: 24)),
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
