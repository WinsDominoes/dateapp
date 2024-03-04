import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

const discordSVG = "assets/app_icons/external/Discord.svg";
const matrixSVG = "assets/app_icons/external/Matrix.svg";
const telegramSVG = "assets/app_icons/external/Telegram.svg";

Future<void> communityDialogBuilder(BuildContext context) {
  final colorMode = Theme.of(context).colorScheme.primary;
  final textTheme = Theme.of(context).textTheme;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Join our community!'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () async {
              await launchUrl(Uri.parse('https://discord.gg/WDxuJRsBPp'),
                  mode: LaunchMode.externalApplication);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SvgPicture.asset(
                    discordSVG,
                    semanticsLabel: 'Discord Logo',
                    colorFilter: ColorFilter.mode(colorMode, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Text('Discord',
                      style: TextStyle(fontSize: textTheme.bodyLarge?.fontSize),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              await launchUrl(
                  Uri.parse(
                      'https://matrix.to/#/#datecalc:matrix.winscloud.net'),
                  mode: LaunchMode.externalApplication);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SvgPicture.asset(
                    matrixSVG,
                    semanticsLabel: 'Matrix Logo',
                    colorFilter: ColorFilter.mode(colorMode, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Matrix',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: textTheme.bodyLarge?.fontSize),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              await launchUrl(Uri.parse('https://t.me/datecalc'),
                  mode: LaunchMode.externalApplication);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SvgPicture.asset(
                    telegramSVG,
                    semanticsLabel: 'Telegram Logo',
                    colorFilter: ColorFilter.mode(colorMode, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Text('Telegram',
                      style: TextStyle(fontSize: textTheme.bodyLarge?.fontSize),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
