import 'package:figma_foodapp/product_model.dart';
import 'package:flutter/material.dart';
import 'package:figma_foodapp/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailScreen(
        product: ProductModel(
          image: "assets/images/burger.png",
          title: "Big Cheese Burger",
          price: 23.99,
          description: "No 10 opp lekki phase 1 bridge in sangotedo estate",
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {

  final ProductModel product;
  
  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1; // Default quantity

  @override
Widget build(BuildContext context) {
  Provider.of<CartProvider>(context);

  return Scaffold(
    backgroundColor: const Color(0xFFF8FBFF),
    body: SafeArea(
      child: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Navigation (Back Button, Delivery, Profile)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        children: [
                          const Text(
                            "Delivery to:",
                            style: TextStyle(
                        fontFamily: 'SkModernist',
                        color: Color(0xFF1C1C1C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                          ),
                          const Text(
                            "Address",
                            style: TextStyle(
                        fontFamily: 'SkModernist',
                        color: Color(0xFFFE554A),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/profile.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Product Image in Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF02202C).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: Image.asset(
                      widget.product.image,
                      width: 230,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Quantity Selector
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF9881F),
                          Color(0xFFFF774C),
                        ],
                        begin: Alignment(0.42, 0),
                        end: Alignment(0.54, 1),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(Icons.remove, color: Color(0xFFFFFFFF), size: 14),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "$quantity",
                          style: TextStyle(fontFamily: 'SkModernist', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Product Title
                  Text(
                    widget.product.title,
                    style: const TextStyle(fontFamily: 'DMSans', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF3D3D3D)),
                  ),
                  const SizedBox(height: 20),

                  // Rating, Calories, and Delivery Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Color(0xFFF5A62E), size: 18),
                      const Text(
                        " 4+    ",
                        style: TextStyle(fontFamily: 'SkModernist', fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xFF3D3D3D)),
                      ),
                      const Icon(Icons.local_fire_department, color: Colors.red, size: 18),
                      const Text(
                        " 300cal    ",
                        style: TextStyle(fontFamily: 'SkModernist', fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xFF3D3D3D)),
                      ),
                      const Icon(Icons.timer, color: Colors.black54, size: 18),
                      const Text(
                        " 5-10min",
                        style: TextStyle(fontFamily: 'SkModernist', fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xFF3D3D3D)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Product Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'SkModernist', fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF3D3D3D)),
                    ),
                  ),
                  // Removed SizedBox(height: 200) here
                ],
              ),
            ),
          ),

          // Add to Cart Button (Fixed at bottom)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
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
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(widget.product, quantity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Cart!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                        fontFamily: 'SkModernist',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}