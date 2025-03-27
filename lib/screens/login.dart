import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'homescreen.dart';
import 'create.dart';
import 'forgot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    setState(() => isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FoodDeliveryApp()),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackbar(e.message ?? "Login failed!");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FoodDeliveryApp()),
      );
    } catch (e) {
      _showSnackbar("Google Sign-In failed!");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Optional: Gives smooth scrolling effect
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row with Skip Button
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50),
                    Image.asset(
                      'assets/icons/Icon.png',
                      width: 34,
                      height: 23.25,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodDeliveryApp(),
                          ),
                        );
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontFamily: 'SkModernist',
                          color: Color(0xFFFA5A1E),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              

              // Title Section
              const Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1C1C),
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Good to see you again, enter your details\nbelow to continue ordering.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3D3D3D),
                  fontFamily: 'SkModernist',
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 54),

              // Input Fields
              _buildTextField("Email Address", "Enter email", emailController),
              const SizedBox(height: 20),
              _buildTextField("Password", "Enter password", passwordController,
                  obscureText: true),
              
              // Forgot Password Button (Align to Right)
Align(
  alignment: Alignment.centerRight,
  child: TextButton(
    onPressed: () {
      // Navigate to Forgot Password Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
      );
    },
    child: const Text(
      "Forgot Password?",
      style: TextStyle(
        color: Color(0xFFFE554A), // Orange theme color
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'SkModernist',
      ),
    ),
  ),
),

              const SizedBox(height: 55),

              // Google Sign-in Button
              Center(
                child: SizedBox(
                  width: 210,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signInWithGoogle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFFFFF),
                      shadowColor: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 11),
                              const Text(
                                "Sign-in with Google",
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 14,
                                  fontFamily: 'SkModernist',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 335,
                  height: 51,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF9881F),
                        Color(0xFFFF774C),
                      ],
                      begin: Alignment(0.42, 0),
                      end: Alignment(0.54, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: isLoading ? null : _login,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Login to my account",
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

              // Create Account Button
              Center(
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccountScreen(),
                            ),
                          );
                        },
                  child: const Text(
                    "Create an account",
                    style: TextStyle(
                      color: Color(0xFFFE554A),
                      fontSize: 16,
                      fontFamily: 'SkModernist',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool obscureText = false}) {
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
          obscureText: obscureText,
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
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFFFFFFF),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}