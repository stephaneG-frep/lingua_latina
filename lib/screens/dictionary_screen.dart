import 'package:flutter/material.dart';
import 'package:lingua_latina/data/mock_data.dart';
import 'package:lingua_latina/models/dictionary_entry.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:lingua_latina/widgets/dictionary_entry_tile.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = mockDictionaryEntries.where((entry) {
      final normalized = _query.toLowerCase();
      return entry.latin.toLowerCase().contains(normalized) ||
          entry.french.toLowerCase().contains(normalized);
    }).toList();

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
            const SizedBox(height: 14),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('Aucun mot trouve.'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final entry = filtered[index];
                        return DictionaryEntryTile(
                          entry: entry,
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
            ],
          ),
        );
      },
    );
  }
}
