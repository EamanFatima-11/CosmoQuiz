import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CosmoQuizApp());
}

// ══════════════════════════════════════════════
//  THEME — Electric Blue · Cyan · Neon Glow
// ══════════════════════════════════════════════
class CosmoColors {
  static const bg = Color(0xFF020818);
  static const bgMid = Color(0xFF060E24);
  static const surface = Color(0xFF0B1A3E);
  static const surfaceHi = Color(0xFF102348);
  static const electric = Color(0xFF3B82F6);
  static const cyan = Color(0xFF06B6D4);
  static const neon = Color(0xFF67E8F9);
  static const cobalt = Color(0xFF1D4ED8);
  static const cream = Color(0xFFF0F9FF);
  static const muted = Color(0xFF4A7DAA);
  static const green = Color(0xFF10B981);
  static const red = Color(0xFFEF4444);
  static const gold = Color(0xFFFFD700);
}

// ══════════════════════════════════════════════
//  QUESTIONS — 5 categories, 10 each = 50 total
//  Random 7 picked per category when selected
// ══════════════════════════════════════════════

const _allQuestions = [
  // ── FLUTTER (10) ──────────────────────────
  {
    'q': 'What widget builds scrollable lists efficiently in Flutter?',
    'opts': ['ListView.builder', 'Column', 'ScrollView', 'GridView'],
    'ans': 0,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'Which method is called when a StatefulWidget is first created?',
    'opts': ['build()', 'initState()', 'dispose()', 'setState()'],
    'ans': 1,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'What does setState() do in Flutter?',
    'opts': [
      'Saves data',
      'Navigates pages',
      'Triggers UI rebuild',
      'Disposes widget',
    ],
    'ans': 2,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'Which widget is used to add padding around a child widget?',
    'opts': ['Margin', 'Padding', 'SizedBox', 'Container'],
    'ans': 1,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'What is the correct way to navigate to a new screen in Flutter?',
    'opts': ['Navigator.push()', 'Router.go()', 'Screen.open()', 'Go.to()'],
    'ans': 0,
    'cat': 'Flutter',
    'points': 15,
  },

  {
    'q': 'Which widget is used to draw custom shapes in Flutter?',
    'opts': ['Canvas', 'CustomPainter', 'DrawWidget', 'PaintBox'],
    'ans': 1,
    'cat': 'Flutter',
    'points': 15,
  },

  {
    'q': 'What does the Expanded widget do inside a Row or Column?',
    'opts': [
      'Adds border',
      'Takes remaining space',
      'Adds margin',
      'Aligns center',
    ],
    'ans': 1,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'Which class do you extend to create a StatefulWidget?',
    'opts': ['Widget', 'State', 'StatefulWidget', 'StatelessWidget'],
    'ans': 2,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'What is hot reload in Flutter?',
    'opts': [
      'Full app restart',
      'Updates UI without losing state',
      'Clears cache',
      'Rebuilds project',
    ],
    'ans': 1,
    'cat': 'Flutter',
    'points': 10,
  },

  {
    'q': 'Which method disposes resources in a StatefulWidget?',
    'opts': ['initState()', 'build()', 'dispose()', 'deactivate()'],
    'ans': 2,
    'cat': 'Flutter',
    'points': 15,
  },

  // ── PYTHON (10) ───────────────────────────
  {
    'q': 'What is the output of list(range(2, 10, 3))?',
    'opts': ['[2,5,8]', '[2,4,6,8]', '[3,6,9]', '[2,3,4]'],
    'ans': 0,
    'cat': 'Python',
    'points': 15,
  },

  {
    'q': 'Which Python library is used for data manipulation?',
    'opts': ['NumPy', 'Pandas', 'Matplotlib', 'Scikit-learn'],
    'ans': 1,
    'cat': 'Python',
    'points': 10,
  },

  {
    'q': 'What keyword is used to define a function in Python?',
    'opts': ['function', 'define', 'def', 'func'],
    'ans': 2,
    'cat': 'Python',
    'points': 10,
  },

  {
    'q': 'Which operator checks identity (not equality) in Python?',
    'opts': ['==', '!=', 'is', 'in'],
    'ans': 2,
    'cat': 'Python',
    'points': 15,
  },

  {
    'q': 'What does len() return for the string "hello"?',
    'opts': ['4', '5', '6', 'None'],
    'ans': 1,
    'cat': 'Python',
    'points': 10,
  },

  {
    'q': 'Which of these is a mutable data type in Python?',
    'opts': ['tuple', 'string', 'list', 'int'],
    'ans': 2,
    'cat': 'Python',
    'points': 10,
  },

  {
    'q': 'What is the output of 2 ** 10 in Python?',
    'opts': ['20', '100', '1024', '2048'],
    'ans': 2,
    'cat': 'Python',
    'points': 15,
  },

  {
    'q': 'Which method removes the last item from a Python list?',
    'opts': ['remove()', 'delete()', 'pop()', 'discard()'],
    'ans': 2,
    'cat': 'Python',
    'points': 10,
  },

  {
    'q': 'What does the zip() function do in Python?',
    'opts': [
      'Compresses files',
      'Combines iterables',
      'Sorts lists',
      'Filters elements',
    ],
    'ans': 1,
    'cat': 'Python',
    'points': 15,
  },

  {
    'q': 'Which built-in function converts a string to an integer?',
    'opts': ['str()', 'float()', 'int()', 'num()'],
    'ans': 2,
    'cat': 'Python',
    'points': 10,
  },

  // ── ALGORITHMS (10) ───────────────────────
  {
    'q': 'What is the space complexity of Merge Sort?',
    'opts': ['O(1)', 'O(log n)', 'O(n)', 'O(n²)'],
    'ans': 2,
    'cat': 'Algorithms',
    'points': 20,
  },

  {
    'q': 'Which data structure uses LIFO order?',
    'opts': ['Queue', 'Stack', 'Tree', 'Heap'],
    'ans': 1,
    'cat': 'Algorithms',
    'points': 10,
  },

  {
    'q': 'What is the time complexity of Binary Search?',
    'opts': ['O(n)', 'O(n²)', 'O(log n)', 'O(1)'],
    'ans': 2,
    'cat': 'Algorithms',
    'points': 15,
  },

  {
    'q': 'Which sorting algorithm is best for nearly sorted data?',
    'opts': ['Quick Sort', 'Merge Sort', 'Insertion Sort', 'Heap Sort'],
    'ans': 2,
    'cat': 'Algorithms',
    'points': 20,
  },

  {
    'q': 'What data structure is used in BFS traversal?',
    'opts': ['Stack', 'Queue', 'Tree', 'Graph'],
    'ans': 1,
    'cat': 'Algorithms',
    'points': 15,
  },

  {
    'q': 'What is the worst case time complexity of Quick Sort?',
    'opts': ['O(n log n)', 'O(n)', 'O(n²)', 'O(log n)'],
    'ans': 2,
    'cat': 'Algorithms',
    'points': 20,
  },

  {
    'q': 'Which data structure uses FIFO order?',
    'opts': ['Stack', 'Heap', 'Queue', 'Tree'],
    'ans': 2,
    'cat': 'Algorithms',
    'points': 10,
  },

  {
    'q': 'What is a hash collision?',
    'opts': [
      'Array overflow',
      'Two keys hash to same index',
      'Null pointer error',
      'Stack overflow',
    ],
    'ans': 1,
    'cat': 'Algorithms',
    'points': 20,
  },

  {
    'q': 'Which traversal visits root FIRST in a binary tree?',
    'opts': ['Inorder', 'Postorder', 'Preorder', 'Level order'],
    'ans': 2,
    'cat': 'Algorithms',
    'points': 15,
  },

  {
    'q': 'What is the time complexity of accessing an array element by index?',
    'opts': ['O(n)', 'O(log n)', 'O(n²)', 'O(1)'],
    'ans': 3,
    'cat': 'Algorithms',
    'points': 10,
  },

  // ── SYSTEMS (10) ──────────────────────────
  {
    'q': 'What does mutex stand for?',
    'opts': [
      'Multiple Extension',
      'Mutual Exclusion',
      'Memory Text',
      'Module Exchange',
    ],
    'ans': 1,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'Which MPI operation sends data to all processes?',
    'opts': ['MPI_Send', 'MPI_Scatter', 'MPI_Broadcast', 'MPI_Reduce'],
    'ans': 2,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'What does a semaphore do in an OS?',
    'opts': [
      'Schedules CPU',
      'Controls access to shared resources',
      'Manages memory',
      'Handles I/O',
    ],
    'ans': 1,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'What is a deadlock in operating systems?',
    'opts': [
      'CPU overload',
      'Two processes waiting forever for each other',
      'Memory leak',
      'Disk failure',
    ],
    'ans': 1,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'Which MPI function combines values from all processes?',
    'opts': ['MPI_Gather', 'MPI_Scatter', 'MPI_Send', 'MPI_Reduce'],
    'ans': 3,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'What does CPU cache do?',
    'opts': [
      'Stores permanent files',
      'Speeds up memory access',
      'Manages threads',
      'Handles network',
    ],
    'ans': 1,
    'cat': 'Systems',
    'points': 15,
  },

  {
    'q': 'What is a context switch?',
    'opts': [
      'Changing variables',
      'Saving and restoring CPU state for process switching',
      'Switching networks',
      'Updating UI',
    ],
    'ans': 1,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'Which scheduling algorithm gives CPU to shortest job first?',
    'opts': ['FCFS', 'Round Robin', 'SJF', 'Priority'],
    'ans': 2,
    'cat': 'Systems',
    'points': 15,
  },

  {
    'q': 'What does virtual memory allow?',
    'opts': [
      'Faster CPU',
      'Using disk as RAM extension',
      'Network sharing',
      'GPU rendering',
    ],
    'ans': 1,
    'cat': 'Systems',
    'points': 20,
  },

  {
    'q': 'What is the role of MPI_Barrier?',
    'opts': [
      'Sends data',
      'Receives data',
      'Synchronizes all processes',
      'Reduces values',
    ],
    'ans': 2,
    'cat': 'Systems',
    'points': 20,
  },

  // ── AI/ML (10) ────────────────────────────
  {
    'q': 'What does NLP stand for?',
    'opts': [
      'Narrow Language Processing',
      'Natural Language Processing',
      'Neural Learning Program',
      'Node-Level Processing',
    ],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 15,
  },

  {
    'q': 'Which algorithm is used for classification and regression in ML?',
    'opts': ['K-Means', 'Decision Tree', 'PCA', 't-SNE'],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 15,
  },

  {
    'q': 'What does overfitting mean in machine learning?',
    'opts': [
      'Model too simple',
      'Model memorizes training data but fails on new data',
      'Model trains too fast',
      'Model has no layers',
    ],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 20,
  },

  {
    'q': 'Which activation function outputs values between 0 and 1?',
    'opts': ['ReLU', 'Tanh', 'Sigmoid', 'Softmax'],
    'ans': 2,
    'cat': 'AI/ML',
    'points': 15,
  },

  {
    'q': 'What is the purpose of a loss function in ML?',
    'opts': [
      'Load data',
      'Measure model error',
      'Visualize data',
      'Split dataset',
    ],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 15,
  },

  {
    'q': 'Which technique prevents overfitting by randomly dropping neurons?',
    'opts': ['Batch Norm', 'Dropout', 'Pooling', 'Padding'],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 20,
  },

  {
    'q': 'What does CNN stand for?',
    'opts': [
      'Central Neural Network',
      'Convolutional Neural Network',
      'Computed Neuron Node',
      'Connected Network Node',
    ],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 15,
  },

  {
    'q': 'Which ML approach learns from labeled data?',
    'opts': [
      'Unsupervised Learning',
      'Reinforcement Learning',
      'Supervised Learning',
      'Transfer Learning',
    ],
    'ans': 2,
    'cat': 'AI/ML',
    'points': 10,
  },

  {
    'q': 'What is a confusion matrix used for?',
    'opts': [
      'Visualizing loss',
      'Evaluating classification results',
      'Tuning hyperparameters',
      'Data augmentation',
    ],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 15,
  },

  {
    'q': 'Which algorithm clusters data into K groups?',
    'opts': ['Linear Regression', 'K-Means', 'Random Forest', 'Naive Bayes'],
    'ans': 1,
    'cat': 'AI/ML',
    'points': 15,
  },
];

