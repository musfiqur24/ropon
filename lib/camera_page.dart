// lib/camera_page.dart

import 'package:flutter/material.dart';
// UNCOMMENT THESE TWO LINES:
import "package:image_picker/image_picker.dart";
import 'dart:io'; // For File type if using image_picker

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // UNCOMMENT THIS LINE:
  File? _pickedImage;

  // UNCOMMENT THIS METHOD:
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera); // Use camera source

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Plant Image'),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display chosen image or a placeholder
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child:
              // UNCOMMENT THIS BLOCK:
              _pickedImage != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  _pickedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
                  :
              // This is the placeholder that's currently showing:
              const Icon(
                Icons.image,
                size: 100,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // UNCOMMENT THIS LINE AND REMOVE THE SNACKBAR:
                _takePicture();
                // REMOVE OR COMMENT OUT THIS SNACKBAR:
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Camera functionality will be implemented here!'),
                //     duration: Duration(seconds: 2),
                //   ),
                // );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Open Camera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}