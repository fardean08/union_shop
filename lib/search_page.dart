import 'package:flutter/material.dart';
import 'main.dart';

class SearchPage extends StatefulWidget {
  final String? initialQuery;

  const SearchPage({super.key, this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];
  bool _isSearching = false;
  final List<String> _popularSearches = [
    'Hoodies',
    'T-Shirts',
    'Accessories',
    'Union',
    'Purple',
    'Black',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _performSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchResults = _getSearchResults(query);
          _isSearching = false;
        });
      }
    });
  }
  List<Map<String, String>> _getSearchResults(String query) {
    if (query.isEmpty) return [];

    // Sample product database
    final allProducts = [
      {
        'title': 'Union Hoodie - Purple',
        'imageUrl':
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
        'price': '£25.00',
        'category': 'Hoodies',
      },
      {
        'title': 'Union T-Shirt - White',
        'imageUrl':
            'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'price': '£12.00',
        'category': 'T-Shirts',
      },
      {
        'title': 'Union Beanie - Black',
        'imageUrl':
            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
        'price': '£10.00',
        'category': 'Accessories',
      },
      {
        'title': 'Union Mug - Ceramic',
        'imageUrl':
            'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?auto=format&fit=crop&w=400&q=80',
        'price': '£8.00',
        'category': 'Accessories',
      },
      {
        'title': 'Essential Hoodie - Navy',
        'imageUrl':
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=400&q=80',
        'price': '£30.00',
        'category': 'Hoodies',
      },
      {
        'title': 'Signature T-Shirt - Black',
        'imageUrl':
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=80',
        'price': '£15.00',
        'category': 'T-Shirts',
      },
      {
        'title': 'Union Cap - Embroidered',
        'imageUrl':
            'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?auto=format&fit=crop&w=400&q=80',
        'price': '£12.00',
        'category': 'Accessories',
      },
      {
        'title': 'Premium Hoodie - Grey',
        'imageUrl':
            'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=400&q=80',
        'price': '£35.00',
        'category': 'Hoodies',
      },
    ];

    final queryLower = query.toLowerCase();

    // Filter products based on query
    return allProducts.where((product) {
      final titleLower = product['title']!.toLowerCase();
      final categoryLower = product['category']!.toLowerCase();

      return titleLower.contains(queryLower) ||
          categoryLower.contains(queryLower);
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AnnouncementBar(),
            const Navbar(),
            SearchHeader(
              controller: _searchController,
              onSearch: _performSearch,
            ),            SearchBar(
              controller: _searchController,
              onSearch: _performSearch,
              isSearching: _isSearching,
            ),            SearchResults(
              results: _searchResults,
              isSearching: _isSearching,
              query: _searchController.text,
            ),
            if (_searchController.text.isEmpty)
              PopularSearches(
                searches: _popularSearches,
                onSearchTap: (query) {
                  _searchController.text = query;
                  _performSearch(query);
                },
              ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchHeader({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Search Products',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Find what you\'re looking for',
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

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final bool isSearching;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    onSearch(value.trim());
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            controller.clear();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: isSearching
                ? null
                : () {
                    if (controller.text.trim().isNotEmpty) {
                      onSearch(controller.text.trim());
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isSearching
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  final List<Map<String, String>> results;
  final bool isSearching;
  final String query;

  const SearchResults({
    super.key,
    required this.results,
    required this.isSearching,
    required this.query,
  });
  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return const Padding(
        padding: EdgeInsets.all(48.0),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4d2963),
          ),
        ),
      );
    }

    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                'No results found for "$query"',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Try different keywords or check your spelling',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/collections');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Browse All Products',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${results.length} result${results.length != 1 ? 's' : ''} for "$query"',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;
              if (constraints.maxWidth > 1200) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth > 800) {
                crossAxisCount = 3;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 32,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = results[index];
                  return SearchProductCard(
                    title: product['title']!,
                    imageUrl: product['imageUrl']!,
                    price: product['price']!,
                    category: product['category']!,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchProductCard extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String category;

  const SearchProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  @override
  State<SearchProductCard> createState() => _SearchProductCardState();
}

class _SearchProductCardState extends State<SearchProductCard> {
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
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4d2963),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4d2963),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
