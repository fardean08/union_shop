import 'package:flutter/material.dart';
import 'main.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AnnouncementBar(),
            Navbar(),
            SaleBanner(),
            SaleSortDropdown(),
            SaleProductGrid(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class SaleBanner extends StatelessWidget {
  const SaleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      color: const Color(0xFF4d2963),
      child: const Center(
        child: Text(
          'SALE!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }
}

class SaleSortDropdown extends StatelessWidget {
  const SaleSortDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButton<String>(
            value: 'Sort by',
            items: const [
              DropdownMenuItem(value: 'Sort by', child: Text('Sort by')),
              DropdownMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
              DropdownMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
            ],
            onChanged: (value) {}, // Non-functional
          ),
        ],
      ),
    );
  }
}

class SaleProductGrid extends StatelessWidget {
  const SaleProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Union Hoodie',
        'imageUrl': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£25.00',
        'price': '£17.99',
      },
      {
        'title': 'Union T-Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£12.00',
        'price': '£7.99',
      },
      {
        'title': 'Union Beanie',
        'imageUrl': 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£10.00',
        'price': '£5.99',
      },
      {
        'title': 'Union Mug',
        'imageUrl': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£8.00',
        'price': '£4.99',
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            title: product['title']!,
            imageUrl: product['imageUrl']!,
            oldPrice: product['oldPrice']!,
            price: product['price']!,
          );
        },
      ),
    );
  }
}
