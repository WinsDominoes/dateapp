import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pages/calendar.dart';
import 'pages/day.dart';
import 'pages/settings.dart';

import 'utils/scroll.dart';

import 'constants/info.dart';

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
      );

      ThemeData darkTheme = ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        useMaterial3: true,
        navigationRailTheme: const NavigationRailThemeData(
            unselectedLabelTextStyle: TextStyle(fontSize: 13),
            selectedLabelTextStyle: TextStyle(fontSize: 13)),
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
    double screenWidth = MediaQuery.of(context).size.width;
    bool extendedValue = true;
    NavigationRailLabelType labelType = NavigationRailLabelType.none;
    Widget leading = const Visibility(
      visible: false,
      child: SizedBox.shrink(),
    );

    if (screenWidth >= 600 && screenWidth < 800) {
      extendedValue = false;
      labelType = NavigationRailLabelType.all;
    }

    if (screenWidth >= 800) {
      leading = Visibility(
        visible: true,
        child: Column(
          children: [
            SvgPicture.asset(iconPath, semanticsLabel: 'Date Calculator Logo'),
            const Text(
              "Date Calculator",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        bottomNavigationBar: MediaQuery.of(context).size.width < 600
            ? NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
                indicatorColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                selectedIndex: _selectedTab,
                destinations: const <Widget>[
                    NavigationDestination(
                      icon: Icon(Icons.date_range_outlined),
                      selectedIcon: Icon(Icons.date_range),
                      label: 'Range',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.today_outlined),
                      selectedIcon: Icon(Icons.today),
                      label: 'Day',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ])
            : null,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (MediaQuery.of(context).size.width >= 600)
              SafeArea(
                child: NavigationRail(
                  labelType: labelType,
                  elevation: 4,
                  leading: leading,
                  backgroundColor: ElevationOverlay.applySurfaceTint(
                      Theme.of(context).cardColor,
                      Theme.of(context).colorScheme.surfaceTint,
                      1),
                  extended: extendedValue,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.date_range_outlined),
                      selectedIcon: Icon(Icons.date_range),
                      label: Text('Range'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.today_outlined),
                      selectedIcon: Icon(Icons.today),
                      label: Text('Day'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                  selectedIndex: _selectedTab,
                  onDestinationSelected: (value) {
                    setState(() {
                      _selectedTab = value;
                    });
                  },
                ),
              ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: _getScreen(context, _selectedTab),
              ),
            ),
          ],
        ),
      );
    });
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
