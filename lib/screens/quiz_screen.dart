import 'package:flutter/material.dart';
import 'package:lingua_latina/data/mock_data.dart';
import 'package:lingua_latina/models/quiz_question.dart';
import 'package:lingua_latina/services/learning_provider.dart';
import 'package:lingua_latina/widgets/app_background.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _score = 0;
  String? _selected;
  bool _locked = false;
  bool _saved = false;

  bool get _isFinished => _index >= mockQuizQuestions.length;

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      if (!_saved) {
        _saved = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<LearningProvider>().addQuizScore(_score);
        });
      }
      return _buildResult(context);
    }

    final question = mockQuizQuestions[_index];

    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_index + 1}/${mockQuizQuestions.length}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (_index + 1) / mockQuizQuestions.length),
            const SizedBox(height: 18),
            Text(
              _labelForType(question.type),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              question.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView(
                children: question.options.map((option) {
                  final isCorrect = option == question.correctAnswer;
                  final isSelected = _selected == option;

                  Color? tileColor;
                  if (_locked && isCorrect) {
                    tileColor = Colors.green.withValues(alpha: 0.18);
                  } else if (_locked && isSelected && !isCorrect) {
                    tileColor = Colors.red.withValues(alpha: 0.18);
                  }

                  return Card(
                    color: tileColor,
                    child: ListTile(
                      onTap: _locked
                          ? null
                          : () => setState(() {
                              _selected = option;
                            }),
                      title: Text(option),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle_outline_rounded)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ),
            if (_locked && question.explanation != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Correction: ${question.explanation!}'),
              ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selected == null
                        ? null
                        : () {
                            if (!_locked) {
                              final isCorrect = _selected == question.correctAnswer;
                              setState(() {
                                _locked = true;
                                if (isCorrect) _score += 10;
                              });
                              return;
                            }

                            setState(() {
                              _index++;
                              _selected = null;
                              _locked = false;
                            });
                          },
                    child: Text(_locked ? 'Question suivante' : 'Valider'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    return AppBackground(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emoji_events_rounded, size: 48),
                  const SizedBox(height: 12),
                  const Text(
                    'Quiz termine',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text('Score final: $_score / ${mockQuizQuestions.length * 10}'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => setState(() {
                      _index = 0;
                      _score = 0;
                      _selected = null;
                      _locked = false;
                      _saved = false;
                    }),
                    icon: const Icon(Icons.replay_rounded),
                    label: const Text('Recommencer'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _labelForType(QuestionType type) {
    switch (type) {
      case QuestionType.mcq:
        return 'QCM';
      case QuestionType.trueFalse:
        return 'Vrai / Faux';
      case QuestionType.association:
        return 'Association';
    }
  }
}
