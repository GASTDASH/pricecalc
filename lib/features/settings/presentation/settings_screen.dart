import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/settings/presentation/widgets/setting_card.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text("Настройки")),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList.list(
              children: [
                SettingCard(
                  icon: Icons.bug_report_outlined,
                  title: "Сообщить об ошибке",
                  onTap: () async {
                    await showBugReportDialog(context);
                  },
                ),
                SizedBox(height: 12),
                SettingCard(
                  icon: Icons.info_outline,
                  title: "О приложении",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showBugReportDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => DialogCustom(
            title: "Отчёт об ошибке",
            text:
                "Приложение всё ещё в разработке, поэтому мы будем рады, если вы напишите об найденной ошибке. Мы попытаемся её исправить в кратчайшие сроки.",
            child: ButtonCustom(
              text: "Написать",
              onTap: () async {
                final Uri uri = Uri.parse(
                  "https://github.com/GASTDASH/pricecalc/issues",
                );
                if (!await launchUrl(uri)) {
                  GetIt.I<Talker>().error("Не удалось открыть ссылку $uri");
                }
              },
            ),
          ),
    );
  }
}
