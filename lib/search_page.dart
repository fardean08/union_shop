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
            ),
            SearchResults(
              results: _searchResults,
              isSearching: _isSearching,
              query: _searchController.text,
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
