import 'package:flutter/material.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/presentation/page/about.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerDesign extends StatelessWidget {
  const DrawerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                child: UserAccountsDrawerHeader(
                  currentAccountPictureSize: const Size(80, 80),
                  decoration: const BoxDecoration(color: Colors.black),
                  accountName: Text(
                    loggedInUser!.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(
                    "@${loggedInUser!.username}",
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    foregroundImage: AssetImage('assets/ME.jpg'),
                    child: Icon(Icons.person),
                  ),
                )),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(AppLocalizations.of(context)!.profile),
            onTap: () {
              Navigator.pushNamed(context, "profile");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              Navigator.pushNamed(context, "settings");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
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
    );
  }
}
