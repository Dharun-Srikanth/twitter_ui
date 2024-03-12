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
        padding: EdgeInsets.all(0),
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black
            ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(loggedInUser!.name, style: TextStyle(fontSize: 18),),
                  accountEmail: Text("@"+loggedInUser!.username, style: TextStyle(color: Colors.grey, fontSize: 16),),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person),
                ),
              ),)
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            onTap: (){
              Navigator.pushNamed(context, "profile");
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Settings"),
            onTap: (){
              Navigator.pushNamed(context, "settings");
            },
          ),
          Divider(),
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
