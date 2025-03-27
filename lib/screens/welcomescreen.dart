import 'package:flutter/material.dart';
import 'create.dart';
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
      home: const SwipeScreen(),
    );
  }
}

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data for each page (text and image)
  final List<Map<String, dynamic>> _pages = [
    {
      'text': 'Order from your favourite\nstores or vendors',
      'image': 'assets/images/phonemap.png', // Replace with your image path
      
      'fontFamily': 'DMSans',
      'fontSize': '24',
      'fontWeight': FontWeight.bold,
    },
    {
      'text': 'Choose from a wide range of\ndelicious meals',
      'image': 'assets/images/dish.png', // Replace with your image path
      
      'fontFamily': 'DMSans',
      'fontSize': '24',
      'fontWeight': FontWeight.bold,
    },
    {
      'text': 'Enjoy instant delivery\nand payment',
      'image': 'assets/images/person.png', // Replace with your image path
      
      'fontFamily': 'DMSans',
      'fontSize': '24',
      'fontWeight': FontWeight.bold,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Row with Skip Button
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
                      
                      // Skip button action
                    },
                    child: const Text(
                      " ",
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

            // PageView for Swiping
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 40), // Add some spacing
                      Text(
                        _pages[index]['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF1C1C1C),
                          fontFamily: 'DMSans',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Image.asset(
                          _pages[index]['image']!,
                          fit: BoxFit.scaleDown,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Dot Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(isActive: index == _currentPage),
              ),
            ),

            const SizedBox(height: 30), // Spacing

            // Create an Account Button
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
                    begin: Alignment(0.42,0),
                    end: Alignment(0.54,1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CreateAccountScreen(),
                                    ),
                                  );
                                // Create an account button action
                  },
                  child: const Text(
                    "Create an account",
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

            // Login Button
            TextButton(
              onPressed: () {
                
                    
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                // Create an account button action
                  },
                // Login button action
              
              child: const Text(
                "login",
                style: TextStyle(
                  color: Color(0xFFFE554A),
                  fontSize: 16,
                  fontFamily: 'SkModernist',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20), // Bottom Spacing
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: isActive ? 10.0 : 8.0,
      height: isActive ? 10.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0B735F) : Color(0xFFC4C4C4),
        shape: BoxShape.circle,
      ),
    );
  }
}
