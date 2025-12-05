import 'package:flutter/material.dart';
import 'main.dart';
import 'collection.dart';

// Sample collections with dummy products
final List<Collection> sampleCollections = [
  Collection(
    name: 'Hoodies',
    imageUrl: 'https://via.placeholder.com/400x400?text=Hoodies',
    products: [
      {
        'title': 'Classic Hoodie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Classic+Hoodie',
        'oldPrice': '£30.00',
        'price': '£24.99',
      },
      {
        'title': 'Zip Hoodie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Zip+Hoodie',
        'oldPrice': '£28.00',
        'price': '£21.99',
      },
      {
        'title': 'Pullover Hoodie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Pullover+Hoodie',
        'oldPrice': '£32.00',
        'price': '£26.99',
      },
    ],
  ),
  Collection(
    name: 'Jumpers',
    imageUrl: 'https://via.placeholder.com/400x400?text=Jumpers',
    products: [
      {
        'title': 'Crew Jumper',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Crew+Jumper',
        'oldPrice': '£20.00',
        'price': '£15.99',
      },
      {
        'title': 'V-Neck Jumper',
        'imageUrl': 'https://via.placeholder.com/400x400?text=V-Neck+Jumper',
        'oldPrice': '£22.00',
        'price': '£17.99',
      },
      {
        'title': 'Oversized Jumper',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Oversized+Jumper',
        'oldPrice': '£24.00',
        'price': '£19.99',
      },
    ],
  ),
  Collection(
    name: 'Accessories',
    imageUrl: 'https://via.placeholder.com/400x400?text=Accessories',
    products: [
      {
        'title': 'Union Mug',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Union+Mug',
        'oldPrice': '£8.00',
        'price': '£4.99',
      },
      {
        'title': 'Union Beanie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Union+Beanie',
        'oldPrice': '£10.00',
        'price': '£5.99',
      },
      {
        'title': 'Union Tote Bag',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Union+Tote+Bag',
        'oldPrice': '£12.00',
        'price': '£7.99',
      },
    ],
  ),
];

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AnnouncementBar(),
            Navbar(),
            CollectionHeader(),
            ProductGrid(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Hoodies Collection',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963)),
          ),
          DropdownButton<String>(
            value: 'Sort by',
            items: const [
              DropdownMenuItem(value: 'Sort by', child: Text('Sort by')),
              DropdownMenuItem(
                  value: 'Price: Low to High',
                  child: Text('Price: Low to High')),
              DropdownMenuItem(
                  value: 'Price: High to Low',
                  child: Text('Price: High to Low')),
            ],
            onChanged: (value) {}, // Non-functional
          ),
        ],
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final signatureProducts = [
      {
        'title': 'Signature Hoodie',
        'imageUrl':
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
        'oldPrice': null,
        'price': '£32.99',
      },
      {
        'title': 'Signature T-Shirt',
        'imageUrl':
            'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'oldPrice': null,
        'price': '£14.99',
      },
    ];
    final essentialProducts = [
      {
        'title': 'Essential Zip Hoodie',
        'imageUrl':
            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£20.00',
        'price': '£14.99',
      },
      {
        'title': 'Essential T-Shirt',
        'imageUrl':
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£10.00',
        'price': '£6.99',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text('ESSENTIAL RANGE - OVER 20% OFF!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: essentialProducts
                .map((product) => Expanded(
                      child: ProductCard(
                        title: product['title'] ?? '',
                        imageUrl: product['imageUrl'] ?? '',
                        oldPrice: product['oldPrice'],
                        price: product['price'] ?? '',
                      ),
                    ))
                .toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text('SIGNATURE RANGE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: signatureProducts
                .map((product) => Expanded(
                      child: ProductCard(
                        title: product['title'] ?? '',
                        imageUrl: product['imageUrl'] ?? '',
                        oldPrice: null,
                        price: product['price'] ?? '',
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
