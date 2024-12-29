import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_type_model.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/blurred_app_bar.dart';
import 'package:jokes_app/widgets/joke_type_card.dart';
import 'package:jokes_app/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  
  final notificationService = NotificationService();
  await notificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final apiService = ApiService();
    var jokeOfTheDay = await apiService.getRandomJokeOfTheDay();
    notificationService.showNotification(message, "Joke of the day!", jokeOfTheDay.setup ?? "Open to see");
  });


  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jakup Emini 191036',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 167, 251)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '191036'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiService apiService;
  List<JokeTypeModel> jokeTypes = [];

   @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchJokeTypes();
  }

  Future<void> fetchJokeTypes() async {
    final data = await apiService.getJokeTypes();
      setState(() {
        jokeTypes = data;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BlurredAppBar(
        title: widget.title,
      ),
      body: jokeTypes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeTypeCard(
                  type: jokeTypes[index].type,
                );
              },
            ),
    );
  }
}
