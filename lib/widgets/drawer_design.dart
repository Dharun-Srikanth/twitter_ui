import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/model/logged_in_details.dart';

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
          ListTile(
            leading: const Icon(Icons.workspace_premium_outlined),
            title: const Text("Premium"),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.group_outlined),
            title: const Text("Communities"),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title: const Text("Lists"),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              Navigator.pushNamed(context, "launchPage");
            },
          )
        ],
      ),
    );
  }
}
