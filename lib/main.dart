import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'calendar.dart';
import 'day.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

	static final _defaultLightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue);
	static final _defaultDarkColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
		return DynamicColorBuilder (
			builder: (lightColorScheme, darkColorScheme) {
				return MaterialApp(
					theme: ThemeData(
						colorScheme: lightColorScheme ?? _defaultLightColorScheme,
						useMaterial3: true,
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: Colors.black.withOpacity(0.03)
            ),
					),
					darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
						useMaterial3: true,
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: Colors.white.withOpacity(0.03)
            ),
					),
					home: const MyHomePage(),
				);		
			},
		);
  }
}

class MyHomePage extends StatefulWidget {
  /// Creates a const [MyHomePage].
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
      useDrawer: false,
      selectedIndex: _selectedTab,
      onSelectedIndexChange: (int index) {
        setState(() {
          _selectedTab = index;
        });
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          selectedIcon: Icon(Icons.calendar_today),
          label: 'Day',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      body: (_) => _getScreen(context, _selectedTab),
      smallBody: (_) => _getScreen(context, _selectedTab),
      // Define a default secondaryBody.
      // Override the default secondaryBody during the smallBreakpoint to be
      // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
      // overridden.
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}

Widget _getScreen(BuildContext context, int index) {
  switch (index) {
    case 0:
      return const CalendarScreen();
    case 1:
      return const DayScreen();
    case 2:
      return const SettingsScreen();
    default:
      return const Text('Something went wrong');
  }
}