import 'package:get/get.dart';
import 'package:twitter_ui/model/language.dart';

class LanguageController extends GetxController {
  var language = "en".obs;

  final LanguageModel _languageModel = LanguageModel();

  LanguageModel get languageModel => _languageModel;

  void changeLang(String lang){
    language.value = lang;
    _languageModel.setLang(lang);
    update();
  }
}