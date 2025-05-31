// lib/people_chat.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image selection
import 'dart:io'; // For File class

class PeopleChatPage extends StatefulWidget {
  const PeopleChatPage({Key? key}) : super(key: key);

  @override
  State<PeopleChatPage> createState() => _PeopleChatPageState();
}

class _PeopleChatPageState extends State<PeopleChatPage> {
  final TextEditingController _queryController = TextEditingController();
  File? _selectedImage; // To hold the selected image
  final ImagePicker _picker = ImagePicker();

  // State variable to hold the currently selected filter
  String? _selectedFilter; // Null means no filter selected (show all)

  // A list to hold your chat post data.
  // In a real application, this would come from an API or database.
  final List<Map<String, dynamic>> _allChatPosts = [
    {
      'imagePath': 'assets/images/chat_1.png',
      'userName': 'Plant Supplier BD',
      'timeAgo': '9 Hrs',
      'postText':
      'আমার মনি প্ল্যান্টের পাতায় কিছু বাদামী দাগ পড়েছে আর কিছু পাতা হলুদ হয়ে যাচ্ছে। মনে হচ্ছে কোনো রোগ হয়েছে, কিন্তু ঠিক বুঝতে পারছি না। কেউ কি বলে দিতে পারবেন এটা কী রোগ হতে পারে? আর এর জন্য কোন ওষুধ বা সার ব্যবহার করবো?',
      'tags': ['Tomato', 'Disease'], // Example tag
    },
    {
      'imagePath': 'assets/images/chat_2.png',
      'userName': 'Monirul Islam',
      'timeAgo': '10 Hrs',
      'postText':
      'আমার গাছের পাতায় ছোট ছোট কালো দাগ দেখা যাচ্ছে, আর ধীরে ধীরে পাতা শুকিয়ে যাচ্ছে 😥 আমি ঠিক বুঝতে পারছি না এটা কী ধরনের রোগ হতে পারে। কেউ যদি এরে এমন সমস্যায় পড়েন, দয়া করে একটু সাহায্য করবেন?',
      'tags': ['Beans', 'Pest'], // Example tag
    },
    {
      'imagePath': 'assets/images/tomato.png', // Example of a different image
      'userName': 'Farm Fresh',
      'timeAgo': '12 Hrs',
      'postText': 'Anyone knows good organic fertilizer for tomatoes? 🌱',
      'tags': ['Tomato', 'Fertilizer'], // Example tag
    },
    {
      'imagePath': 'assets/images/bougainvillea.png', // Another example
      'userName': 'Green Thumb',
      'timeAgo': '1 Day',
      'postText': 'Having trouble growing garlic. Any tips for beginners?',
      'tags': ['Garlic', 'Gardening Tips'], // Example tag
    },
  ];

  List<Map<String, dynamic>> _filteredChatPosts = [];

  @override
  void initState() {
    super.initState();
    _queryController.text = ''; // Ensure query field is empty initially
    _filteredChatPosts = List.from(_allChatPosts); // Initialize with all posts
  }

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

  void _postQuery() {
    // In a real app, you would send _queryController.text and _selectedImage
    // to a backend/database. For now, we'll just show a message and reset.
    print('Query: ${_queryController.text}');
    if (_selectedImage != null) {
      print('Image path: ${_selectedImage!.path}');
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your Post is posted!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Reset fields
    setState(() {
      _queryController.clear();
      _selectedImage = null;
    });
  }

  // Function to apply the filter
  void _applyFilter(String? filter) {
    setState(() {
      _selectedFilter = filter; // Set the new filter
      if (_selectedFilter == null) {
        _filteredChatPosts = List.from(_allChatPosts); // Show all if no filter
      } else {
        // Filter posts where any of their tags contain the selected filter
        _filteredChatPosts = _allChatPosts.where((post) {
          List<String> tags = List<String>.from(post['tags'] ?? []);
          return tags.any((tag) => tag.toLowerCase() == _selectedFilter!.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
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
                  'assets/images/logo.png', // Assuming logo.png is still in assets/images
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
            onPressed: () {},
            icon: const Icon(Icons.upload, color: Colors.white, size: 24), // Assuming upload for share/action
          ),
        ],
      ),
      body: Column(
        children: [
          // Header for "COMMUNITY CHAT" and Post Your Queries
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFF9FBE7), // Light green background
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'COMMUNITY CHAT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _queryController,
                        maxLines: 5,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Post Your Queries',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                      if (_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _selectedImage!,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined, size: 30, color: Colors.grey),
                              onPressed: _pickImage, // Call image picker
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _postQuery, // Call post function
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Post',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Horizontal Tags (Tomato, Beans, Garlic) - Now interactive filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTagButton('Tomato', const Color(0xFFD6775C), 'Tomato'),
                _buildTagButton('Beans', const Color(0xFF4CAF50), 'Beans'),
                _buildTagButton('Garlic', const Color(0xFF8BC34A), 'Garlic'),
                // Optionally add a button to show all posts
                _buildTagButton('All', Colors.grey, null), // 'null' to indicate no filter
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Scrollable list of chat posts
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: _filteredChatPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredChatPosts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0), // Add spacing between posts
                  child: _buildChatPost(
                    imagePath: post['imagePath'],
                    userName: post['userName'],
                    timeAgo: post['timeAgo'],
                    postText: post['postText'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Modified _buildTagButton to handle filtering and highlighting
  Widget _buildTagButton(String text, Color color, String? filterValue) {
    final bool isSelected = _selectedFilter == filterValue;
    return GestureDetector(
      onTap: () => _applyFilter(filterValue),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D32) : color, // Use primary green if selected
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : Colors.transparent, // Border for selected
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white, // Text color remains white
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildChatPost({
    required String imagePath,
    required String userName,
    required String timeAgo,
    required String postText,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image of the plant
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180, // Fixed height for consistency
            ),
          ),
          const SizedBox(height: 15),
          // User Info and Time
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF8BC34A), // Green avatar background
                child: Icon(Icons.person, color: Colors.white, size: 20), // Placeholder for user profile pic
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Post Text
          Text(
            postText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          // Reply and Like/Dislike/Favorite buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // TODO: Implement reply functionality
                },
                child: const Text(
                  'Reply',
                  style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Implement like functionality
                    },
                    icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey, size: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement dislike functionality
                    },
                    icon: const Icon(Icons.thumb_down_alt_outlined, color: Colors.grey, size: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement favorite functionality
                    },
                    icon: const Icon(Icons.favorite_outline, color: Colors.grey, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}