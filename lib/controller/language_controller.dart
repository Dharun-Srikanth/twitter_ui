import 'package:get/get.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/model/language_model.dart';

class LanguageController extends GetxController {
  Rx<String> language = "en".obs;

  void changeLang(String lang) async{
    constDbHelper.updateLanguage(lang);
    setLang();
    print("Updated");
    update();
  }

  void setLang() async {
    language.value = (await constDbHelper.getLang()).lang;
    update();
  }
}