// Pick 7 random questions from a category, or 7 random from all
List<Map<String, dynamic>> _pickQuestions(String? category) {
  final rng = Random();
  List<Map<String, dynamic>> pool;
  if (category == null || category == 'All') {
    // Pick 7 random across all categories (at least 1 from each)
    final byCategory = <String, List<Map<String, dynamic>>>{};
    for (final q in _allQuestions) {
      byCategory.putIfAbsent(q['cat'] as String, () => []).add(q);
    }
    final result = <Map<String, dynamic>>[];
    for (final cat in byCategory.values) {
      final copy = List<Map<String, dynamic>>.from(cat)..shuffle(rng);
      result.add(copy.first); // 1 guaranteed from each category
    }
    // Fill remaining from full pool
    final remaining = List<Map<String, dynamic>>.from(_allQuestions)
      ..removeWhere((q) => result.contains(q));
    remaining.shuffle(rng);
    result.addAll(remaining.take((7 - result.length).clamp(0, 50)));
    result.shuffle(rng);
    return result.take(7).toList();
  } else {
    pool = _allQuestions.where((q) => q['cat'] == category).toList();
    pool.shuffle(rng);
    return pool.take(7).toList();
  }
}

const catColors = {
  'Flutter': Color(0xFF06B6D4),
  'Python': Color(0xFF10B981),
  'Algorithms': Color(0xFFF59E0B),
  'Systems': Color(0xFFA78BFA),
  'AI/ML': Color(0xFFEF4444),
};

