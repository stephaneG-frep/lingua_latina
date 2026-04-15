import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _completedLessonsKey = 'completed_lessons';
  static const _totalScoreKey = 'total_score';
  static const _userNameKey = 'user_name';

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
}
