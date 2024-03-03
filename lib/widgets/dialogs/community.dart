import 'package:flutter/material.dart';
import '../license.dart';
import '../../constants/info.dart';

Future<void> communityDialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image: ExactAssetImage('assets/app_icons/icon.png'))),
          ),
          Container(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date Calculator"),
                Text("v$versionString", style: TextStyle(fontSize: 14)),
              ],
            ),
          )
        ]),
        content: const Text('Date Calculator by WinsDominoes and AtiusAmy'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('View Licenses'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LicensePageCustom()));
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
