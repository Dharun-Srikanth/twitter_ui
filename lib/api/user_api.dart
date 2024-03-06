import 'dart:convert';

import 'package:get/get.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_ui/widgets/tweets_layout.dart';

// Future<List<User>> fetchUser() async {
//   final response =
//   await http.get(Uri.parse('https://dummyjson.com/users?limit=100'));
//   if (response.statusCode == 200) {
//     var jsonData = jsonDecode(response.body);
//     List<dynamic> values = jsonData['users'];
//     if (values.isNotEmpty) {
//       for (int i = 0; i < values.length; i++) {
//         if (values[i] != null) {
//           Map<String, dynamic> map = values[i];
//           Get.find<DataController>().addUserData(User.fromJson(map));
//           // _users.add(User.fromJson(map));
//         }
//       }
//     }
//     // loadMore;
//     return DataController().userList;
//   } else {
//     throw Exception("Failed to load users");
//   }
// }