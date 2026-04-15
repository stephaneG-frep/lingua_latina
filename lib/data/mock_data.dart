import 'package:lingua_latina/models/culture_item.dart';
import 'package:lingua_latina/models/dictionary_entry.dart';
import 'package:lingua_latina/models/lesson.dart';
import 'package:lingua_latina/models/quiz_question.dart';
import 'package:lingua_latina/models/user_badge.dart';

const List<Lesson> mockLessons = [
  Lesson(
    id: 'salutations',
    title: 'Salutations',
    level: 'Niveau 1',
    description:
        'Apprendre a saluer et a prendre conge en latin dans des situations simples.',
    keyPoints: [
      'Salve signifie bonjour (a une personne).',
      'Valete est utilise pour dire au revoir a plusieurs personnes.',
      'Le ton reste respectueux et direct.',
    ],
    examples: [
      LatinExample(latin: 'Salve', french: 'Bonjour'),
      LatinExample(latin: 'Vale', french: 'Au revoir'),
      LatinExample(latin: 'Salvete, amici', french: 'Bonjour, les amis'),
    ],
  ),
  Lesson(
    id: 'vocabulaire',
    title: 'Vocabulaire de base',
    level: 'Niveau 1',
    description: 'Les mots essentiels du quotidien pour construire tes premieres phrases.',
    keyPoints: [
      'Les noms latins ont un genre grammatical.',
      'Le dictionnaire donne souvent la forme du nominatif.',
      'Memoriser avec des exemples facilite la retention.',
    ],
    examples: [
      LatinExample(latin: 'amicus', french: 'ami'),
      LatinExample(latin: 'aqua', french: 'eau'),
      LatinExample(latin: 'terra', french: 'terre'),
    ],
  ),
  Lesson(
    id: 'phrases',
    title: 'Phrases simples',
    level: 'Niveau 1',
    description: 'Assembler sujet, verbe et complement pour comprendre la structure latine.',
    keyPoints: [
      'L ordre des mots est plus flexible qu en francais.',
      'Le verbe peut apparaitre en fin de phrase.',
      'Le contexte grammatical donne le sens precis.',
    ],
    examples: [
      LatinExample(latin: 'Roma magna est', french: 'Rome est grande'),
      LatinExample(
        latin: 'Puella aquam portat',
        french: 'La fille porte de l eau',
      ),
      LatinExample(latin: 'Amicus ridet', french: 'L ami rit'),
    ],
  ),
  Lesson(
    id: 'grammaire',
    title: 'Grammaire debutant',
    level: 'Niveau 2',
    description:
        'Comprendre les fonctions des mots grace aux cas grammaticaux de base.',
    keyPoints: [
      'Le nominatif indique souvent le sujet.',
      'L accusatif marque souvent le complement d objet direct.',
      'Les finales changent selon la fonction.',
    ],
    examples: [
      LatinExample(latin: 'Puella rosam amat', french: 'La fille aime la rose'),
      LatinExample(latin: 'Poeta fabulam narrat', french: 'Le poete raconte une histoire'),
    ],
  ),
  Lesson(
    id: 'declinaisons',
    title: 'Declinaisons',
    level: 'Niveau 2',
    description: 'Introduction aux declinaisons les plus frequentes en latin.',
    keyPoints: [
      '1re declinaison: noms en -a (souvent feminins).',
      '2e declinaison: noms en -us ou -um.',
      'Chaque cas a une terminaison specifique.',
    ],
    examples: [
      LatinExample(latin: 'puella / puellae', french: 'la fille / de la fille'),
      LatinExample(latin: 'amicus / amicum', french: 'l ami / l ami (COD)'),
    ],
  ),
  Lesson(
    id: 'conjugaisons',
    title: 'Conjugaisons',
    level: 'Niveau 2',
    description: 'Conjuguer au present pour decrire des actions simples.',
    keyPoints: [
      'Le verbe latin varie selon la personne.',
      'Le present de sum (etre) est essentiel.',
      'Les finales -o, -s, -t indiquent la personne.',
    ],
    examples: [
      LatinExample(latin: 'sum, es, est', french: 'je suis, tu es, il est'),
      LatinExample(latin: 'amo, amas, amat', french: 'j aime, tu aimes, il aime'),
    ],
  ),
];

