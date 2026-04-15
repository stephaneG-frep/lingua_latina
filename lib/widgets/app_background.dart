import 'package:flutter/material.dart';
import 'package:lingua_latina/theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const [Color(0xFF5A1621), Color(0xFF3D1118)]
              : const [Color(0xFFF8F0E2), AppTheme.lightBeige],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -55,
            right: -20,
            child: _softCircle(
              color: isDark
                  ? AppTheme.softGold.withValues(alpha: 0.18)
                  : AppTheme.softGold.withValues(alpha: 0.20),
              size: 180,
            ),
          ),
          Positioned(
            bottom: -65,
            left: -35,
            child: _softCircle(
              color: isDark
                  ? const Color(0xFF7A1E2B).withValues(alpha: 0.35)
                  : AppTheme.bordeaux.withValues(alpha: 0.10),
              size: 220,
            ),
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
