import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

const discordSVG = "assets/app_icons/external/Discord.svg";
const matrixSVG = "assets/app_icons/external/Matrix.svg";
const telegramSVG = "assets/app_icons/external/Telegram.svg";

Future<void> communityDialogBuilder(BuildContext context) {
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
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
                const Expanded(
                  child: Text('Discord', textAlign: TextAlign.center),
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
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
                const Expanded(
                  child: Text('Matrix', textAlign: TextAlign.center),
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
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
                const Expanded(
                  child: Text('Telegram', textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
