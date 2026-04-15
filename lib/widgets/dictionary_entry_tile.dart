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
    final colorScheme = Theme.of(context).colorScheme;
    final badgeColor = _badgeColor(context, entry.grammaticalType);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Row(
          children: [
            Expanded(
              child: Text(
                entry.latin,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: onToggleFavorite,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 20,
                  color: isFavorite ? AppTheme.bordeaux : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                entry.french,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: badgeColor.withValues(alpha: 0.70)),
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
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }

  Color _badgeColor(BuildContext context, String type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final normalized = type.toLowerCase();
    if (normalized.contains('verbe')) return isDark ? const Color(0xFF8AB4F8) : Colors.blue.shade700;
    if (normalized.contains('adjectif')) {
      return isDark ? const Color(0xFFC9A7FF) : Colors.deepPurple.shade700;
    }
    if (normalized.contains('adverbe')) return isDark ? const Color(0xFF7ED7C1) : Colors.teal.shade700;
    if (normalized.contains('pronom')) return isDark ? const Color(0xFFA7B6FF) : Colors.indigo.shade700;
    if (normalized.contains('preposition') || normalized.contains('conjonction')) {
      return isDark ? const Color(0xFFFFD08A) : Colors.orange.shade800;
    }
    if (normalized.contains('interjection')) {
      return isDark ? const Color(0xFFFFA4A4) : Colors.red.shade700;
    }
    if (normalized.contains('numeral')) return isDark ? const Color(0xFFE8C39E) : Colors.brown.shade700;
    if (normalized.contains('nom')) return isDark ? AppTheme.softGold : AppTheme.bordeaux;
    return isDark ? AppTheme.lightBeige : AppTheme.anthracite;
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
