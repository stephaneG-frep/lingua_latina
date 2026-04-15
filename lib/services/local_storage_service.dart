import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _completedLessonsKey = 'completed_lessons';
  static const _totalScoreKey = 'total_score';
  static const _userNameKey = 'user_name';
  static const _favoriteWordsKey = 'favorite_words';
  static const _darkModeEnabledKey = 'dark_mode_enabled';

  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Set<String> getCompletedLessonIds() {
    return _preferences.getStringList(_completedLessonsKey)?.toSet() ?? <String>{};
  }

  Future<void> saveCompletedLessonIds(Set<String> ids) async {
    await _preferences.setStringList(_completedLessonsKey, ids.toList());
  }

  int getTotalScore() {
    return _preferences.getInt(_totalScoreKey) ?? 0;
  }

  Future<void> saveTotalScore(int score) async {
    await _preferences.setInt(_totalScoreKey, score);
  }

  String getUserName() {
    return _preferences.getString(_userNameKey) ?? 'Discipulus';
  }

  Future<void> saveUserName(String value) async {
    await _preferences.setString(_userNameKey, value);
  }

  Set<String> getFavoriteWords() {
    return _preferences.getStringList(_favoriteWordsKey)?.toSet() ?? <String>{};
  }

  Future<void> saveFavoriteWords(Set<String> words) async {
    await _preferences.setStringList(_favoriteWordsKey, words.toList());
  }

  bool getDarkModeEnabled() {
    return _preferences.getBool(_darkModeEnabledKey) ?? false;
  }

  Future<void> saveDarkModeEnabled(bool enabled) async {
    await _preferences.setBool(_darkModeEnabledKey, enabled);
  }
}
