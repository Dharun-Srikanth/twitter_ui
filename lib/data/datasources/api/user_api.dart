import 'dart:convert';

import 'package:get/get.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_ui/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_ui/presentation/providers/data_controller.dart';


@riverpod
Future<List<User>> fetchUser() async {
  final response =
  await http.get(Uri.parse('https://dummyjson.com/users?limit=100'));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    List<dynamic> values = jsonData['users'];
    List<User> userList = [];
    if (values.isNotEmpty) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          // Get.find<DataController>().addUserData(User.fromJson(map));
          // _users.add(User.fromJson(map));
          userList.add(User.fromJson(map));
        }
      }
    }
    // loadMore;
    return userList;
  } else {
    throw Exception("Failed to load users");
  }
}