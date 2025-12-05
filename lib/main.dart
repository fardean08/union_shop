import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/collections_shirts_page.dart';
import 'package:union_shop/collections_hoodies_page.dart';
import 'package:union_shop/collections_accessories_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/signup_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/cart_provider.dart';

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
      initialRoute: '/',      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProductPage(
            title: args?['title'] ?? '',
            imageUrl: args?['imageUrl'] ?? '',
            price: args?['price'] ?? '',
            oldPrice: args?['oldPrice'] as String?,
          );
        },
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collections/shirts': (context) => const CollectionsShirtsPage(),
        '/collections/hoodies': (context) => const CollectionsHoodiesPage(),
        '/collections/accessories': (context) => const CollectionsAccessoriesPage(),
        '/collection': (context) => const CollectionsPage(),
        '/sale': (context) => const SalePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/cart': (context) => const CartPage(),
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
          if (Navigator.canPop(context))
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF4d2963)),
              onPressed: () => Navigator.pop(context),
            ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text(
              'The UNION',
              style: TextStyle(
                color: Color(0xFF4d2963),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
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
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
            child: const Icon(Icons.shopping_cart_outlined,
                color: Colors.black54, size: 28),
          ),
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
    final essentialProducts = [
      {
        'title': 'Limited Edition Essential Zip Hoodies',
        'imageUrl':
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=80',
        'oldPrice': '£20.00',
        'price': '£14.99',
      },
      {
        'title': 'Essential T-Shirt',
        'imageUrl':
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=80',
        'oldPrice': '£10.00',
        'price': '£6.99',
      },
    ];
    final signatureProducts = [
      {
        'title': 'Signature Hoodie',
        'imageUrl':
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=80',
        'price': '£32.99',
      },
      {
        'title': 'Signature T-Shirt',
        'imageUrl':
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=80',
        'price': '£14.99',
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Text(
            'ESSENTIAL RANGE - OVER 20% OFF!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: essentialProducts.map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            title: product['title'] as String,
                            imageUrl: product['imageUrl'] as String,
                            price: product['price'] as String,
                            oldPrice: product['oldPrice'] as String?,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 0.75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              product['imageUrl'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey, size: 48),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            if (product['oldPrice'] != null) ...[
                              Text(
                                product['oldPrice'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              product['price'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 48),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Text(
            'SIGNATURE RANGE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: signatureProducts.map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            title: product['title'] as String,
                            imageUrl: product['imageUrl'] as String,
                            price: product['price'] as String,
                            oldPrice: null,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 0.75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              product['imageUrl'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey, size: 48),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product['price'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opening Hours
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Opening Hours',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '❄️ Winter Break Closure Dates ❄️\n\n'
                  'Closing 4pm 19/12/2025\n'
                  'Reopening 10am 05/01/2026\n'
                  'Last post date: 12pm on 18/12/2025\n\n'
                  '----------------------\n'
                  '(Term Time)\n'
                  'Monday - Friday 10am - 4pm\n\n'
                  '(Outside of Term Time / Consolidation Weeks)\n'
                  'Monday - Friday 10am - 3pm\n\n'
                  'Purchase online 24/7',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          // Help and Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Help and Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  child: const Text(
                    'About Us',
                    style: TextStyle(
                      color: Color(0xFF4d2963),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text('Terms & Conditions of Sale'),
                const Text('Policy'),
              ],
            ),
          ),
          // Latest Offers
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Latest Offers',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('SUBSCRIBE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

class ProductPage extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String? oldPrice;

  const ProductPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedSize = 'M';
  String selectedColour = 'Black';
  int quantity = 1;
  final cartProvider = CartProvider();

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
                  Image.network(
                    widget.imageUrl,
                    width: 600,
                    height: 400,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
                  // Product details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            widget.price,
                            style: const TextStyle(
                                fontSize: 22,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 16),
                          if (widget.oldPrice != null)
                            Text(
                              widget.oldPrice!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Size selector
                      DropdownButton<String>(
                        value: selectedSize,
                        items: const [
                          DropdownMenuItem(value: 'S', child: Text('Small')),
                          DropdownMenuItem(value: 'M', child: Text('Medium')),
                          DropdownMenuItem(value: 'L', child: Text('Large')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value ?? 'M';
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      // Colour selector
                      DropdownButton<String>(
                        value: selectedColour,
                        items: const [
                          DropdownMenuItem(
                              value: 'Black', child: Text('Black')),
                          DropdownMenuItem(
                              value: 'White', child: Text('White')),
                          DropdownMenuItem(value: 'Grey', child: Text('Grey')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedColour = value ?? 'Black';
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      // Quantity selector
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text('$quantity',
                              style: const TextStyle(fontSize: 18)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          cartProvider.addItem(CartItem(
                            title: widget.title,
                            imageUrl: widget.imageUrl,
                            price: widget.price,
                            oldPrice: widget.oldPrice,
                            size: selectedSize,
                            colour: selectedColour,
                            quantity: quantity,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('Add to Cart',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              title: title,
              imageUrl: imageUrl,
              price: price,
              oldPrice: oldPrice,
            ),
          ),
        );
      },
      child: Column(
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
      ),
    );
  }
}
