import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter_application_191036/widgets/blurred_app_bar.dart';
import 'package:flutter_application_191036/widgets/clothing_item_card.dart';

void main() {
  runApp(const MyApp());
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
  List<dynamic> clothingItems = [];

  @override
  void initState() {
    super.initState();
    _loadClothingItems();
  }

  Future<void> _loadClothingItems() async {
    // Load the JSON file
    final String response = await rootBundle.loadString('assets/clothing_items.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      clothingItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BlurredAppBar(
        title: widget.title,
      ),
      body: clothingItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.7,
              children: clothingItems.map((item) {
                return ClothingItemCard(
                  price: item['price'],
                  name: item['name'],
                  imageUrl: item['imageUrl'],
                  description: item['description'],
                );
              }).toList(),
            ),
    );
  }
}
