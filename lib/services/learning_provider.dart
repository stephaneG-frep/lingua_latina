import 'package:flutter/material.dart';
import 'package:lingua_latina/data/mock_data.dart';
import 'package:lingua_latina/models/user_badge.dart';
import 'package:lingua_latina/services/local_storage_service.dart';

class LearningProvider extends ChangeNotifier {
  LearningProvider({required LocalStorageService storageService})
    : _storageService = storageService;

  final LocalStorageService _storageService;

  Set<String> _completedLessonIds = <String>{};
  int _totalScore = 0;
  String _userName = 'Discipulus';

  Set<String> get completedLessonIds => _completedLessonIds;
  int get totalScore => _totalScore;
  String get userName => _userName;

  int get completedLessonsCount => _completedLessonIds.length;

  double get overallProgress {
    if (mockLessons.isEmpty) return 0;
    return _completedLessonIds.length / mockLessons.length;
  }

  List<UserBadge> get earnedBadges {
    return availableBadges.where((badge) => _isBadgeEarned(badge.id)).toList();
  }

  Future<void> loadState() async {
    _completedLessonIds = _storageService.getCompletedLessonIds();
    _totalScore = _storageService.getTotalScore();
    _userName = _storageService.getUserName();
    notifyListeners();
  }

  bool isLessonCompleted(String lessonId) {
    return _completedLessonIds.contains(lessonId);
  }

  Future<void> markLessonCompleted(String lessonId) async {
    if (_completedLessonIds.contains(lessonId)) return;
    _completedLessonIds = {..._completedLessonIds, lessonId};
    await _storageService.saveCompletedLessonIds(_completedLessonIds);
    notifyListeners();
  }

  Future<void> addQuizScore(int score) async {
    _totalScore += score;
    await _storageService.saveTotalScore(_totalScore);
    notifyListeners();
  }

  Future<void> updateUserName(String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    _userName = trimmed;
    await _storageService.saveUserName(_userName);
    notifyListeners();
  }

  bool _isBadgeEarned(String badgeId) {
    switch (badgeId) {
      case 'prima_vox':
        return completedLessonsCount >= 1;
      case 'discipulus':
        return completedLessonsCount >= 3;
      case 'grammaticus':
        return completedLessonsCount >= mockLessons.length;
      case 'mentis_acies':
        return totalScore >= 40;
      default:
        return false;
    }
  }
}
