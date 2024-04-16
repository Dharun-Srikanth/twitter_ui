import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/core/utils/controller.dart';
import 'package:twitter_ui/domain/models/user_model.dart';
import 'package:twitter_ui/presentation/providers/data_controller.dart';

class SearchPageDesign extends StatefulWidget {
  const SearchPageDesign({super.key});

  @override
  State<SearchPageDesign> createState() => _SearchPageDesignState();
}

class _SearchPageDesignState extends State<SearchPageDesign> {
  @override
  void initState() {
    super.initState();
    constDataController.setFilteredUsers();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
      builder: (controller) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.filteredUsers.length,
            itemBuilder: (context, index) {
              return userDesign(controller.filteredUsers[index]);
            });
      },
    );
  }

  Widget userDesign(UserModel user) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey.shade800, width: 0.5))),
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    foregroundImage: AssetImage("assets/profile.png"),
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Icon(
                    Icons.verified,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "@${user.username}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  )
                ])));
  }
}
