import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/product_service.dart';

class CollectionsShirtsPage extends StatefulWidget {
  const CollectionsShirtsPage({super.key});

  @override
  State<CollectionsShirtsPage> createState() => _CollectionsShirtsPageState();
}

class _CollectionsShirtsPageState extends State<CollectionsShirtsPage> {
  String sortBy = 'default';
  bool showOnSaleOnly = false;
  int currentPage = 0;
  final int itemsPerPage = 6;

  @override
  Widget build(BuildContext context) {
    var products = ProductService.getProductsByCategory('shirts');
    products = ProductService.filterProducts(
      products,
      sortBy: sortBy == 'default' ? null : sortBy,
      onSaleOnly: showOnSaleOnly,
    );

    final totalPages = (products.length / itemsPerPage).ceil();
    final paginatedProducts = ProductService.paginateProducts(
      products,
      currentPage,
      itemsPerPage,
    );    return Scaffold(
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
            const Text('T-Shirts'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filters and Sort
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: sortBy,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'default', child: Text('Default')),
                      DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                      DropdownMenuItem(value: 'name', child: Text('Name A-Z')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        sortBy = value ?? 'default';
                        currentPage = 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                FilterChip(
                  label: const Text('On Sale'),
                  selected: showOnSaleOnly,
                  onSelected: (selected) {
                    setState(() {
                      showOnSaleOnly = selected;
                      currentPage = 0;
                    });
                  },
                ),
              ],
            ),
          ),
          // Products Grid
          Expanded(
            child: Padding(
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
                  itemCount: paginatedProducts.length,
                  itemBuilder: (context, i) {
                    final p = paginatedProducts[i];
                    return _buildProductCard(p);
                  },
                );
              }),
            ),
          ),
          // Pagination
          if (totalPages > 1)
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: currentPage > 0
                        ? () => setState(() => currentPage--)
                        : null,
                  ),
                  Text('Page ${currentPage + 1} of $totalPages'),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: currentPage < totalPages - 1
                        ? () => setState(() => currentPage++)
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  Widget _buildProductCard(Product p) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: p);
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    p.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
                  ),
                  if (p.isOnSale)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (p.oldPriceString != null)
                        Text(
                          p.oldPriceString!,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      if (p.oldPriceString != null) const SizedBox(width: 6),
                      Text(
                        p.priceString,
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
