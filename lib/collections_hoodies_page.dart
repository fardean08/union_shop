import 'package:flutter/material.dart';

class CollectionsHoodiesPage extends StatelessWidget {
  const CollectionsHoodiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Classic Hoodie',
        'image': 'https://cdn.media.amplience.net/i/gapprod/FA259608_Hoodies_DESK?fmt=webp',
        'price': '£23.00',
        'oldPrice': '£30.00',
      },
      {
        'title': 'Signature Hoodie',
        'image': 'https://media.wired.com/photos/67c2199410f97865da3e53a8/4:3/w_640%2Cc_limit/Mad-Happy-Classics-Fleece-Hoodie-(blue)-Offwhite-Background-SOURCE-Mad-Happy.jpg',
        'price': '£25.00',
        'oldPrice': null,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hoodies'), backgroundColor: const Color(0xFF4d2963)),
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
                            Row(
                              children: [
                                if (p['oldPrice'] != null)
                                  Text(p['oldPrice'] as String,
                                      style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                                if (p['oldPrice'] != null) const SizedBox(width: 6),
                                Text(p['price'] as String, style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                              ],
                            ),
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
