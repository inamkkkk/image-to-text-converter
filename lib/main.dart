import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_to_text_converter/screens/home_screen.dart';
import 'package:image_to_text_converter/services/image_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ImageService(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image to Text Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}