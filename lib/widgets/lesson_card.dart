import 'package:flutter/material.dart';
import 'package:lingua_latina/models/lesson.dart';
import 'package:lingua_latina/theme/app_theme.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
    required this.progress,
    required this.isCompleted,
    required this.onTap,
  });

  final Lesson lesson;
  final double progress;
  final bool isCompleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      lesson.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (isCompleted)
                    const Icon(Icons.verified_rounded, color: AppTheme.bordeaux),
                ],
              ),
              const SizedBox(height: 8),
              Text(lesson.level, style: const TextStyle(color: AppTheme.bordeaux)),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppTheme.softGold.withValues(alpha: 0.25),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.bordeaux),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${(progress * 100).toInt()}% progression',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
