import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/core/utils/details.dart';

class LanguageController extends ChangeNotifier {
  String lang = 'en';

  void setEnglish() {
    lang = 'en';
    notifyListeners();
  }

  void setFrench() {
    lang = 'fr';
    notifyListeners();
  }
}