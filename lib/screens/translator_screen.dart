import 'package:flutter/material.dart';
import 'package:lingua_latina/services/translator_service.dart';
import 'package:lingua_latina/widgets/app_background.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TranslatorService _translatorService = TranslatorService();

  TranslationDirection _direction = TranslationDirection.frenchToLatin;
  TranslationResult? _result;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Traducteur',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Traduction locale FR <-> Latin pour debuter rapidement.',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          SegmentedButton<TranslationDirection>(
            segments: const [
              ButtonSegment<TranslationDirection>(
                value: TranslationDirection.frenchToLatin,
                label: Text('FR -> LA'),
                icon: Icon(Icons.north_east_rounded),
              ),
              ButtonSegment<TranslationDirection>(
                value: TranslationDirection.latinToFrench,
                label: Text('LA -> FR'),
                icon: Icon(Icons.south_east_rounded),
              ),
            ],
            selected: {_direction},
            onSelectionChanged: (value) {
              setState(() {
                _direction = value.first;
              });
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: _direction == TranslationDirection.frenchToLatin
                  ? 'Ex: Rome est grande'
                  : 'Ex: Roma magna est',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _translate,
                  icon: const Icon(Icons.translate_rounded),
                  label: const Text('Traduire'),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                tooltip: 'Inverser la direction',
                onPressed: () {
                  setState(() {
                    _direction = _direction == TranslationDirection.frenchToLatin
                        ? TranslationDirection.latinToFrench
                        : TranslationDirection.frenchToLatin;
                  });
                },
                icon: const Icon(Icons.swap_horiz_rounded),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resultat',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result?.translatedText.isNotEmpty == true
                        ? _result!.translatedText
                        : 'Aucune traduction pour le moment.',
                    style: TextStyle(
                      color: _result?.translatedText.isNotEmpty == true
                          ? colorScheme.onSurface
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_result?.usedPhraseRule == true) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: colorScheme.primary.withValues(alpha: 0.18),
                      ),
                      child: Text(
                        'Correspondance de phrase detectee',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (_result != null && _result!.unknownWords.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              'Mots non reconnus',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _result!.unknownWords
                  .map((word) => Chip(label: Text(word)))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  void _translate() {
    final input = _inputController.text.trim();
    setState(() {
      _result = _translatorService.translate(input: input, direction: _direction);
    });
  }
}
