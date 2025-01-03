import 'package:flutter/material.dart';
import 'package:student_calendar/models/ExamModel.dart';
import 'package:student_calendar/screens/google_map_screen.dart';
import 'package:student_calendar/widgets/exam_card.dart';
import 'package:student_calendar/widgets/my_app_bar.dart';

var exams = [
  ExamModel(
      name: "Math June Exam",
      examName: "Math",
      date: DateTime.utc(2024, 12, 25),
      id: 1),
  ExamModel(
      name: "Calculus June Exam",
      examName: "Calculus",
      date: DateTime.utc(2024, 12, 26)),
  ExamModel(
      name: "Structural programming",
      examName: "Structural programming",
      date: DateTime.utc(2025, 1, 1)),
  ExamModel(
      name: "Advanced programming June",
      examName: "Advanced programming",
      date: DateTime.utc(2024, 12, 27)),
  ExamModel(
      name: "Advanced web programming January",
      examName: "Advanced web programming January",
      date: DateTime.utc(2024, 12, 27))
];

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  DateTime? selectedDate;
  List<ExamModel> filteredExams = exams;
  ExamModel? todaysExam = exams
      .where((exam) =>
          exam.date!.year == DateTime.now().year &&
          exam.date!.month == DateTime.now().month &&
          exam.date!.day == DateTime.now().day)
      .firstOrNull;

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        // Filter exams based on the selected date
        filteredExams = exams
            .where((exam) =>
                exam.date!.year == pickedDate.year &&
                exam.date!.month == pickedDate.month &&
                exam.date!.day == pickedDate.day)
            .toList();
      });
    }
  }

  void _clearFilter() {
    setState(() {
      selectedDate = null;
      filteredExams = exams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "191036 - Student Calendar"),
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        onDestinationSelected: (int index) {
          _onItemTapped(index);
        },
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_rounded),
            label: 'Map',
          ),
        ],
      ),
      body: currentPageIndex == 0 ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text("Filter by Date"),
                ),
                selectedDate != null
                    ? ElevatedButton(
                        onPressed: _clearFilter,
                        child: const Text("X Clear Selection"),
                      )
                    : Container(),
              ],
            ),
          ),
          todaysExam != null
              ? Column(
                  children: [
                    const Text(
                      "Todays Exams: ",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ExamCard(
                      name: todaysExam?.name,
                      examName: todaysExam?.examName,
                      date: todaysExam?.date ?? DateTime.now(),
                      id: todaysExam?.id,
                    )
                  ],
                )
              : Container(
                child: const Text(
                      "No Exams today :)",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
          Divider(color: Colors.blueGrey.shade300),
          const Text(
                      "All Exams:",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExams.length,
              itemBuilder: (context, index) {
                return ExamCard(
                  name: filteredExams[index].name,
                  examName: filteredExams[index].examName,
                  date: filteredExams[index].date!,
                  id: filteredExams[index].id,
                );
              },
            ),
          ),
        ],
      ) :
      MapSample()
    );
  }
}
