import 'package:flutter/material.dart';
import '../constants/info.dart';

class LicensePageCustom extends StatefulWidget {
  @override
  _LicensePageCustomState createState() => _LicensePageCustomState();
}

class _LicensePageCustomState extends State<LicensePageCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LicensePage(
        applicationName: "Date Calculator",
        applicationVersion: "v$versionString",
        applicationIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: ExactAssetImage('assets/app_icons/icon.png')
                )
              ),
          )
        ),
      ),
    );
  }
}