class LanguageModel {
  String lang;

  LanguageModel(this.lang);

  factory LanguageModel.fromJson(Map<String, dynamic> langData){
    return LanguageModel(langData['language']);
  }
}