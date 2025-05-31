import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ClassifierScreen extends StatefulWidget {
  const ClassifierScreen({super.key});

  @override
  _ClassifierScreenState createState() => _ClassifierScreenState();
}

class _ClassifierScreenState extends State<ClassifierScreen> {
  File? _image;
  bool _loading = false;
  String _result = "No image selected";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/plant_model.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _loading = true;
        _image = File(picked.path);
        _result = "Processing...";
      });

      classifyImage(_image!);
    }
  }

  Future<void> classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 0.0, // Because you used rescale=1./255 in training
      imageStd: 1.0,
    );

    if (output != null && output.isNotEmpty) {
      setState(() {
        _loading = false;
        _result = output[0]["label"];
      });
    } else {
      setState(() {
        _loading = false;
        _result = "Could not classify image.";
      });
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Disease Classifier'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image == null
              ? Container(
                  height: 250,
                  child: Center(child: Text("No image selected")),
                )
              : Image.file(_image!),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickImage,
            child: Text('Select Image'),
          ),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
