import 'package:flutter/material.dart';
import 'package:lingua_latina/services/learning_provider.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Consumer<LearningProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        child: Icon(Icons.person_rounded, size: 30),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.userName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('Profil apprenant'),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showEditNameDialog(context),
                        icon: const Icon(Icons.edit_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progression globale',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(value: provider.overallProgress, minHeight: 10),
                      const SizedBox(height: 8),
                      Text(
                        '${(provider.overallProgress * 100).toInt()}% complete',
                      ),
                      const SizedBox(height: 12),
                      Text('Lecons terminees: ${provider.completedLessonsCount}'),
                      Text('Score total: ${provider.totalScore}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Badges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: provider.earnedBadges.isEmpty
                    ? [
                        const Chip(
                          label: Text('Aucun badge pour le moment'),
                          avatar: Icon(Icons.hourglass_empty_rounded),
                        ),
                      ]
                    : provider.earnedBadges
                          .map(
                            (badge) => Chip(
                              avatar: const Icon(Icons.workspace_premium_rounded),
                              label: Text(badge.label),
                            ),
                          )
                          .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showEditNameDialog(BuildContext context) async {
    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Modifier le pseudo'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Nouveau pseudo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<LearningProvider>().updateUserName(controller.text);
                if (!context.mounted) return;
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }
}
