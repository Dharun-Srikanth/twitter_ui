import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/controller/language_controller.dart';

TextEditingController addTweetController = TextEditingController();
TextEditingController addCommentController = TextEditingController();
TextEditingController regName = TextEditingController();
TextEditingController regUsername = TextEditingController();
TextEditingController regEmail = TextEditingController();
TextEditingController regPassword = TextEditingController();
TextEditingController regCfmPassword = TextEditingController();

// Form
final addTweetFormKey = GlobalKey<FormState>();
final addCommentFormKey = GlobalKey<FormState>();


// Data Controller (GetX)
final DataController constDataController = Get.find<DataController>();
final LanguageController constLangController = Get.find<LanguageController>();


