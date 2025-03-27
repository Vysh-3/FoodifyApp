import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// **🔹 Function to Send Password Reset Email**
  Future<void> _resetPassword() async {
    if (emailController.text.isEmpty) {
      _showSnackbar("Please enter your email address.");
      return;
    }
    
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      _showSnackbar("Password reset email sent! Check your inbox.");
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); // Go back to Login Screen
      });
    } catch (e) {
      _showSnackbar("Error: ${e.toString()}");
    }
  }

  /// **🔹 Snackbar for Messages**
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **🔹 Top Row with Cancel Button**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50), // Empty space for symmetry
                    Image.asset(
                      'assets/icons/Icon.png', // Replace with your logo path
                      width: 34,
                      height: 23.25,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: 'SkModernist',
                          color: Color(0xFFFA5A1E),
                          fontSize: 14,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // **🔹 Title & Subtitle**
              const Text(
                "Forgot password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1C1C),
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your email address to request a password reset.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3D3D3D),
                  fontFamily: 'SkModernist',
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 50),

              // **🔹 Email Input Field**
              _buildTextField("Email Address", "Enter email address", emailController),
              const Spacer(),

              // **🔹 Reset Password Button**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 335,
                  height: 51,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF9881F),
                        Color(0xFFFF774C),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: _resetPassword, // Calls the function
                    child: const Text(
                      "Request reset link",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'SkModernist',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // **🔹 Back to Login Button**
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Color(0xFFFE554A),
                      fontSize: 16,
                      fontFamily: 'SkModernist',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20), // Bottom Spacing
            ],
          ),
        ),
      ),
    );
  }

  /// **🔹 Email Input Field Widget**
  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
            fontFamily: 'SkModernist',
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFFAAACAE),
              fontFamily: 'SkModernist',
              fontWeight: FontWeight.normal,
            ),
            filled: true,
            fillColor: Color(0xFFFFFFFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFDFE2E5),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDFE2E5),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
