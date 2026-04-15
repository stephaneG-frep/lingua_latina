import 'package:flutter/material.dart';
import 'package:lingua_latina/theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8F0E2), AppTheme.lightBeige],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -55,
            right: -20,
            child: _softCircle(color: AppTheme.softGold.withValues(alpha: 0.20), size: 180),
          ),
          Positioned(
            bottom: -65,
            left: -35,
            child: _softCircle(color: AppTheme.bordeaux.withValues(alpha: 0.10), size: 220),
          ),
          child,
        ],
      ),
    );
  }

  Widget _softCircle({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