// ══════════════════════════════════════════════
//  APP
// ══════════════════════════════════════════════
class CosmoQuizApp extends StatelessWidget {
  const CosmoQuizApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'CosmoQuiz',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CosmoColors.bg,
    ),
    home: const QuizLanding(),
  );
}

// ══════════════════════════════════════════════
//  LANDING
// ══════════════════════════════════════════════
class QuizLanding extends StatefulWidget {
  const QuizLanding({super.key});
  @override
  State<QuizLanding> createState() => _QuizLandingState();
}

class _QuizLandingState extends State<QuizLanding>
    with TickerProviderStateMixin {
  late AnimationController _orbitCtrl, _pulseCtrl;
  late Animation<double> _orbit, _pulse;
  String? _selectedCat;
  final cats = ['All', 'Flutter', 'Python', 'Algorithms', 'Systems', 'AI/ML'];

  @override
  void initState() {
    super.initState();
    _orbitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _orbit = CurvedAnimation(parent: _orbitCtrl, curve: Curves.linear);
    _pulse = Tween(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _orbitCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredQuestions =>
      _pickQuestions(_selectedCat);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: CosmoColors.bg,
    body: Stack(
      children: [
        // Starfield
        AnimatedBuilder(
          animation: _orbit,
          builder: (_, __) => CustomPaint(
            painter: _StarfieldPainter(_orbit.value),
            size: MediaQuery.of(context).size,
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Animated planet
                AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, __) => Transform.scale(
                    scale: _pulse.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Orbit ring
                        AnimatedBuilder(
                          animation: _orbit,
                          builder: (_, __) => Transform.rotate(
                            angle: _orbit.value * 2 * pi,
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: CosmoColors.cyan.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CosmoColors.cyan,
                                    boxShadow: [
                                      BoxShadow(
                                        color: CosmoColors.cyan.withOpacity(
                                          0.8,
                                        ),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [
                                CosmoColors.electric,
                                CosmoColors.cobalt,
                                CosmoColors.bg,
                              ],
                              radius: 0.85,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CosmoColors.electric.withOpacity(0.6),
                                blurRadius: 50,
                                spreadRadius: 10,
                              ),
                              BoxShadow(
                                color: CosmoColors.cyan.withOpacity(0.3),
                                blurRadius: 80,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('🚀', style: TextStyle(fontSize: 52)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'CosmoQuiz',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: CosmoColors.cream,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 4),
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [
                      CosmoColors.electric,
                      CosmoColors.cyan,
                      CosmoColors.neon,
                    ],
                  ).createShader(b),
                  child: const Text(
                    'Test your CS universe',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _statChip('📚', '50', 'Questions'),
                    const SizedBox(width: 12),
                    _statChip('⏱', '7 Qs', 'Per Round'),
                    const SizedBox(width: 12),
                    _statChip('🎯', '5', 'Categories'),
                  ],
                ),
                const SizedBox(height: 32),
                // Category filter
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose Category',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: CosmoColors.muted,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: cats.map((c) {
                    final active = (_selectedCat ?? 'All') == c;
                    final color = c == 'All'
                        ? CosmoColors.electric
                        : (catColors[c] ?? CosmoColors.electric);
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCat = c == 'All' ? null : c),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? color.withOpacity(0.2)
                              : CosmoColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: active
                                ? color
                                : Colors.white.withOpacity(0.08),
                          ),
                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color: color.withOpacity(0.3),
                                    blurRadius: 10,
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          c,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: active ? color : CosmoColors.muted,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: CosmoColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: CosmoColors.electric.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.quiz_rounded,
                        size: 16,
                        color: CosmoColors.cyan,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '7 questions · ${_selectedCat ?? 'All categories'}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: CosmoColors.neon,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            QuizScreen(questions: _filteredQuestions),
                        transitionsBuilder: (_, a, __, child) =>
                            FadeTransition(opacity: a, child: child),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          CosmoColors.cobalt,
                          CosmoColors.electric,
                          CosmoColors.cyan,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: CosmoColors.electric.withOpacity(0.5),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Launch Quiz',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('🚀', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _statChip(String emoji, String val, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: CosmoColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: CosmoColors.electric.withOpacity(0.2)),
    ),
    child: Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 4),
        Text(
          val,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: CosmoColors.cream,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: CosmoColors.muted),
        ),
      ],
    ),
  );
}

