import 'package:flutter/material.dart';
import 'package:lingua_latina/models/culture_item.dart';
import 'package:lingua_latina/theme/app_theme.dart';

class CultureCard extends StatelessWidget {
  const CultureCard({super.key, required this.item});

  final CultureItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.latin,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.bordeaux,
              ),
            ),
            const SizedBox(height: 4),
            Text(item.french, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(item.context),
          ],
        ),
      ),
    );
  }
}
