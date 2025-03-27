import 'package:figma_foodapp/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OrderSuccessScreen(),
    );
  }
}

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 60),

              // Animated Checkmark with Dots
              Image.asset(
                'assets/icons/success.png', // Use a Lottie animation or a custom image
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 30),

              // Success Message
              const Text(
                "Your order has been\nsuccessfully placed",
                textAlign: TextAlign.center,
                style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 22,
                          fontFamily: 'DMSans', // Use your required font
                          fontWeight: FontWeight.bold, // Adjust weight if needed
                        ),
              ),

              const SizedBox(height: 15),

              // Order Description
              const Text(
                "Sit and relax while your order is being worked on. It'll take 5min before you get it.",
                textAlign: TextAlign.center,
                style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 14,
                          fontFamily: 'DMSans', // Use your required font
                          fontWeight: FontWeight.normal, // Adjust weight if needed
                        ),
              ),

              const Spacer(),

              // Go Back to Home Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 335,
                  height: 51,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF9881F), Color(0xFFFF774C)], // 🌈 Gradient Colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDeliveryApp(),
                                      ),
                                    );
                      // Navigate back to home or another screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Go back to home",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
