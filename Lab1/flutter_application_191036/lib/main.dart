import 'package:flutter/material.dart';
import 'package:flutter_application_191036/widgets/ClothingItemCard.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jakup Emini 191036',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  const Color.fromARGB(255, 0, 167, 251)),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        title: Text(widget.title, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),),
      ),
      body:   GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        children: const <Widget>[
          ClothingItemCard(price: 10, name: 'Red Jacket', imageUrl: 'https://plus.unsplash.com/premium_photo-1675186049366-64a655f8f537?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',),
          ClothingItemCard(price: 10, name: 'Item 2', imageUrl: 'https://picsum.photos/seed/b/400/300',),
          ClothingItemCard(price: 10, name: 'Item 3', imageUrl: 'https://picsum.photos/seed/c/400/300',),
          ClothingItemCard(price: 10, name: 'Item 4', imageUrl: 'https://picsum.photos/seed/d/400/300',),
          ClothingItemCard(price: 10, name: 'Item 5', imageUrl: 'https://picsum.photos/seed/e/400/300',),
          ClothingItemCard(price: 10, name: 'Item 6', imageUrl: 'https://picsum.photos/seed/f/400/300',),
          ClothingItemCard(price: 10, name: 'Item 7', imageUrl: 'https://picsum.photos/seed/g/400/300',),
          ClothingItemCard(price: 10, name: 'Item 8', imageUrl: 'https://picsum.photos/seed/h/400/300',),
          ClothingItemCard(price: 10, name: 'Item 9', imageUrl: 'https://picsum.photos/seed/i/400/300',),
          ClothingItemCard(price: 10, name: 'Item 10', imageUrl: 'https://picsum.photos/seed/j/400/300',),
          ClothingItemCard(price: 10, name: 'Item 11', imageUrl: 'https://picsum.photos/seed/k/400/300',),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
