import 'package:flutter/material.dart';
import 'main.dart';
import 'utils/responsive.dart';
import 'widgets/mobile_drawer.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'T-Shirts',
        'route': '/collections/shirts',
        'image':
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=800&q=80'
      },      {
        'title': 'Hoodies',
        'route': '/collections/hoodies',
        'image':
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=80'
      },{
        'title': 'Accessories',
        'route': '/collections/accessories',
        'image':
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80'
      },
    ];    return Scaffold(
      drawer: ResponsiveHelper.isMobile(context) ? const MobileDrawer() : null,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4d2963),
        title: Row(
          children: [
            SizedBox(
              height: 35,
              child: Image.network(
                'https://memplus-dev.ams3.cdn.digitaloceanspaces.com/media/RRzv6t6W0mp2ty8R9h4pMz6P4XQDBejVMUn8D2Hb.png',
                height: 35,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 35,
                    width: 120,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'The UNION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            const Text('Collections'),
          ],
        ),
      ),      body: Padding(
        padding: EdgeInsets.all(
          ResponsiveHelper.value(
            context: context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 16.0,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final cross = ResponsiveHelper.gridColumns(
            context,
            mobile: 1,
            tablet: 2,
            desktop: 3,
          );
          return GridView.count(
            crossAxisCount: cross,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: ResponsiveHelper.value(
              context: context,
              mobile: 2.5,
              tablet: 3.0,
              desktop: 3.0,
            ),
            children: categories.map((cat) {
              return InkWell(
                onTap: () => Navigator.pushNamed(context, cat['route'] as String),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8)),
                        child: Image.network(
                          cat['image'] as String,
                          width: ResponsiveHelper.value(
                            context: context,
                            mobile: 100.0,
                            desktop: 140.0,
                          ),
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            width: ResponsiveHelper.value(
                              context: context,
                              mobile: 100.0,
                              desktop: 140.0,
                            ),
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          cat['title'] as String,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 16.0,
                              desktop: 18.0,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
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
    // Placeholder products for each category
    final products = {
      'Hoodies': [
        ProductCard(
            title: 'Hoodie 1',
            imageUrl: 'https://via.placeholder.com/400x400?text=Hoodie+1',
            oldPrice: '£25.00',
            price: '£19.99'),
        ProductCard(
            title: 'Hoodie 2',
            imageUrl: 'https://via.placeholder.com/400x400?text=Hoodie+2',
            oldPrice: '£30.00',
            price: '£24.99'),
        ProductCard(
            title: 'Hoodie 3',
            imageUrl: 'https://via.placeholder.com/400x400?text=Hoodie+3',
            oldPrice: '£28.00',
            price: '£21.99'),
        ProductCard(
            title: 'Hoodie 4',
            imageUrl: 'https://via.placeholder.com/400x400?text=Hoodie+4',
            oldPrice: '£32.00',
            price: '£26.99'),
      ],
      'Jumpers': [
        ProductCard(
            title: 'Jumper 1',
            imageUrl: 'https://via.placeholder.com/400x400?text=Jumper+1',
            oldPrice: '£20.00',
            price: '£15.99'),
        ProductCard(
            title: 'Jumper 2',
            imageUrl: 'https://via.placeholder.com/400x400?text=Jumper+2',
            oldPrice: '£22.00',
            price: '£17.99'),
        ProductCard(
            title: 'Jumper 3',
            imageUrl: 'https://via.placeholder.com/400x400?text=Jumper+3',
            oldPrice: '£24.00',
            price: '£19.99'),
        ProductCard(
            title: 'Jumper 4',
            imageUrl: 'https://via.placeholder.com/400x400?text=Jumper+4',
            oldPrice: '£26.00',
            price: '£21.99'),
      ],
      'Accessories': [
        ProductCard(
            title: 'Accessory 1',
            imageUrl: 'https://via.placeholder.com/400x400?text=Accessory+1',
            oldPrice: '£5.00',
            price: '£3.99'),
        ProductCard(
            title: 'Accessory 2',
            imageUrl: 'https://via.placeholder.com/400x400?text=Accessory+2',
            oldPrice: '£6.00',
            price: '£4.99'),
        ProductCard(
            title: 'Accessory 3',
            imageUrl: 'https://via.placeholder.com/400x400?text=Accessory+3',
            oldPrice: '£7.00',
            price: '£5.99'),
        ProductCard(
            title: 'Accessory 4',
            imageUrl: 'https://via.placeholder.com/400x400?text=Accessory+4',
            oldPrice: '£8.00',
            price: '£6.99'),
      ],
    };
    final selectedProducts = products[title] ?? products['Hoodies'];
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
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1,
                    children:
                        (selectedProducts ?? <ProductCard>[]).cast<Widget>(),
                  ),
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

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String oldPrice;
  final String price;

  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.oldPrice,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  oldPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4d2963),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
