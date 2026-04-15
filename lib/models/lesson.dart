class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.level,
    required this.description,
    required this.keyPoints,
    required this.examples,
  });

  final String id;
  final String title;
  final String level;
  final String description;
  final List<String> keyPoints;
  final List<LatinExample> examples;
}

class LatinExample {
  const LatinExample({
    required this.latin,
    required this.french,
  });

  final String latin;
  final String french;
}