// ══════════════════════════════════════════════
//  QUIZ SCREEN
// ══════════════════════════════════════════════
class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  const QuizScreen({super.key, required this.questions});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _qIndex = 0, _score = 0, _selected = -1;
  bool _answered = false;
  int _timeLeft = 15;
  Timer? _timer;
  List<int> _userAnswers = [];

  late AnimationController _slideCtrl, _timerCtrl, _correctCtrl;
  late Animation<Offset> _slideAnim;
  late Animation<double> _timerAnim, _correctAnim;

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(widget.questions.length, -1);
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _timerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
    _correctCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _timerAnim = CurvedAnimation(parent: _timerCtrl, curve: Curves.linear);
    _correctAnim = CurvedAnimation(
      parent: _correctCtrl,
      curve: Curves.elasticOut,
    );
    _startQuestion();
  }

  void _startQuestion() {
    _slideCtrl.reset();
    _slideCtrl.forward();
    _timerCtrl.reset();
    _timerCtrl.forward();
    _timer?.cancel();
    setState(() => _timeLeft = 15);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          if (!_answered) {
            setState(() {
              _answered = true;
              _selected = -1;
            });
            Future.delayed(const Duration(milliseconds: 1200), _next);
          }
        }
      });
    });
  }

  void _select(int i) {
    if (_answered) return;
    HapticFeedback.selectionClick();
    _timer?.cancel();
    _timerCtrl.stop();
    final correct = i == widget.questions[_qIndex]['ans'];
    if (correct) {
      HapticFeedback.heavyImpact();
      _correctCtrl.reset();
      _correctCtrl.forward();
      _score += (widget.questions[_qIndex]['points'] as int);
    }
    setState(() {
      _selected = i;
      _answered = true;
      _userAnswers[_qIndex] = i;
    });
    Future.delayed(const Duration(milliseconds: 1000), _next);
  }

  void _next() {
    if (!mounted) return;
    if (_qIndex < widget.questions.length - 1) {
      setState(() {
        _qIndex++;
        _selected = -1;
        _answered = false;
      });
      _startQuestion();
    } else {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ResultScreen(
            score: _score,
            questions: widget.questions,
            userAnswers: _userAnswers,
          ),
          transitionsBuilder: (_, a, __, child) =>
              FadeTransition(opacity: a, child: child),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _slideCtrl.dispose();
    _timerCtrl.dispose();
    _correctCtrl.dispose();
    super.dispose();
  }

  Color _optionBg(int i) {
    if (!_answered) return CosmoColors.surface;
    if (i == widget.questions[_qIndex]['ans'])
      return CosmoColors.green.withOpacity(0.2);
    if (i == _selected) return CosmoColors.red.withOpacity(0.2);
    return CosmoColors.surface.withOpacity(0.5);
  }

  Color _optionBorder(int i) {
    if (!_answered) return Colors.white.withOpacity(0.08);
    if (i == widget.questions[_qIndex]['ans']) return CosmoColors.green;
    if (i == _selected) return CosmoColors.red;
    return Colors.white.withOpacity(0.04);
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_qIndex];
    final catColor = catColors[q['cat']] ?? CosmoColors.electric;
    final timerColor = _timeLeft <= 5
        ? CosmoColors.red
        : _timeLeft <= 10
        ? CosmoColors.gold
        : CosmoColors.cyan;

    return Scaffold(
      backgroundColor: CosmoColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CosmoColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                  ),
                  // Progress dots
                  Row(
                    children: List.generate(
                      widget.questions.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: i == _qIndex ? 20 : 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: i < _qIndex
                              ? CosmoColors.green
                              : i == _qIndex
                              ? CosmoColors.electric
                              : CosmoColors.surfaceHi,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  // Score
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CosmoColors.gold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: CosmoColors.gold.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      '⚡ $_score pts',
                      style: const TextStyle(
                        fontSize: 12,
                        color: CosmoColors.gold,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Timer bar
              AnimatedBuilder(
                animation: _timerAnim,
                builder: (_, __) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Q${_qIndex + 1} of ${widget.questions.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: CosmoColors.muted,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_rounded,
                              size: 14,
                              color: timerColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$_timeLeft s',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: timerColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _timeLeft / 15,
                        minHeight: 5,
                        backgroundColor: CosmoColors.surfaceHi,
                        valueColor: AlwaysStoppedAnimation(timerColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Category + points
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: catColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      q['cat'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: catColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: CosmoColors.gold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '+${q['points']} pts',
                      style: const TextStyle(
                        fontSize: 11,
                        color: CosmoColors.gold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Question
              SlideTransition(
                position: _slideAnim,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CosmoColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: catColor.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: catColor.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Text(
                    q['q'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: CosmoColors.cream,
                      height: 1.4,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Options
              Expanded(
                child: ListView(
                  children: (q['opts'] as List<String>)
                      .asMap()
                      .entries
                      .map(
                        (e) => GestureDetector(
                          onTap: () => _select(e.key),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _optionBg(e.key),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _optionBorder(e.key),
                                width: 1.5,
                              ),
                              boxShadow: _answered && e.key == q['ans']
                                  ? [
                                      BoxShadow(
                                        color: CosmoColors.green.withOpacity(
                                          0.2,
                                        ),
                                        blurRadius: 12,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: CosmoColors.surfaceHi,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _answered && e.key == q['ans']
                                          ? CosmoColors.green
                                          : Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ['A', 'B', 'C', 'D'][e.key],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: CosmoColors.neon,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    e.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: CosmoColors.cream,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                if (_answered && e.key == q['ans'])
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: CosmoColors.green,
                                    size: 22,
                                  ),
                                if (_answered &&
                                    e.key == _selected &&
                                    e.key != q['ans'])
                                  const Icon(
                                    Icons.cancel_rounded,
                                    color: CosmoColors.red,
                                    size: 22,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
//  RESULT SCREEN
// ══════════════════════════════════════════════
class ResultScreen extends StatefulWidget {
  final int score;
  final List<Map<String, dynamic>> questions;
  final List<int> userAnswers;
  const ResultScreen({
    super.key,
    required this.score,
    required this.questions,
    required this.userAnswers,
  });
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  int _viewTab = 0; // 0=Result, 1=Review

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  int get _correct => widget.userAnswers
      .asMap()
      .entries
      .where((e) => e.value == widget.questions[e.key]['ans'])
      .length;
  int get _total => widget.questions.length;
  double get _pct => _correct / _total;

  String get _grade {
    if (_pct >= 0.9) return '🏆 Cosmic Master!';
    if (_pct >= 0.7) return '⭐ Star Explorer!';
    if (_pct >= 0.5) return '🚀 Space Cadet!';
    return '🌱 Keep Learning!';
  }

  Color get _gradeColor {
    if (_pct >= 0.9) return CosmoColors.gold;
    if (_pct >= 0.7) return CosmoColors.electric;
    if (_pct >= 0.5) return CosmoColors.cyan;
    return CosmoColors.muted;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: CosmoColors.bg,
    body: SafeArea(
      child: Column(
        children: [
          // Tab bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: ['Results', 'Review']
                  .asMap()
                  .entries
                  .map(
                    (e) => GestureDetector(
                      onTap: () => setState(() => _viewTab = e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: _viewTab == e.key
                              ? CosmoColors.electric
                              : CosmoColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: _viewTab == e.key
                              ? [
                                  BoxShadow(
                                    color: CosmoColors.electric.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 10,
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          e.value,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _viewTab == e.key
                                ? Colors.white
                                : CosmoColors.muted,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(child: _viewTab == 0 ? _buildResult() : _buildReview()),
        ],
      ),
    ),
  );

  Widget _buildResult() => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        const SizedBox(height: 20),
        ScaleTransition(
          scale: _scale,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _gradeColor.withOpacity(0.1),
              border: Border.all(color: _gradeColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: _gradeColor.withOpacity(0.4),
                  blurRadius: 50,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.score}',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                      color: _gradeColor,
                    ),
                  ),
                  const Text(
                    'points',
                    style: TextStyle(fontSize: 13, color: CosmoColors.muted),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _grade,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: CosmoColors.cream,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$_correct/$_total correct · ${(_pct * 100).toInt()}% accuracy',
          style: const TextStyle(fontSize: 14, color: CosmoColors.muted),
        ),
        const SizedBox(height: 32),
        // Stats grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.2,
          children: [
            _statCard('✅ Correct', '$_correct', CosmoColors.green),
            _statCard('❌ Wrong', '${_total - _correct}', CosmoColors.red),
            _statCard('⚡ Points', '${widget.score}', CosmoColors.gold),
            _statCard(
              '📊 Accuracy',
              '${(_pct * 100).toInt()}%',
              CosmoColors.cyan,
            ),
          ],
        ),
        const SizedBox(height: 28),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const QuizLanding()),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  CosmoColors.cobalt,
                  CosmoColors.electric,
                  CosmoColors.cyan,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: CosmoColors.electric.withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Play Again 🚀',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );

  Widget _statCard(String label, String val, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: CosmoColors.muted),
        ),
        const Spacer(),
        Text(
          val,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    ),
  );

  Widget _buildReview() => ListView.builder(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
    itemCount: widget.questions.length,
    itemBuilder: (_, i) {
      final q = widget.questions[i];
      final userAns = widget.userAnswers[i];
      final correct = userAns == q['ans'];
      final catColor = catColors[q['cat']] ?? CosmoColors.electric;
      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CosmoColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: correct
                ? CosmoColors.green.withOpacity(0.3)
                : CosmoColors.red.withOpacity(0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: correct ? CosmoColors.green : CosmoColors.red,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: catColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    q['cat'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: catColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              q['q'] as String,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: CosmoColors.cream,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '✅ ${(q['opts'] as List)[q['ans']]}',
              style: const TextStyle(fontSize: 12, color: CosmoColors.green),
            ),
            if (!correct && userAns >= 0)
              Text(
                '❌ Your answer: ${(q['opts'] as List)[userAns]}',
                style: const TextStyle(fontSize: 12, color: CosmoColors.red),
              ),
            if (userAns < 0)
              const Text(
                '⏱ Time\'s up!',
                style: TextStyle(fontSize: 12, color: CosmoColors.muted),
              ),
          ],
        ),
      );
    },
  );
}

// ══════════════════════════════════════════════
//  STARFIELD PAINTER
// ══════════════════════════════════════════════
class _StarfieldPainter extends CustomPainter {
  final double t;
  static final _rng = Random(99);
  static final _stars = List.generate(
    60,
    (_) => [
      _rng.nextDouble(),
      _rng.nextDouble(),
      _rng.nextDouble() * 2 + 0.5,
      _rng.nextDouble(),
    ],
  );

  _StarfieldPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in _stars) {
      final opacity = (sin((s[3] + t * 0.5) * 2 * pi) * 0.5 + 0.5) * 0.5;
      canvas.drawCircle(
        Offset(s[0] * size.width, s[1] * size.height),
        s[2],
        Paint()..color = CosmoColors.neon.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_StarfieldPainter o) => o.t != t;
}
