import 'package:flutter/material.dart';
import 'package:lingua_latina/screens/main_shell_screen.dart';
import 'package:lingua_latina/screens/welcome_screen.dart';
import 'package:lingua_latina/services/learning_provider.dart';
import 'package:lingua_latina/services/local_storage_service.dart';
import 'package:lingua_latina/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = LocalStorageService();
  await storageService.init();

  final learningProvider = LearningProvider(storageService: storageService);
  await learningProvider.loadState();

  runApp(LinguaLatinaApp(provider: learningProvider));
}

class LinguaLatinaApp extends StatelessWidget {
  const LinguaLatinaApp({super.key, required this.provider});

  final LearningProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LearningProvider>.value(
      value: provider,
      child: Consumer<LearningProvider>(
        builder: (context, learningProvider, child) {
          return MaterialApp(
            title: 'Lingua Latina',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: learningProvider.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            initialRoute: WelcomeScreen.routeName,
            routes: {
              WelcomeScreen.routeName: (_) => const WelcomeScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == MainShellScreen.routeName) {
                final initialIndex = settings.arguments is int ? settings.arguments! as int : 0;
                return MaterialPageRoute<void>(
                  builder: (_) => MainShellScreen(initialIndex: initialIndex),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
