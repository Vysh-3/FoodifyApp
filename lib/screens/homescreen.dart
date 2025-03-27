import 'package:figma_foodapp/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:figma_foodapp/cart.dart';
import 'package:figma_foodapp/favorites_page.dart';
import 'package:figma_foodapp/product_list.dart';
import 'package:figma_foodapp/product_model.dart';
import 'package:figma_foodapp/productdetail.dart';
import 'package:flutter/material.dart';
import 'welcomescreen.dart';

void main() {
  runApp(FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/favorites': (context) => FavoritesPage(favorites: []),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}


class _HomeScreenState extends State<HomeScreen> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth Instance
  User? user; // Store the logged-in user

  @override
  void initState() {
    super.initState();
    // Listen for user changes (including profile updates)
    _auth.userChanges().listen((User? updatedUser) {
      setState(() {
        user = updatedUser;
      });
    });
    _getCurrentUser(); // Fetch user details on screen load
  }

  void _getCurrentUser() {
    setState(() {
      user = _auth.currentUser; // Get the current logged-in user
    });
  }


  int categoryIndex = 0;
  List<ProductModel> favorites = [];
  final List<Category> categories = [
    Category(title: "Burgers", image: "assets/icons/burgericon.png"),
    Category(title: "Pizzas", image: "assets/icons/pizzaicon.png"),
    Category(title: "Sausages", image: "assets/icons/sauageicon.png"),
    Category(title: "Samosas", image: "assets/icons/samosaicon.png"),
  ];

  void toggleFavorite(ProductModel product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarMenu(user: user),
      backgroundColor: Color(0xFFF8FBFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(Icons.menu, size: 28, color: Color(0xFF000000),),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              "Delivery to:",
                                style: TextStyle(
                                  color: Color(0xFF1C1C1C),
                                  fontSize: 14,
                                  fontFamily: 'SkModernist', // Use your required font
                                  fontWeight: FontWeight.normal, // Adjust weight if needed
                                  ),
                                ),
                            const Text(
                              "Address",
                                style: TextStyle(
                                  color: Color(0xFFFE554A),
                                  fontSize: 15,
                                  fontFamily: 'SkModernist', // Use your required font
                                  fontWeight: FontWeight.normal, // Adjust weight if needed
                                  ),
                                )
                          ],
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    const Text(
                      "Enjoy Delicious food",
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 24,
                          fontFamily: 'DMSans', // Use your required font
                          fontWeight: FontWeight.bold, // Adjust weight if needed
                        ),
                      ),
                    

                    SizedBox(height: 20),
                    // Category List
                    SizedBox(
                      height: 109,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => SizedBox(width: 22),
                        itemCount: categories.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => setState(() => categoryIndex = index),
                          child: Container(
                            width: 81.75,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF3EC032)),
                              borderRadius: BorderRadius.circular(50),
                              color: categoryIndex == index
                                  ? Color(0xFFA9E88B).withOpacity(0.5) 
                                  : Color(0xFFC1DAF0).withOpacity(0.1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(categories[index].image, height: 30),
                                SizedBox(height: 5),
                                Text(categories[index].title,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'DMSans',
                                        fontWeight: FontWeight.normal,
                                        color: categoryIndex == index
                                            ? Color(0xFF000000)
                                            : Color(0xFF909AA3).withOpacity(0.5))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Popular dishes",
                            style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 16,
                              fontFamily: 'DMSans', // Use your required font
                              fontWeight: FontWeight.bold, // Adjust weight if needed
                            )
                            ),
                        const Text(" ",
                            style: TextStyle(
                              color: Color(0xFFFE554A),
                              fontSize: 14,
                              fontFamily: 'SkModernist', // Use your required font
                              fontWeight: FontWeight.normal, // Adjust weight if needed
                            )
                            ),
                      ],
                    ),

                    SizedBox(height: 25),
                    // Product Grid with Compact Cards
                    Expanded(
  child: SizedBox(
    height: 200, // 👈 Adjust the height to make it smaller
    child: GridView.builder(
      scrollDirection: Axis.horizontal, // 👈 Keep side-scrollable
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // 👈 1 row (adjust if needed)
        childAspectRatio: 1.8, // 👈 Adjust to make the card smaller
        mainAxisSpacing: 8, // 👈 Space between items
      ),
      itemCount: categorizeList().length,
      itemBuilder: (context, index) {
        final product = categorizeList()[index];
        return ProductCard(
          product: product,
          isFavorite: favorites.contains(product),
          onFavoritePressed: () => toggleFavorite(product),
        );
      },
    ),
  ),
),

                  ],
                ),
              ),
            ),
            BottomNavigationBarWidget(favorites: favorites),
          ],
        ),
      ),
    );
  }

  List<ProductModel> categorizeList() {
    switch (categoryIndex) {
      case 0: return burgerList;
      case 1: return pizzaList;
      case 2: return sausageList;
      case 3: return samosaList;
      default: return [];
    }
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xFFFFFFFF),
          
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.scaleDown, // Fill the available space
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey.shade600,
                        size: 18,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                            
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      product.description,
                      style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 12,
                              fontFamily: 'DMSans', // Use your required font
                              fontWeight: FontWeight.normal, // Adjust weight if needed
                            ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 13),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFF5A62E), size: 15),
                        SizedBox(width: 4),
                        Text(
                          "4+",
                          style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 12,
                              fontFamily: 'DMSans', // Use your required font
                              fontWeight: FontWeight.normal, // Adjust weight if needed
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  final List<ProductModel> favorites;

  const BottomNavigationBarWidget({super.key, required this.favorites});

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch(index) {
      case 0:
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => FavoritesPage(favorites: widget.favorites)));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())); // Handle profile navigation
        break;
    }
  }

  Widget _buildNavItem(IconData icon, IconData selectedIcon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Color(0xFFFE554A) : Color(0xFFDFDFDF),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _selectedIndex == index ? selectedIcon : icon,
          color: _selectedIndex == index ? Color(0xFFFFFFFF) : Color(0xFF000000),
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 87.62,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, Icons.home, 0),
              _buildNavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, 1),
              const SizedBox(width: 60), // Space for central button
              _buildNavItem(Icons.favorite_outline, Icons.favorite, 2),
              _buildNavItem(Icons.person_outline, Icons.person, 3),
            ],
          ),
        ),
        Positioned(
          top: -30,
          child: GestureDetector(
            onTap: () {}, // Add functionality if needed
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9881F), Color(0xFFFF774C)],
                  begin: Alignment(0.42, 0),
                  end: Alignment(0.54, 1),
                ),
                shape: BoxShape.circle,
                
              ),
              child: const Icon(
                Icons.search,
                color: Color(0xFFFFFFFF),
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SidebarMenu extends StatelessWidget {
  final User? user; // Receive logged-in user
  
  const SidebarMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        decoration: BoxDecoration(
          color: Color(0xFFF8FBFF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, size: 30, color: Color(0xFF000000)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                
                CircleAvatar(
                  radius: 30,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : AssetImage('assets/images/profile.png') as ImageProvider,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? "Guest User",
                      style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    Text(
                      user?.email ?? "guest@example.com",
                      style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontFamily: 'SkModernist',
                      fontWeight: FontWeight.normal,
                    ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            
            _buildMenuItem(Icons.person_outline, "My profile", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            }),
            _buildMenuItem(Icons.payment, "Payment method", () {}),
            _buildMenuItem(Icons.settings_outlined, "Settings", () {}),
            _buildMenuItem(Icons.help_outline, "Help", () {}),
            _buildMenuItem(Icons.privacy_tip_outlined, "Privacy policy", () {}),
            Spacer(),
            SizedBox(
              width: 100,
              height: 50,
              child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [Color(0xFFF9881F), Color(0xFFFF774C)], // 🌈 Gradient Colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut(); // Logout
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SwipeScreen()), // Navigate to screen1.dart
                  ); // Redirect to Login
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontFamily: 'SkModernist',
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            ),
            
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF130F26), size: 20),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontFamily: 'SkModernist',
                      fontWeight: FontWeight.normal,
                    ),
          ),
        ],
      ),
      )
    );
  }
}