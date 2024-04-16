import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderController extends ChangeNotifier{
  bool isDB = true;
  List<String> notificationList = <String>[];

  void loadFromAPI() {
    isDB = false;
    notifyListeners();
  }

  void loadFromDB() {
    isDB = true;
    notifyListeners();
  }
}

//Provider
final loaderProvider = ChangeNotifierProvider<LoaderController>((ref) => LoaderController());
