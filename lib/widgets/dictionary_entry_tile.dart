import 'package:flutter/material.dart';
import 'package:lingua_latina/models/dictionary_entry.dart';

class DictionaryEntryTile extends StatelessWidget {
  const DictionaryEntryTile({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final DictionaryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          entry.latin,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(entry.french),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
