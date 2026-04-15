import 'package:flutter/material.dart';
import 'package:lingua_latina/models/lesson.dart';
import 'package:lingua_latina/services/learning_provider.dart';
import 'package:provider/provider.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LearningProvider>();
    final completed = provider.isLessonCompleted(lesson.id);

    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(lesson.level, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(lesson.description),
          const SizedBox(height: 16),
          const Text(
            'Points essentiels',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ...lesson.keyPoints.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.circle, size: 8),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(point)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Exemples latin -> francais',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...lesson.examples.map(
            (example) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(
                  example.latin,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(example.french),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: completed
                ? null
                : () async {
                    await context.read<LearningProvider>().markLessonCompleted(lesson.id);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lecon marquee comme terminee.')),
                    );
                  },
            icon: Icon(completed ? Icons.check_circle : Icons.done_all_rounded),
            label: Text(
              completed ? 'Lecon deja terminee' : 'Marquer comme termine',
            ),
          ),
        ],
      ),
    );
  }
}
