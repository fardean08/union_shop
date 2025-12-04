import 'package:flutter/material.dart';
import 'main.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AnnouncementBar(),
            Navbar(),
            CollectionsGrid(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class CollectionsGrid extends StatelessWidget {
  const CollectionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = [
      {
        'title': 'Hoodies',
        'image':
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
      },
      {
        'title': 'Jumpers',
        'image':
            'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      },
      {
        'title': 'Accessories',
        'image':
            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
      },
    ];
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shop by Collection',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963)),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.85,
            children: collections.map((collection) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/collection',
                    arguments: collection['title'],
                  );
                },
                child: CollectionCard(
                  title: collection['title']!,
                  imageUrl: collection['image']!,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CollectionCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CollectionCard(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(context, '/collection', arguments: title);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child:
                            Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4d2963)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? title = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AnnouncementBar(),
            const Navbar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    title ?? 'Collection',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  const Text('This is a placeholder for the collection page.'),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
