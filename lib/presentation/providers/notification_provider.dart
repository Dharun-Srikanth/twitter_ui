import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationController extends ChangeNotifier{
  List<String> notificationList = <String>[];

  void addNotifications(String content) {
    notificationList.insert(0, content);
    notifyListeners();
  }
}

//Provider
final notificationProvider = ChangeNotifierProvider<NotificationController>((ref) => NotificationController());
