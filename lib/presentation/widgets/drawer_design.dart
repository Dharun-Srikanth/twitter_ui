import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/models/logged_in_details.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';

class DrawerDesign extends StatelessWidget {
  const DrawerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    LoggedInDetails loggedInDetails = LoggedInDetails();
    return Drawer(
      child: ListView(
        children: [
           SizedBox(
             height: 200,
             child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black
              ),
                child: UserAccountsDrawerHeader(
                  currentAccountPictureSize: const Size(80, 80),
                  decoration: const BoxDecoration(color: Colors.black),
                    accountName: Text(loggedInUser!.name, style: const TextStyle(fontSize: 18),),
                    accountEmail: Text("@${loggedInUser!.username}", style: const TextStyle(color: Colors.grey, fontSize: 16),),
                currentAccountPicture: const CircleAvatar(
                  foregroundImage: AssetImage('assets/ME.jpg'),
                  child: Icon(Icons.person),
                ),)
                       ),
           ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            onTap: (){
              Navigator.pushNamed(context, "profile");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Settings"),
            onTap: (){
              Navigator.pushNamed(context, "settings");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AppLaunchPage()), (route) => false);
            },
          )
        ],
      ),
    );
  }
}
