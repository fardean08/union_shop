import 'package:flutter/material.dart';

class CollectionsAccessoriesPage extends StatelessWidget {
  const CollectionsAccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Classic Beanie Hat',
        'image': 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=600&q=80',
        'price': '£12.00',
        'oldPrice': null,
      },
      {
        'title': 'Keep Cup',
        'image': 'https://images.unsplash.com/photo-1511988617509-a57c8a288659?auto=format&fit=crop&w=600&q=80',
        'price': '£6.50',
        'oldPrice': null,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Accessories'), backgroundColor: const Color(0xFF4d2963)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          int crossAxis = 2;
          if (width > 1000) crossAxis = 4;
          else if (width > 700) crossAxis = 3;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) {
              final p = products[i];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/product', arguments: {
                    'title': p['title'],
                    'imageUrl': p['image'],
                    'price': p['price'],
                    'oldPrice': p['oldPrice'],
                  });
                },
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          p['image'] as String,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(p['price'] as String, style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
