import 'package:flutter/material.dart';
import 'package:lingua_latina/models/dictionary_entry.dart';
import 'package:lingua_latina/theme/app_theme.dart';

class DictionaryEntryTile extends StatelessWidget {
  const DictionaryEntryTile({
    super.key,
    required this.entry,
    required this.onTap,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final DictionaryEntry entry;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final badgeColor = _badgeColor(entry.grammaticalType);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          entry.latin,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(entry.french),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: badgeColor.withValues(alpha: 0.45)),
              ),
              child: Text(
                _shortTypeLabel(entry.grammaticalType),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: badgeColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: onToggleFavorite,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      size: 20,
                      color: isFavorite ? AppTheme.bordeaux : Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Color _badgeColor(String type) {
    final normalized = type.toLowerCase();
    if (normalized.contains('verbe')) return Colors.blue.shade700;
    if (normalized.contains('adjectif')) return Colors.deepPurple.shade700;
    if (normalized.contains('adverbe')) return Colors.teal.shade700;
    if (normalized.contains('pronom')) return Colors.indigo.shade700;
    if (normalized.contains('preposition') || normalized.contains('conjonction')) {
      return Colors.orange.shade800;
    }
    if (normalized.contains('interjection')) return Colors.red.shade700;
    if (normalized.contains('numeral')) return Colors.brown.shade700;
    if (normalized.contains('nom')) return AppTheme.bordeaux;
    return AppTheme.anthracite;
  }

  String _shortTypeLabel(String type) {
    final normalized = type.toLowerCase();
    if (normalized.contains('nom')) return 'Nom';
    if (normalized.contains('verbe')) return 'Verbe';
    if (normalized.contains('adjectif')) return 'Adj';
    if (normalized.contains('adverbe')) return 'Adv';
    if (normalized.contains('pronom')) return 'Pronom';
    if (normalized.contains('preposition')) return 'Prep';
    if (normalized.contains('conjonction')) return 'Conj';
    if (normalized.contains('interjection')) return 'Interj';
    if (normalized.contains('numeral')) return 'Num';
    return 'Type';
  }
}
