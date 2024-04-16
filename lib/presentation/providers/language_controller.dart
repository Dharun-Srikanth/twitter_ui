import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// Provider
final langProvider = ChangeNotifierProvider<LanguageController>((ref) => LanguageController());
