import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7),
      body: SafeArea(
        child: Stack(
          children: [
            // Background leaf decorations
            Positioned(
              top: -50,
              right: -30,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/leaf_decoration.png', // Add your leaf decoration
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -50,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/background.png', // Add your leaf decoration
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            // Main content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    // Logo
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png', // Your green shopping cart logo
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Title
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Username field
                    _buildTextField(
                      controller: _usernameController,
                      hintText: 'Enter Username',
                    ),

                    const SizedBox(height: 16),

                    // Contact Number field
                    _buildTextField(
                      controller: _contactController,
                      hintText: 'Enter Contact Number',
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 16),

                    // Email field
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Enter Email Address',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    // Password field
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password field
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 40),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle sign up
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}