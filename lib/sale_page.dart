import 'package:flutter/material.dart';
import 'main.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _sortOption = 'Featured';

  void _updateSort(String newSort) {
    setState(() {
      _sortOption = newSort;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AnnouncementBar(),
            const Navbar(),
            const SaleBanner(),
            SaleSortDropdown(
              currentSort: _sortOption,
              onSortChanged: _updateSort,
            ),
            SaleProductGrid(sortOption: _sortOption),
            const Footer(),
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
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: const [
          Text(
            'SALE',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Don\'t miss out! Get yours before they\'re all gone!',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Text(
            'All prices shown are inclusive of the discount 🧾',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SaleSortDropdown extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SaleSortDropdown({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '4 products',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentSort,
                isDense: true,
                icon: const Icon(Icons.arrow_drop_down, size: 20),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                items: const [
                  DropdownMenuItem(value: 'Featured', child: Text('Featured')),
                  DropdownMenuItem(
                      value: 'Price: Low to High',
                      child: Text('Price: Low to High')),
                  DropdownMenuItem(
                      value: 'Price: High to Low',
                      child: Text('Price: High to Low')),
                  DropdownMenuItem(
                      value: 'Name: A-Z', child: Text('Name: A-Z')),
                  DropdownMenuItem(
                      value: 'Name: Z-A', child: Text('Name: Z-A')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onSortChanged(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SaleProductGrid extends StatelessWidget {
  final String sortOption;

  const SaleProductGrid({super.key, required this.sortOption});

  List<Map<String, String>> _getSortedProducts() {
    final products = [
      {
        'title': 'Union Hoodie',
        'imageUrl':
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£25.00',
        'price': '£17.99',
        'numPrice': '17.99',
      },
      {
        'title': 'Union T-Shirt',
        'imageUrl':
            'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£12.00',
        'price': '£7.99',
        'numPrice': '7.99',
      },
      {
        'title': 'Union Beanie',
        'imageUrl':
            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£10.00',
        'price': '£5.99',
        'numPrice': '5.99',
      },
      {
        'title': 'Union Mug',
        'imageUrl':
            'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?auto=format&fit=crop&w=400&q=80',
        'oldPrice': '£8.00',
        'price': '£4.99',
        'numPrice': '4.99',
      },
    ];

    // Sort based on selected option
    switch (sortOption) {
      case 'Price: Low to High':
        products.sort((a, b) => double.parse(a['numPrice']!)
            .compareTo(double.parse(b['numPrice']!)));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => double.parse(b['numPrice']!)
            .compareTo(double.parse(a['numPrice']!)));
        break;
      case 'Name: A-Z':
        products.sort((a, b) => a['title']!.compareTo(b['title']!));
        break;
      case 'Name: Z-A':
        products.sort((a, b) => b['title']!.compareTo(a['title']!));
        break;
      default:
        // Featured - keep original order
        break;
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final products = _getSortedProducts();
    
    return Padding(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive grid - adjust columns based on screen width
          int crossAxisCount = 2;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 3;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 32,
              childAspectRatio: 0.7,
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
          );
        },
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product details coming soon!')),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container with badge
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: AnimatedScale(
                        scale: _isHovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Image.network(
                          widget.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey, size: 40),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // SALE badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD32F2F),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Product details
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFD32F2F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (widget.oldPrice != null)
                          Text(
                            widget.oldPrice!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    if (widget.oldPrice != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _calculateDiscount(widget.oldPrice!, widget.price),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF388E3C),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateDiscount(String oldPrice, String newPrice) {
    final old = double.parse(oldPrice.replaceAll('£', ''));
    final current = double.parse(newPrice.replaceAll('£', ''));
    final discount = ((old - current) / old * 100).round();
    return 'Save $discount%';
  }
}
