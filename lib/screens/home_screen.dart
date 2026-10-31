import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Product> get products => [
        Product(
          id: '1',
          title: 'Phone X',
          price: 549.0,
          icon: Icons.smartphone,
          iconColor: const Color(0xFF1976D2),
          bgColor: const Color(0xFFE8EAF6),
        ),
        Product(
          id: '2',
          title: 'Headphones',
          price: 89.0,
          icon: Icons.headset,
          iconColor: const Color(0xFF00897B),
          bgColor: const Color(0xFFE0F2F1),
        ),
        Product(
          id: '3',
          title: 'T-shirt',
          price: 15.0,
          icon: Icons.checkroom,
          iconColor: const Color(0xFFD84315),
          bgColor: const Color(0xFFFBE9E7),
        ),
        Product(
          id: '4',
          title: 'Laptop',
          price: 899.0,
          icon: Icons.laptop,
          iconColor: const Color(0xFF7B1FA2),
          bgColor: const Color(0xFFF3E5F5),
        ),
        Product(
          id: '5',
          title: 'Camera',
          price: 320.0,
          icon: Icons.camera_alt,
          iconColor: const Color(0xFF558B2F),
          bgColor: const Color(0xFFF1F8E9),
        ),
        Product(
          id: '6',
          title: 'Backpack',
          price: 42.0,
          icon: Icons.backpack,
          iconColor: const Color(0xFFC2185B),
          bgColor: const Color(0xFFFCE4EC),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Mini Market',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Reactive Cart Icon with Badge Counter
          ValueListenableBuilder<List<Product>>(
            valueListenable: CartState.cartNotifier,
            builder: (context, cartItems, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 22,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                // Add item on card tap
                CartState.addToCart(product);

                // Show confirmation snackbar
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} added to cart!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: product.bgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          product.icon,
                          size: 40,
                          color: product.iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFDCDFFE),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.add,
          color: Color(0xFF3F51B5),
          size: 28,
        ),
      ),
    );
  }
}