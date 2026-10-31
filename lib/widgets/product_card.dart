import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upper colored icon box
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: product.bgColor, // Updated from product.cardBgColor
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    product.icon,
                    size: 42,
                    color: product.iconColor,
                  ),
                ),
              ),
          ),
          const SizedBox(height: 12),
          // Product Title
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 2),
          // Product Price
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
    );
  }
}