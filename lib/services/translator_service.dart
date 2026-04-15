import 'package:lingua_latina/data/mock_data.dart';

enum TranslationDirection { frenchToLatin, latinToFrench }

class TranslationResult {
  const TranslationResult({
    required this.translatedText,
    required this.unknownWords,
    required this.usedPhraseRule,
    required this.usedRomanRule,
  });

  final String translatedText;
  final List<String> unknownWords;
  final bool usedPhraseRule;
  final bool usedRomanRule;
}

class TranslatorService {
  TranslatorService() {
    for (final entry in mockDictionaryEntries) {
      final latinKey = _normalizeWord(entry.latin);
      if (latinKey.isNotEmpty) {
        _latinToFrench.putIfAbsent(latinKey, () => _firstFrenchSense(entry.french));
      }

      for (final frenchToken in _extractFrenchTokens(entry.french)) {
        _frenchToLatin.putIfAbsent(frenchToken, () => latinKey);
      }
    }
  }

  final Map<String, String> _latinToFrench = {
    'roma': 'rome',
    'magna': 'grande',
    'est': 'est',
    'puella': 'fille',
    'aquam': 'eau',
    'portat': 'porte',
  };

  final Map<String, String> _frenchToLatin = {
    'bonjour': 'salve',
    'salut': 'salve',
    'au': 'ad',
    'revoir': 'vale',
    'ami': 'amicus',
    'amie': 'amica',
    'eau': 'aqua',
    'terre': 'terra',
    'rome': 'roma',
    'est': 'est',
    'grande': 'magna',
    'fille': 'puella',
    'porte': 'portat',
    'je': 'ego',
    'suis': 'sum',
    'tu': 'tu',
  };

  static final Map<String, String> _frenchToLatinPhrases = {
    'rome est grande': 'roma magna est',
    'la fille porte de l eau': 'puella aquam portat',
    'la fille porte de l\'eau': 'puella aquam portat',
    'bonjour': 'salve',
    'au revoir': 'vale',
  };

  static final Map<String, String> _latinToFrenchPhrases = {
    'roma magna est': 'rome est grande',
    'puella aquam portat': 'la fille porte de l eau',
    'salve': 'bonjour',
    'vale': 'au revoir',
  };

  TranslationResult translate({
    required String input,
    required TranslationDirection direction,
  }) {
    final normalizedInput = _normalizeSentence(input);
    if (normalizedInput.isEmpty) {
      return const TranslationResult(
        translatedText: '',
        unknownWords: [],
        usedPhraseRule: false,
        usedRomanRule: false,
      );
    }

    final romanResult = _translateRomanNumber(input.trim(), direction);
    if (romanResult != null) return romanResult;

    final phraseResult = _translateByPhrase(normalizedInput, direction);
    if (phraseResult != null) return phraseResult;

    final map = direction == TranslationDirection.frenchToLatin
        ? _frenchToLatin
        : _latinToFrench;

    final unknownWords = <String>[];
    final translatedTokens = <String>[];

    for (final token in normalizedInput.split(RegExp(r'\s+'))) {
      if (token.isEmpty) continue;
      final clean = _normalizeWord(token);
      if (clean.isEmpty) continue;

      final translated = map[clean];
      if (translated == null) {
        unknownWords.add(clean);
        translatedTokens.add('[$clean]');
      } else {
        translatedTokens.add(translated);
      }
    }

    return TranslationResult(
      translatedText: translatedTokens.join(' '),
      unknownWords: unknownWords,
      usedPhraseRule: false,
      usedRomanRule: false,
    );
  }

  TranslationResult? _translateByPhrase(String input, TranslationDirection direction) {
    final phraseMap = direction == TranslationDirection.frenchToLatin
        ? _frenchToLatinPhrases
        : _latinToFrenchPhrases;

    final direct = phraseMap[input];
    if (direct != null) {
      return TranslationResult(
        translatedText: direct,
        unknownWords: const [],
        usedPhraseRule: true,
        usedRomanRule: false,
      );
    }
    return null;
  }

  TranslationResult? _translateRomanNumber(String rawInput, TranslationDirection direction) {
    final compact = rawInput.trim().replaceAll(' ', '');
    if (compact.isEmpty) return null;

    if (direction == TranslationDirection.frenchToLatin &&
        RegExp(r'^[0-9]+$').hasMatch(compact)) {
      final value = int.tryParse(compact);
      if (value == null || value <= 0 || value > 3999) {
        return const TranslationResult(
          translatedText: '[nombre hors limite: 1-3999]',
          unknownWords: [],
          usedPhraseRule: false,
          usedRomanRule: true,
        );
      }
      return TranslationResult(
        translatedText: _intToRoman(value),
        unknownWords: const [],
        usedPhraseRule: false,
        usedRomanRule: true,
      );
    }

    if (direction == TranslationDirection.latinToFrench &&
        RegExp(r'^[ivxlcdmIVXLCDM]+$').hasMatch(compact)) {
      final upper = compact.toUpperCase();
      final value = _romanToInt(upper);
      if (value == null) {
        return const TranslationResult(
          translatedText: '[chiffre romain invalide]',
          unknownWords: [],
          usedPhraseRule: false,
          usedRomanRule: true,
        );
      }
      return TranslationResult(
        translatedText: value.toString(),
        unknownWords: const [],
        usedPhraseRule: false,
        usedRomanRule: true,
      );
    }
    return null;
  }

  String _intToRoman(int number) {
    final values = <int>[
      1000,
      900,
      500,
      400,
      100,
      90,
      50,
      40,
      10,
      9,
      5,
      4,
      1,
    ];
    final numerals = <String>[
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];

    var remaining = number;
    final buffer = StringBuffer();
    for (var i = 0; i < values.length; i++) {
      while (remaining >= values[i]) {
        buffer.write(numerals[i]);
        remaining -= values[i];
      }
    }
    return buffer.toString();
  }

  int? _romanToInt(String roman) {
    final values = <String, int>{
      'I': 1,
      'V': 5,
      'X': 10,
      'L': 50,
      'C': 100,
      'D': 500,
      'M': 1000,
    };

    var total = 0;
    for (var i = 0; i < roman.length; i++) {
      final current = values[roman[i]];
      if (current == null) return null;
      final next = i + 1 < roman.length ? values[roman[i + 1]] : null;
      if (next != null && current < next) {
        total -= current;
      } else {
        total += current;
      }
    }

    // Validation: ensure canonical roman format.
    if (total <= 0 || total > 3999) return null;
    return _intToRoman(total) == roman ? total : null;
  }

  String _firstFrenchSense(String frenchValue) {
    return frenchValue
        .split(RegExp(r'[,/]'))
        .first
        .trim()
        .replaceAll('  ', ' ');
  }

  List<String> _extractFrenchTokens(String frenchValue) {
    final normalized = _normalizeSentence(frenchValue);
    final tokens = normalized
        .split(RegExp(r'\s+'))
        .map(_normalizeWord)
        .where((token) => token.length > 1)
        .where((token) => token != 'de' && token != 'la' && token != 'le')
        .toSet()
        .toList();
    return tokens;
  }

  String _normalizeSentence(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-zA-Z0-9' ]"), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _normalizeWord(String value) {
    return value.toLowerCase().replaceAll(RegExp(r"[^a-zA-Z0-9']"), '').trim();
  }
}
