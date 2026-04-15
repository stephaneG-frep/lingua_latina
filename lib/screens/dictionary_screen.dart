import 'package:flutter/material.dart';
import 'package:lingua_latina/data/mock_data.dart';
import 'package:lingua_latina/models/dictionary_entry.dart';
import 'package:lingua_latina/services/learning_provider.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:lingua_latina/widgets/dictionary_entry_tile.dart';
import 'package:provider/provider.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String _query = '';
  String _selectedCategory = 'Tous';
  bool _sortAscending = true;
  bool _favoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LearningProvider>();
    final categories = _buildCategories();
    final filtered = mockDictionaryEntries.where((entry) {
      final normalized = _query.toLowerCase();
      final matchesSearch = entry.latin.toLowerCase().contains(normalized) ||
          entry.french.toLowerCase().contains(normalized);
      final matchesCategory = _selectedCategory == 'Tous' ||
          _normalizedCategory(entry.grammaticalType) == _selectedCategory;
      final matchesFavorite = !_favoritesOnly || provider.isFavoriteWord(entry.latin);
      return matchesSearch && matchesCategory && matchesFavorite;
    }).toList();
    filtered.sort(
      (a, b) =>
          _sortAscending ? a.latin.compareTo(b.latin) : b.latin.compareTo(a.latin),
    );

    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher un mot latin ou francais',
                prefixIcon: Icon(Icons.search_rounded),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _selectedCategory = category);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment<bool>(value: true, label: Text('A -> Z')),
                      ButtonSegment<bool>(value: false, label: Text('Z -> A')),
                    ],
                    selected: {_sortAscending},
                    onSelectionChanged: (value) {
                      setState(() => _sortAscending = value.first);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  label: const Text('Favoris'),
                  selected: _favoritesOnly,
                  onSelected: (value) {
                    setState(() => _favoritesOnly = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filtered.length} resultat(s)',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('Aucun mot trouve.'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final entry = filtered[index];
                        return DictionaryEntryTile(
                          entry: entry,
                          isFavorite: provider.isFavoriteWord(entry.latin),
                          onToggleFavorite: () {
                            context.read<LearningProvider>().toggleFavoriteWord(entry.latin);
                          },
                          onTap: () => _showEntryDetails(context, entry),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEntryDetails(BuildContext context, DictionaryEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.latin,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text('Traduction: ${entry.french}'),
              const SizedBox(height: 6),
              Text('Type grammatical: ${entry.grammaticalType}'),
              const SizedBox(height: 6),
              Text('Exemple: ${entry.example}'),
              const SizedBox(height: 12),
              Consumer<LearningProvider>(
                builder: (_, provider, child) {
                  final isFavorite = provider.isFavoriteWord(entry.latin);
                  return OutlinedButton.icon(
                    onPressed: () {
                      context.read<LearningProvider>().toggleFavoriteWord(entry.latin);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    ),
                    label: Text(
                      isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> _buildCategories() {
    final set = mockDictionaryEntries
        .map((entry) => _normalizedCategory(entry.grammaticalType))
        .toSet()
      ..remove('Autre');
    final sorted = set.toList()..sort();
    return ['Tous', ...sorted];
  }

  String _normalizedCategory(String grammaticalType) {
    final type = grammaticalType.toLowerCase();
    if (type.contains('nom')) return 'Nom';
    if (type.contains('verbe')) return 'Verbe';
    if (type.contains('adjectif')) return 'Adjectif';
    if (type.contains('adverbe')) return 'Adverbe';
    if (type.contains('pronom')) return 'Pronom';
    if (type.contains('preposition')) return 'Preposition';
    if (type.contains('conjonction')) return 'Conjonction';
    if (type.contains('interjection')) return 'Interjection';
    if (type.contains('numeral')) return 'Numeral';
    return 'Autre';
  }
}
