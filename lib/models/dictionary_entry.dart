class DictionaryEntry {
  const DictionaryEntry({
    required this.latin,
    required this.french,
    required this.grammaticalType,
    required this.example,
  });

  final String latin;
  final String french;
  final String grammaticalType;
  final String example;
}
