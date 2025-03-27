import 'package:flutter/material.dart';
import 'package:figma_foodapp/product_model.dart';

class FavoritesPage extends StatelessWidget {
  final List<ProductModel> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8FBFF),
        title: const Text('Favorites',
        style: TextStyle(
          color: Color(0xFF3D3D3D),
            fontSize: 24,
             fontFamily: 'DMSans', // Use your required font
             fontWeight: FontWeight.bold),),
      ),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites yet",
          style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 20,
                          fontFamily: 'DMSans', // Use your required font
                          fontWeight: FontWeight.bold, // Adjust weight if needed
                        ),
                      )
                    )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.asset(product.image, width: 50, height: 50),
                  title: Text(
                    product.title,
                    style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 14,
                              fontFamily: 'DMSans', // Use your required font
                              fontWeight: FontWeight.bold, // Adjust weight if needed
                            )
                            ),
                  subtitle: Text(
                    product.description,
                    style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF3D3D3D)
                    )
                  ),
                );
              },
            ),
    );
  }
}