const List<DictionaryEntry> mockDictionaryEntries = [
  DictionaryEntry(
    latin: 'salve',
    french: 'bonjour',
    grammaticalType: 'interjection',
    example: 'Salve, magister!',
  ),
  DictionaryEntry(
    latin: 'vale',
    french: 'au revoir',
    grammaticalType: 'interjection',
    example: 'Vale, amice.',
  ),
  DictionaryEntry(
    latin: 'amicus',
    french: 'ami',
    grammaticalType: 'nom masculin',
    example: 'Amicus meus adest.',
  ),
  DictionaryEntry(
    latin: 'aqua',
    french: 'eau',
    grammaticalType: 'nom feminin',
    example: 'Aqua clara est.',
  ),
  DictionaryEntry(
    latin: 'terra',
    french: 'terre',
    grammaticalType: 'nom feminin',
    example: 'Terra antiqua est.',
  ),
  DictionaryEntry(
    latin: 'puella',
    french: 'fille',
    grammaticalType: 'nom feminin',
    example: 'Puella aquam portat.',
  ),
  DictionaryEntry(
    latin: 'roma',
    french: 'Rome',
    grammaticalType: 'nom propre',
    example: 'Roma magna est.',
  ),
];

const List<QuizQuestion> mockQuizQuestions = [
  QuizQuestion(
    id: 'q1',
    question: 'Que signifie "salve" ?',
    options: ['bonjour', 'merci', 'ami', 'terre'],
    correctAnswer: 'bonjour',
    type: QuestionType.mcq,
    explanation: 'Salve est une salutation latine classique.',
  ),
  QuizQuestion(
    id: 'q2',
    question: 'Vrai ou faux: "vale" signifie bonjour.',
    options: ['Vrai', 'Faux'],
    correctAnswer: 'Faux',
    type: QuestionType.trueFalse,
    explanation: 'Vale signifie au revoir.',
  ),
  QuizQuestion(
    id: 'q3',
    question: 'Associe "aqua" a la bonne traduction.',
    options: ['eau', 'ami', 'ville', 'guerre'],
    correctAnswer: 'eau',
    type: QuestionType.association,
    explanation: 'Aqua veut dire eau.',
  ),
  QuizQuestion(
    id: 'q4',
    question: 'Traduction de "Roma magna est" ?',
    options: [
      'Rome est grande',
      'Rome est petite',
      'La terre est grande',
      'Le poete est grand',
    ],
    correctAnswer: 'Rome est grande',
    type: QuestionType.mcq,
    explanation: 'Magna = grande et Roma = Rome.',
  ),
  QuizQuestion(
    id: 'q5',
    question: 'Vrai ou faux: "amicus" signifie ami.',
    options: ['Vrai', 'Faux'],
    correctAnswer: 'Vrai',
    type: QuestionType.trueFalse,
    explanation: 'Amicus est un nom masculin signifiant ami.',
  ),
];

const List<CultureItem> mockLatinQuotes = [
  CultureItem(
    latin: 'Carpe diem',
    french: 'Cueille le jour present',
    context: 'Horace invite a vivre pleinement le moment.',
  ),
  CultureItem(
    latin: 'Veni, vidi, vici',
    french: 'Je suis venu, j ai vu, j ai vaincu',
    context: 'Phrase attribuee a Jules Cesar apres une victoire rapide.',
  ),
  CultureItem(
    latin: 'Alea iacta est',
    french: 'Le sort en est jete',
    context: 'Expression celebre liee au passage du Rubicon.',
  ),
];

const List<CultureItem> mockLatinExpressions = [
  CultureItem(
    latin: 'Status quo',
    french: 'Etat actuel des choses',
    context: 'Utilise en politique, droit et management.',
  ),
  CultureItem(
    latin: 'Et cetera',
    french: 'Et le reste',
    context: 'Expression encore tres utilisee a l ecrit.',
  ),
  CultureItem(
    latin: 'Curriculum vitae',
    french: 'Parcours de vie',
    context: 'Terme universel pour le CV professionnel.',
  ),
];

const String latinHistoryText =
    'Le latin est la langue de la Rome antique. Il a structure le droit, la litterature et la science en Europe pendant des siecles. '
    'Bien qu il ne soit plus langue maternelle, il reste vivant a travers les langues romanes, les expressions courantes et la culture classique.';

const List<UserBadge> availableBadges = [
  UserBadge(
    id: 'prima_vox',
    label: 'Prima Vox',
    description: 'Premiere lecon terminee',
  ),
  UserBadge(
    id: 'discipulus',
    label: 'Discipulus',
    description: '3 lecons terminees',
  ),
  UserBadge(
    id: 'grammaticus',
    label: 'Grammaticus',
    description: 'Toutes les lecons terminees',
  ),
  UserBadge(
    id: 'mentis_acies',
    label: 'Mentis Acies',
    description: 'Score total de quiz superieur ou egal a 40',
  ),
];
