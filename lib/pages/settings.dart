import 'package:flutter/material.dart';
import '../widgets/license.dart';
import '../constants/info.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 4,
        shadowColor: Theme.of(context).shadowColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemBuilder: (context, index) => const _ListItem(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => _dialogBuilder(context),
                borderRadius: BorderRadius.circular(10.0),
                child: const ListTile(
                  leading: Icon(Icons.info_outlined),
                  title: Text("About"),
                ),
              ))
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Some Button"),
        ),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: ExactAssetImage('assets/app_icons/icon.png')
                )
              ),
            ),
            Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date Calculator"),
                  Text(
                    "v$versionString",
                    style: TextStyle(
                      fontSize: 14
                    )
                  ),
                ],
              ),
            )
          ]
        ),
        content: const Text(
          'Date Calculator by WinsDominoes and AtiusAmy'
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('View Licenses'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LicensePageCustom()));
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

