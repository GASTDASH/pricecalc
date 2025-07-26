import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/settings/settings.dart';
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
                  onTap: () {
                    showBugReportDialog(context);
                  },
                ),
                SizedBox(height: 12),
                SettingCard(
                  icon: Icons.message_outlined,
                  title: "Связаться с нами",
                  onTap: () {
                    showContactDialog(context);
                  },
                ),
                SizedBox(height: 12),
                SettingCard(
                  icon: Icons.info_outline,
                  title: "О приложении",
                  onTap: () {
                    showAboutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future showAboutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => DialogCustom(
            title: "Прайс-Калькулятор",
            text:
                "Версия v1.0.3\n\nПриложение сделал GASTDASH ~ Щербаков Алексей Вадимович в 2025 году при поддержке JJSH",
          ),
    );
  }

  Future showContactDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => DialogCustom(
            title: "Обратная связь",
            text:
                "Вы можете написать разработчику о пожеланиях в приложении или спросить любой вопрос, касающийся приложения",
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: ButtonCustom(
                    text: "Telegram",
                    onTap: () async {
                      final Uri uri = Uri.parse("https://t.me/gastdash");
                      if (!await launchUrl(uri)) {
                        GetIt.I<Talker>().error(
                          "Не удалось открыть ссылку $uri",
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ButtonCustom(
                    text: "ВКонтакте",
                    onTap: () async {
                      final Uri uri = Uri.parse("https://vk.com/gastdash");
                      if (!await launchUrl(uri)) {
                        GetIt.I<Talker>().error(
                          "Не удалось открыть ссылку $uri",
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future showBugReportDialog(BuildContext context) {
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
