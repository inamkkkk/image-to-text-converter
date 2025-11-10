import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image_to_text_converter/services/image_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  String _extractedText = '';

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });

    final imageService = Provider.of<ImageService>(context, listen: false);
    final text = await imageService.extractTextFromImage(_image!); // Use _image!
    setState(() {
      _extractedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to Text Converter'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_image != null)
                Image.file(_image!)
              else
                Text('No image selected'),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => _pickImage(ImageSource.gallery), child: Text('Pick Image from Gallery')),
              ElevatedButton(onPressed: () => _pickImage(ImageSource.camera), child: Text('Take Image with Camera')),
              SizedBox(height: 20),
              Text('Extracted Text:'),
              SizedBox(height: 10),
              Text(_extractedText, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}