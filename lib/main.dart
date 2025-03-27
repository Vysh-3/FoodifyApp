import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:figma_foodapp/cart_provider.dart';
import 'package:figma_foodapp/homescreen.dart';
import 'package:figma_foodapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // ✅ Starts with Splash Screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Check if user is logged in
    Timer(const Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // ✅ If user is logged in, go to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // ✅ If no user, go to SwipeScreen (Screen1)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SwipeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: Center(
        child: Image.asset(
          'assets/icons/Icon.png', 
          width: 105.35,
          height: 72.06,
        ),
      ),
    );
  }
}
