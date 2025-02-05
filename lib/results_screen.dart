import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/data/quizz.dart';
import 'package:myapp/question_summary.dart';
import 'package:myapp/questions_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({required this.selectedAnswers, super.key});

  final List<String> selectedAnswers;

  List<Map<String, Object>> getSummeryData() {
    List<Map<String, Object>> summaryData = [];

    for (int i = 0; i < selectedAnswers.length; i++) {
      bool isCorrect = selectedAnswers[i] == questions[i].answers[0];

      summaryData.add({
        'question_id': i,
        'question': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswers[i],
        'is_correct': isCorrect
      });
    }
    return summaryData;
  }

  @override
Widget build(BuildContext context) {
  final summary = getSummeryData();
  final totalMark = summary.where((data) => data['is_correct'] as bool).length;
  final totalQuestion = summary.length;

  return Scaffold(
    backgroundColor: Colors.purple,
    body: SafeArea( // ✅ ป้องกันเนื้อหาล้น Notch บนมือถือบางรุ่น
      child: Column(
        children: [
          const SizedBox(height: 20), // เผื่อระยะห่างข้างบน

          // ✅ แสดงผลคะแนนที่ได้
          Text(
            'You answered $totalMark out of $totalQuestion questions correctly',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10), // เผื่อระยะห่าง

          // ✅ ใช้ Expanded ให้สามารถเลื่อนดูเนื้อหาได้
          Expanded(
            child: SingleChildScrollView(
              child: QuestionSummary(summary: summary),
            ),
          ),

          const SizedBox(height: 10), // เผื่อระยะห่าง

          // ✅ ปุ่ม Restart Quiz
          TextButton.icon(
            icon: const Icon(Icons.restart_alt, color: Colors.white),
            label: const Text(
              'Restart Quiz',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => QuestionsScreen()),
              );
            },
          ),

          const SizedBox(height: 20), // เผื่อระยะห่างข้างล่าง
        ],
      ),
    ),
  );
}

}
