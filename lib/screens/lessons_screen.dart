import 'package:flutter/material.dart';
import 'package:lingua_latina/data/mock_data.dart';
import 'package:lingua_latina/screens/lesson_detail_screen.dart';
import 'package:lingua_latina/services/learning_provider.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:lingua_latina/widgets/lesson_card.dart';
import 'package:provider/provider.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Parcours debutant',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choisis une lecon et progresse a ton rythme.',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Consumer<LearningProvider>(
            builder: (context, provider, child) {
              return Column(
                children: mockLessons
                    .map(
                      (lesson) => LessonCard(
                        lesson: lesson,
                        progress: provider.isLessonCompleted(lesson.id) ? 1 : 0.35,
                        isCompleted: provider.isLessonCompleted(lesson.id),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LessonDetailScreen(lesson: lesson),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
