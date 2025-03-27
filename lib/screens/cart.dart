import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'cart_provider.dart';
import '../models/product_model.dart';
import 'orderplaced.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorpay;
  final CartProvider cartProvider = CartProvider();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful: ${response.paymentId}",
        toastLength: Toast.LENGTH_LONG);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed: ${response.message}",
        toastLength: Toast.LENGTH_LONG);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet Selected: ${response.walletName}",
        toastLength: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF8FBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **🔹 Top Bar Section**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF000000)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    children: [
                      Text(
                        "Delivery to:",
                        style: TextStyle(
                                  color: Color(0xFF1C1C1C),
                                  fontSize: 14,
                                  fontFamily: 'SkModernist', // Use your required font
                                  fontWeight: FontWeight.normal,
                      ),
                      ),
                      Text(
                        "Address",
                                style: TextStyle(
                                  color: Color(0xFFFE554A),
                                  fontSize: 15,
                                  fontFamily: 'SkModernist', // Use your required font
                                  fontWeight: FontWeight.normal, // Adjust weight if needed
                                  ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// **🔹 Page Title**
              Text(
                "Your cart",
                style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 24,
                          fontFamily: 'DMSans', // Use your required font
                          fontWeight: FontWeight.bold, // Adjust weight if needed
                        ),
              ),

              const SizedBox(height: 20),

              /// **🔹 Cart Items**
              Expanded(
                child: cartProvider.cartItems.isEmpty
                    ? const Center(child: Text(
                      "Your cart is empty!", 
                      style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 20,
                          fontFamily: 'DMSans', // Use your required font
                          fontWeight: FontWeight.bold, // Adjust weight if needed
                        ),))
                    : ListView.builder(
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          final product = cartProvider.cartItems[index];
                          return _buildCartItem(context, product, cartProvider);
                        },
                      ),
              ),

              /// **🔹 Total Price**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 14,
                              fontFamily: 'SkModernist', // Use your required font
                              fontWeight: FontWeight.normal,
                      )
                    ),
                    Text(
                      "₹${cartProvider.totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 24,
                              fontFamily: 'SkModernist', // Use your required font
                              fontWeight: FontWeight.bold,
                      )
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10), // Reduced space between Total and Button

              /// **🔹 "Proceed to Payment" Button**
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: SizedBox(
                    width: 335,
                    height: 51,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF9881F), Color(0xFFFF774C)],
                          begin: Alignment(0.42, 0),
                          end: Alignment(0.54, 1),
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          final options = {
                            'key': 'YOUR_rzp_test_KEY',
                            'amount': (cartProvider.totalPrice * 100).toInt(),
                            'name': 'Foodify',
                            'description': 'Cart Payment',
                            'prefill': {
                              'contact': '9876543210',
                              'email': 'vysh@gmail.com'
                            }
                          };
                          try {
                            _razorpay.open(options);
                          } catch (e) {
                            debugPrint('Error: $e');
                          }
                        },
                        child: Text(
                          "Proceed to payment",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontFamily: 'SkModernist', // Use your required font
                              fontWeight: FontWeight.bold,)
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **🔹 Widget for Cart Items**
  Widget _buildCartItem(
      BuildContext context, ProductModel product, CartProvider cartProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(product.image, width: 60, height: 60),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 16,
                              fontFamily: 'DMSans', // Use your required font
                              fontWeight: FontWeight.bold, // Adjust weight if needed
                            )
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF3D3D3D))
                ),
                const SizedBox(height: 5),
                Text(
                  "₹${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Color(0xFFFE554A),
                    fontSize: 16,
                    fontFamily: 'DMSans', // Use your required font
                    fontWeight: FontWeight.bold, // Adjust weight if needed
                     )
                ),
              ],
            ),
          ),
          _buildQuantitySelector(cartProvider, product),
          const SizedBox(width: 10),
          _buildDeleteButton(cartProvider, product),
        ],
      ),
    );
  }

  /// **🔹 Quantity Selector**
  Widget _buildQuantitySelector(CartProvider cartProvider, ProductModel product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => cartProvider.decreaseQuantity(product),
          child: const Icon(Icons.remove_circle_outline,
              color: Colors.orangeAccent, size: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "${product.quantity}",
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 16,
                fontFamily: 'DMSans', // Use your required font
                fontWeight: FontWeight.bold, // Adjust weight if needed
                )
          ),
        ),
        GestureDetector(
          onTap: () => cartProvider.addToCart(product, 1),
          child: const Icon(Icons.add_circle_outline,
              color: Colors.orangeAccent, size: 16),
        ),
      ],
    );
  }

  /// **🔹 Delete Button**
  Widget _buildDeleteButton(CartProvider cartProvider, ProductModel product) {
    return GestureDetector(
      onTap: () => cartProvider.removeFromCart(product),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
      ),
    );
  }
}