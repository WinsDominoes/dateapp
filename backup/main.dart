import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:dynamic_color/dynamic_color.dart';

import '../lib/utils/gregorian_date.dart';
import 'home.dart';


ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
);

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
);

void main() {
	runApp(MaterialApp(
			title: 'Date Calculator',
			theme: lightTheme,
			darkTheme: darkTheme,
			localizationsDelegates: const [
				GlobalMaterialLocalizations.delegate,
				GlobalWidgetsLocalizations.delegate,
				GlobalCupertinoLocalizations.delegate,
			],
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
		// This function will be triggered when the floating button is pressed
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
				// Rebuild the UI
				// print(result.start.toString());
				setState(() {
					_selectedDateRange = result;
				});
			}
		}

		final startDate = _selectedDateRange?.start ?? DateTime(2020, 1, 1);
		final endDate = _selectedDateRange?.end ?? DateTime(2022, 1, 1);

		GregorianDate customDate = new GregorianDate();

		List<int> diffYMD =
				GregorianDate.differenceInYearsMonthsDays(startDate, endDate);
		List<int> diffMD = GregorianDate.differenceInMonths(startDate, endDate);
		int diffD = GregorianDate.differenceInDays(startDate, endDate);

		return Scaffold(
			drawer: Drawer(
				// column holds all the widgets in the drawer
				child: Column(
					children: <Widget>[
						Expanded(
							// ListView contains a group of widgets that scroll inside the drawer
							child: ListView(),
						),
						// This container holds the align
						Container(
								// This align moves the children to the bottom
								child: Align(
										alignment: FractionalOffset.bottomCenter,
										// This container holds all the children that will be aligned
										// on the bottom and should not scroll with the above ListView
										child: Container(
												child: const Column(
											children: <Widget>[
												Divider(),
												/* ListTile(
													leading: Icon(Icons.settings),
													title: Text('Settings')), */
												ListTile(
														leading: Icon(Icons.favorite),
														title: Text('Authors: Win & Amy')),
												ListTile(
														leading: Icon(Icons.description),
														title: Text('LGPL-2.1 license')),
												ListTile(
														leading: Icon(Icons.info),
														title: Text('Version: v0.0.1'))
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
