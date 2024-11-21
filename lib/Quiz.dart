import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<Quiz> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'ما هو أكبر كوكب في النظام الشمسي؟',
      'answers': ['الأرض', 'المريخ', 'المشتري', 'زحل'],
      'correctAnswer': 'المشتري',
      'image': 'assets/jupiter.png', // Image associée à la question
    },
    {
      'question': 'أي كوكب يعتبر الأكثر حرارة في النظام الشمسي؟',
      'answers': ['عطارد', 'الزهرة', 'المريخ', 'المشتري'],
      'correctAnswer': 'الزهرة',
      'image': 'assets/venus.png', // Image associée à la question
    },
    {
      'question': 'ما هو الكوكب الأحمر؟',
      'answers': ['المريخ', 'الأرض', 'عطارد', 'نبتون'],
      'correctAnswer': 'المريخ',
      'image': 'assets/mars.png', // Image associée à la question
    },
  ];

  void _nextQuestion(String answer) {
    if (answer == _questions[_questionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نتيجة الاختبار'),
        content: Text('لقد حصلت على $_score من ${_questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _score = 0;
                _questionIndex = 0;
              });
            },
            child: const Text('إعادة الاختبار'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('مشاهدة فيديو'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              "النظام الشمسي",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    _questions[_questionIndex]['question'] as String,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                    width: 20), // Espacement entre la question et l'image
                Image.asset(
                  _questions[_questionIndex]['image']
                      as String, // Image correspondant à la question
                  width: 100, // Taille de l'image
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 40), // Espacement avant les réponses
            Column(
              children: (_questions[_questionIndex]['answers'] as List<String>)
                  .map((answer) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () => _nextQuestion(answer),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 8,
                          ),
                          child: Text(
                            answer,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  const QuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Quiz()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellowAccent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
      ),
      icon: const Icon(Icons.quiz, color: Colors.deepPurple, size: 30),
      label: const Text(
        "اختبر معلوماتك عن النظام الشمسي",
        style: TextStyle(
          fontSize: 18,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Page d'accueil"),
      ),
      body: const Center(
        child: QuizButton(),
      ),
    ),
  ));
}
