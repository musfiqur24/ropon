// lib/upload_post.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({Key? key}) : super(key: key);

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // Define controllers for text fields
  final TextEditingController _sellerNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productDetailsController = TextEditingController();
  final TextEditingController _sellerAddressController = TextEditingController();

  // State for quantity
  int _quantity = 1; // Default quantity

  // State for delivery mode
  String _selectedDeliveryMode = 'Pick Up';

  // State for the selected image file
  File? _selectedImage; // Nullable File to hold the selected image

  // Image Picker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize quantity controller text when the widget is created
    _quantityController.text = _quantity.toString();
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _selectedImage = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  // Function to reset all input fields
  void _resetFields() {
    setState(() {
      _sellerNameController.clear();
      _productNameController.clear();
      _priceController.clear();
      _productDetailsController.clear();
      _sellerAddressController.clear();
      _quantity = 1;
      _quantityController.text = _quantity.toString(); // Reset quantity text field
      _selectedDeliveryMode = 'Pick Up';
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    _sellerNameController.dispose();
    _productNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _productDetailsController.dispose();
    _sellerAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', // Ensure you have your logo here
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'রোপণ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white, size: 24),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement share functionality if needed
            },
            icon: const Icon(Icons.upload, color: Colors.white, size: 24), // Using upload icon for share
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'POST YOUR PLANT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Image Upload Area
            GestureDetector(
              onTap: _pickImage, // Call the image picking function
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                      const Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Name of Seller
            _buildTextField('Name of Seller', _sellerNameController),
            const SizedBox(height: 15),

            // Name of Product
            _buildTextField('Name of Product', _productNameController),
            const SizedBox(height: 15),

            // Price and Quantity
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField('Price', _priceController, keyboardType: TextInputType.number),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      _buildQuantityButton(Icons.remove, () {
                        setState(() {
                          if (_quantity > 1) _quantity--;
                          _quantityController.text = _quantity.toString();
                        });
                      }),
                      Expanded(
                        child: _buildTextField('', _quantityController, keyboardType: TextInputType.number, textAlign: TextAlign.center),
                      ),
                      _buildQuantityButton(Icons.add, () {
                        setState(() {
                          _quantity++;
                          _quantityController.text = _quantity.toString();
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Product Details
            _buildTextField('Product Details', _productDetailsController, maxLines: 5),
            const SizedBox(height: 20),

            // Delivery Mode
            const Text(
              'Delivery Mode',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDeliveryModeButton('Pick Up'),
                _buildDeliveryModeButton('Meet Up'),
                _buildDeliveryModeButton('Delivery'),
              ],
            ),
            const SizedBox(height: 20),

            // Seller Address
            _buildTextField('Seller Address', _sellerAddressController, maxLines: 3),
            const SizedBox(height: 30),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('CANCEL', Colors.red.shade700, () {
                  Navigator.pop(context); // Go back
                }),
                _buildActionButton('POST', const Color(0xFF2E7D32), () {
                  // In a real app, you would send this data to your backend
                  // For demonstration, we'll just print and reset
                  print('--- POSTing Data ---');
                  print('Seller Name: ${_sellerNameController.text}');
                  print('Product Name: ${_productNameController.text}');
                  print('Price: ${_priceController.text}');
                  print('Quantity: $_quantity');
                  print('Product Details: ${_productDetailsController.text}');
                  print('Delivery Mode: $_selectedDeliveryMode');
                  print('Seller Address: ${_sellerAddressController.text}');
                  if (_selectedImage != null) {
                    print('Image Path: ${_selectedImage!.path}');
                  } else {
                    print('No image selected for upload.');
                  }
                  print('--------------------');

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your Post Successfully posted!'),
                      duration: Duration(seconds: 2), // How long the snackbar stays
                    ),
                  );

                  // Reset all fields
                  _resetFields();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller, {int maxLines = 1, TextInputType keyboardType = TextInputType.text, TextAlign textAlign = TextAlign.start}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF8BC34A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildDeliveryModeButton(String mode) {
    final bool isSelected = _selectedDeliveryMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDeliveryMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF2E7D32) : Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          mode,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}