import 'package:flutter/material.dart';

class CollectionsShirtsPage extends StatelessWidget {
  const CollectionsShirtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Classic T-Shirt',
        'image': 'https://ml.thcdn.com/images/v2/productimg/original/17028758-9155259874746153.jpg?width=960&height=960',
        'price': '£11.00',
        'oldPrice': null,
      },
      {
        'title': 'Print Tee',
        'image': 'https://i5.walmartimages.com/asr/7ffec616-12c7-42df-ad9c-c63164d980b6_1.2eafd147c4ac5e7364d0004c1ae9c423.jpeg',
        'price': '£12.50',
        'oldPrice': '£15.00',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('T-Shirts'), backgroundColor: const Color(0xFF4d2963)),
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
