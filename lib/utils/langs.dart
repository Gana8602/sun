enum AppLanguage { English, ARABIC }

/// Returns enum value name without enum class name.
String enumName(AppLanguage anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appLanguageData = {
  AppLanguage.English: {"value": "en", "name": "English", "locale": "en_US"},
  AppLanguage.ARABIC: {"value": "ar", "name": "Arabic", "locale": "ar_AE"},
};
