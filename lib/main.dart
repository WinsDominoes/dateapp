import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/calendar.dart';
import 'pages/day.dart';
import 'pages/settings.dart';

import 'utils/scroll.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color fallbackColorSchemeSeed = Colors.blue;

    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        lightColorScheme = lightDynamic.harmonized();
        darkColorScheme = darkDynamic.harmonized();
      } else {
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: fallbackColorSchemeSeed,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: fallbackColorSchemeSeed,
          brightness: Brightness.dark,
        );
      }

      ThemeData lightTheme = ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
        navigationRailTheme: NavigationRailThemeData(
            backgroundColor: Colors.black.withOpacity(0.03)),
      );

      ThemeData darkTheme = ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        useMaterial3: true,
        navigationRailTheme: NavigationRailThemeData(
            backgroundColor: Colors.white.withOpacity(0.03)),
      );

      return MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        themeMode: ThemeMode.system,
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
        home: const MyHomePage(),
      );
    });
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
