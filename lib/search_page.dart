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
    // This will be implemented in the next step
    return [];
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
            ),
            SearchBar(
              controller: _searchController,
              onSearch: _performSearch,
              isSearching: _isSearching,
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
