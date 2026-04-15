import 'package:flutter/material.dart';
import 'package:lingua_latina/data/mock_data.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:lingua_latina/widgets/culture_card.dart';

class CultureScreen extends StatelessWidget {
  const CultureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Citations latines celebres',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...mockLatinQuotes.map((item) => CultureCard(item: item)),
          const SizedBox(height: 10),
          const Text(
            'Expressions encore utilisees',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...mockLatinExpressions.map((item) => CultureCard(item: item)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Petite histoire du latin',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(latinHistoryText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
