import 'package:flutter/material.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:lingua_latina/widgets/menu_card.dart';
import 'package:lingua_latina/widgets/roman_logo.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final horizontal = width < 360 ? 16.0 : 22.0;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Center(child: RomanLogo(size: 104)),
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    'Lingua Latina',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Apprends le latin pas a pas, avec clarte et plaisir.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/app'),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Commencer'),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Acces rapide',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: width > 500 ? 3 : 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      MenuCard(
                        title: 'Lecons',
                        icon: Icons.menu_book_rounded,
                        onTap: () => _openTab(context, 0),
                      ),
                      MenuCard(
                        title: 'Dictionnaire',
                        icon: Icons.translate_rounded,
                        onTap: () => _openTab(context, 1),
                      ),
                      MenuCard(
                        title: 'Traducteur',
                        icon: Icons.g_translate_rounded,
                        onTap: () => _openTab(context, 2),
                      ),
                      MenuCard(
                        title: 'Quiz',
                        icon: Icons.quiz_rounded,
                        onTap: () => _openTab(context, 3),
                      ),
                      MenuCard(
                        title: 'Culture',
                        icon: Icons.temple_buddhist_rounded,
                        onTap: () => _openTab(context, 4),
                      ),
                      MenuCard(
                        title: 'Profil',
                        icon: Icons.person_rounded,
                        onTap: () => _openTab(context, 5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openTab(BuildContext context, int tab) {
    Navigator.pushReplacementNamed(context, '/app', arguments: tab);
  }
}
