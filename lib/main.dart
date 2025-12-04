import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/signup_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection': (context) => const CollectionPage(),
        '/sale': (context) => const SalePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}

class AnnouncementBar extends StatelessWidget {
  const AnnouncementBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: const Text(
        'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
        style: TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: Image.asset(
              'assets/the_union_logo.png',
              height: 38,
            ),
          ),
          const Spacer(),
          ...['Home', 'Shop', 'SALE!', 'About'].map((item) {
            if (item == 'Home') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else if (item == 'Shop') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/collections');
                  },
                  child: const Text(
                    'Shop',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else if (item == 'SALE!') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/sale');
                  },
                  child: const Text(
                    'SALE!',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else if (item == 'About') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  child: const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Icon(Icons.person_outline,
                color: Colors.black54, size: 28),
          ),
          const SizedBox(width: 18),
          const Icon(Icons.shopping_cart_outlined,
              color: Colors.black54, size: 28),
        ],
      ),
    );
  }
}

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 280,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=800&q=80'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 280,
          color: Colors.black.withOpacity(0.3),
        ),
        SizedBox(
          width: double.infinity,
          height: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'The Print Shack',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Let's create something uniquely you with our personalisation service — From £3 for one line of text!",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4d2963),
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                ),
                onPressed: null,
                child: const Text('FIND OUT MORE',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'ESSENTIAL RANGE - OVER 20% OFF!',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                child: ProductCard(
                  title: 'Limited Edition Essential Zip Hoodies',
                  imageUrl:
                      'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
                  oldPrice: '£20.00',
                  price: '£14.99',
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: ProductCard(
                  title: 'Essential T-Shirt',
                  imageUrl:
                      'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
                  oldPrice: '£10.00',
                  price: '£6.99',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: const [
          Text(
            'Footer',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text('Home | Products | Contact',
              style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AnnouncementBar(),
            Navbar(),
            HeroBanner(),
            FeaturedSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Navbar(),
            // Large product image section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://via.placeholder.com/600x400?text=Product+Image'),
                    width: 600,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 24),
                  // Product details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Title',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Text(
                            '£14.99',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '£20.00',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Non-functional Dropdowns
                      DropdownButton<String>(
                        value: 'Size',
                        items: [
                          DropdownMenuItem(value: 'Size', child: Text('Size')),
                          DropdownMenuItem(value: 'S', child: Text('S')),
                          DropdownMenuItem(value: 'M', child: Text('M')),
                          DropdownMenuItem(value: 'L', child: Text('L')),
                        ],
                        onChanged: null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButton<String>(
                        value: 'Colour',
                        items: [
                          DropdownMenuItem(
                              value: 'Colour', child: Text('Colour')),
                          DropdownMenuItem(value: 'Red', child: Text('Red')),
                          DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                          DropdownMenuItem(
                              value: 'Green', child: Text('Green')),
                        ],
                        onChanged: null,
                      ),
                      const SizedBox(height: 24),
                      // Quantity and Add to Cart
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.remove, color: Colors.grey),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child:
                                      Text('1', style: TextStyle(fontSize: 16)),
                                ),
                                Icon(Icons.add, color: Colors.grey),
                              ],
                            ),
                          ),
                          SizedBox(width: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4d2963),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: null,
                            child: Text('Add to Cart',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Product description section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Product Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'This is a placeholder for the product description. Here you can add details about the product, materials, sizing, care instructions, and more.',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
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
  final String price;
  final String imageUrl;
  final String? oldPrice;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          maxLines: 2,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            if (oldPrice != null)
              Text(
                oldPrice!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (oldPrice != null) const SizedBox(width: 8),
            Text(
              price,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
