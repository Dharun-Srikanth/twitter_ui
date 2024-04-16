import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:twitter_ui/presentation/providers/language_controller.dart';
import 'package:twitter_ui/presentation/providers/loader_provider.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 32,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.dataLoad,
                style: const TextStyle(fontSize: 20),
              ),
              ListTile(
                leading: const Icon(Icons.data_saver_off_outlined),
                title: Text(AppLocalizations.of(context)!.dbLoad),
                onTap: () {
                  ref.read(loaderProvider).loadFromDB();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.data_saver_off_outlined),
                title: Text(AppLocalizations.of(context)!.apiLoad),
                onTap: () {
                  ref.read(loaderProvider).loadFromAPI();
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(fontSize: 20),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.en),
                onTap: () {
                  ref.read(langProvider).setEnglish();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.fr),
                onTap: () {
                  ref.read(langProvider).setFrench();
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppLaunchPage()),
                      (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
