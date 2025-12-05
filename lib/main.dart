import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:union_shop/print_shack_page.dart';
import 'package:union_shop/search_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/utils/responsive.dart';
import 'package:union_shop/widgets/mobile_drawer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider()..loadCart(), // Load cart on app start
      child: const UnionShopApp(),
    ),
  );
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
      // By default, the app starts at the '/' route, which is the HomeScreen      initialRoute: '/',
      routes: {
        '/product': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Product) {
            return ProductPage(product: args);
          }
          return const ProductPage();
        },
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collections/shirts': (context) => const CollectionsShirtsPage(),
        '/collections/hoodies': (context) => const CollectionsHoodiesPage(),
        '/collections/accessories': (context) => const CollectionsAccessoriesPage(),
        '/collection': (context) => const CollectionsPage(),        '/sale': (context) => const SalePage(),        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/cart': (context) => const CartPage(),
        '/print-shack': (context) => const PrintShackPage(),
        '/search': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is String) {
            return SearchPage(initialQuery: args);
          }
          return const SearchPage();
        },
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
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: ResponsiveHelper.value(
          context: context,
          mobile: 8.0,
          tablet: 16.0,
          desktop: 24.0,
        ),
      ),
      child: Text(
        'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveHelper.fontSize(
            context: context,
            mobile: 11.0,
            tablet: 12.0,
            desktop: 13.0,
          ),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  const Navbar({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Back button (if applicable)
          if (Navigator.canPop(context))
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF4d2963)),
              onPressed: () => Navigator.pop(context),
            ),
          
          // Hamburger menu for mobile
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF4d2963)),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            // Logo
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: SizedBox(
              height: ResponsiveHelper.value(
                context: context,
                mobile: 35.0,
                tablet: 40.0,
                desktop: 50.0,
              ),
              child: Image.network(
                'https://memplus-dev.ams3.cdn.digitaloceanspaces.com/media/RRzv6t6W0mp2ty8R9h4pMz6P4XQDBejVMUn8D2Hb.png',
                height: ResponsiveHelper.value(
                  context: context,
                  mobile: 35.0,
                  tablet: 40.0,
                  desktop: 50.0,
                ),
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: ResponsiveHelper.value(
                      context: context,
                      mobile: 35.0,
                      tablet: 40.0,
                      desktop: 50.0,
                    ),
                    width: ResponsiveHelper.value(
                      context: context,
                      mobile: 120.0,
                      tablet: 150.0,
                      desktop: 180.0,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: const Color(0xFF4d2963),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'The ',
                          style: TextStyle(
                            color: const Color(0xFF4d2963),
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 20.0,
                              tablet: 26.0,
                              desktop: 32.0,
                            ),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'cursive',
                          ),
                        ),
                        TextSpan(
                          text: 'UNION',
                          style: TextStyle(
                            color: const Color(0xFF4d2963),
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 20.0,
                              tablet: 26.0,
                              desktop: 32.0,
                            ),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const Spacer(),
          
          // Desktop navigation menu
          if (!isMobile)
            ...['Home', 'Shop', 'Print Shack', 'SALE!', 'About'].map((item) {
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
              } else if (item == 'Print Shack') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/print-shack');
                    },
                    child: const Text(
                      'Print Shack',
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
          
          if (!isMobile) const Spacer(),
            // Search icon (desktop only)
          if (!isMobile)
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
              child: const Icon(Icons.search,
                  color: Colors.black54, size: 28),
            ),
          if (!isMobile) const SizedBox(width: 18),
          
          // Login icon (desktop only)
          if (!isMobile)
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Icon(Icons.person_outline,
                  color: Colors.black54, size: 28),
            ),
          if (!isMobile) const SizedBox(width: 18),
          
          // Cart icon (always visible)
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black54,
                      size: ResponsiveHelper.value(
                        context: context,
                        mobile: 24.0,
                        desktop: 28.0,
                      ),
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          padding: EdgeInsets.all(
                            ResponsiveHelper.value(
                              context: context,
                              mobile: 3.0,
                              desktop: 4.0,
                            ),
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4d2963),
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: ResponsiveHelper.value(
                              context: context,
                              mobile: 16.0,
                              desktop: 18.0,
                            ),
                            minHeight: ResponsiveHelper.value(
                              context: context,
                              mobile: 16.0,
                              desktop: 18.0,
                            ),
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ResponsiveHelper.fontSize(
                                context: context,
                                mobile: 9.0,
                                desktop: 10.0,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HeroBanner extends StatefulWidget {
  const HeroBanner({super.key});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Shop Our Collections',
      'description': 'Explore our full range of hoodies, t-shirts, and accessories',
      'buttonText': 'SHOP NOW',
      'route': '/collections',
      'imageUrl': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'SALE! Up to 20% OFF',
      'description': 'Essential range now on sale - grab yours while stock lasts!',
      'buttonText': 'VIEW SALE',
      'route': '/sale',
      'imageUrl': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&w=800&q=80',
    },    {
      'title': 'The Print Shack',
      'description': "Let's create something uniquely you with our personalisation service — From £3 for one line of text!",
      'buttonText': 'FIND OUT MORE',
      'route': '/print-shack',
      'imageUrl': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Auto-play carousel
    Future.delayed(const Duration(seconds: 5), _autoPlay);
  }

  void _autoPlay() {
    if (mounted) {
      final nextPage = (_currentPage + 1) % _slides.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(seconds: 5), _autoPlay);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bannerHeight = ResponsiveHelper.value(
      context: context,
      mobile: 200.0,
      tablet: 240.0,
      desktop: 280.0,
    );
    
    return SizedBox(
      height: bannerHeight,
      child: Stack(
        children: [
          // PageView for slides
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return Stack(
                children: [
                  // Background image
                  Container(
                    width: double.infinity,
                    height: bannerHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(slide['imageUrl'] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Dark overlay
                  Container(
                    width: double.infinity,
                    height: bannerHeight,
                    color: Colors.black.withOpacity(0.3),
                  ),                  // Content
                  SizedBox(
                    width: double.infinity,
                    height: bannerHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [                        Text(
                          slide['title'] as String,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 24.0,
                              tablet: 30.0,
                              desktop: 38.0,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: ResponsiveHelper.spacing(
                            context,
                            mobile: 8.0,
                            tablet: 10.0,
                            desktop: 12.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.value(
                              context: context,
                              mobile: 16.0,
                              tablet: 20.0,
                              desktop: 24.0,
                            ),
                          ),
                          child: Text(
                            slide['description'] as String,
                            style: TextStyle(
                              fontSize: ResponsiveHelper.fontSize(
                                context: context,
                                mobile: 14.0,
                                tablet: 16.0,
                                desktop: 18.0,
                              ),
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: ResponsiveHelper.spacing(
                            context,
                            mobile: 12.0,
                            tablet: 15.0,
                            desktop: 18.0,
                          ),
                        ),                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelper.value(
                                context: context,
                                mobile: 20.0,
                                tablet: 24.0,
                                desktop: 28.0,
                              ),
                              vertical: ResponsiveHelper.value(
                                context: context,
                                mobile: 12.0,
                                desktop: 12.0,
                              ),
                            ),
                            minimumSize: const Size(44, 44), // Touch-friendly minimum
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, slide['route'] as String);
                          },
                          child: Text(
                            slide['buttonText'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },          ),
          // Navigation arrows (hide on mobile)
          if (!ResponsiveHelper.isMobile(context))
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 32),
                  onPressed: () {
                    final prevPage = (_currentPage - 1 + _slides.length) % _slides.length;
                    _pageController.animateToPage(
                      prevPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          if (!ResponsiveHelper.isMobile(context))
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 32),
                  onPressed: () {
                    final nextPage = (_currentPage + 1) % _slides.length;
                    _pageController.animateToPage(
                      nextPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          // Dot indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});
  
  Widget _buildProductGrid(BuildContext context, List<Map<String, dynamic>> products, String category) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    if (isMobile) {
      // Mobile: Stack vertically
      return Column(
        children: products.map((product) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _buildProductCard(context, product, category),
          );
        }).toList(),
      );
    } else {
      // Desktop/Tablet: Row layout
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: products.map((product) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildProductCard(context, product, category),
            ),
          );
        }).toList(),
      );
    }
  }
  
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product, String category) {
    return InkWell(
      onTap: () {
        // Create a Product object for navigation
        final productObj = Product(
          id: product['title'] as String,
          title: product['title'] as String,
          imageUrl: product['imageUrl'] as String,
          price: double.parse((product['price'] as String).replaceAll('£', '')),
          oldPrice: product['oldPrice'] != null 
              ? double.parse((product['oldPrice'] as String).replaceAll('£', ''))
              : null,
          category: category,
          sizes: ['S', 'M', 'L', 'XL'],
          colors: category == 'featured' 
              ? ['Baby Pink', 'Black', 'White', 'Navy']
              : ['Sage Green', 'Navy', 'Black', 'White'],
          isOnSale: product['oldPrice'] != null,
        );
        Navigator.pushNamed(context, '/product', arguments: productObj);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
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
          const SizedBox(height: 16),
          Text(
            product['title'] as String,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
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
                  fontSize: 13,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final essentialProducts = [
      {
        'title': 'Limited Edition Essential Zip Hoodies',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/Essentials_Pink_FrontandBack_480x480.jpg?v=1698065356',
        'oldPrice': '£20.00',
        'price': '£14.99',
      },
      {
        'title': 'Essential T-Shirt',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/Essentials_Green_Front_480x480.jpg?v=1698065452',
        'oldPrice': '£10.00',
        'price': '£6.99',
      },
    ];
    final signatureProducts = [
      {
        'title': 'Signature Hoodie',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/Signature_Green_Front_480x480.jpg?v=1698065647',
        'price': '£32.99',
      },
      {
        'title': 'Signature T-Shirt',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/Signature_Navy_Front_480x480.jpg?v=1698065728',
        'price': '£14.99',
      },
    ];      return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Text(
            'ESSENTIAL RANGE - OVER 20% OFF!',
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(
                context: context,
                mobile: 14.0,
                tablet: 15.0,
                desktop: 16.0,
              ),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.horizontalPadding(context),
          ),
          child: _buildProductGrid(context, essentialProducts, 'featured'),
        ),
        const SizedBox(height: 80),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Text(
            'SIGNATURE RANGE',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.horizontalPadding(context),
          ),
          child: _buildProductGrid(context, signatureProducts, 'signature'),
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
      child: Column(
        children: [
          // Search Section
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF4d2963), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search for products...',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        Navigator.pushNamed(
                          context,
                          '/search',
                          arguments: value.trim(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: const Text(
                    'SEARCH',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Footer Links
          Row(
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
                              fontSize: 18, fontWeight: FontWeight.bold)),                    ),
                  ],
                ),
              ],
            ),
          ),
            ],
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
      drawer: ResponsiveHelper.isMobile(context) ? const MobileDrawer() : null,
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
