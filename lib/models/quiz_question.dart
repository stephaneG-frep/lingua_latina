enum QuestionType { mcq, trueFalse, association }

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.type,
    this.explanation,
  });

  final String id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final QuestionType type;
  final String? explanation;
}
