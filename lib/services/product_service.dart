import '../models/product.dart';

class ProductService {
  static final List<Product> _allProducts = [
    // T-Shirts
    Product(
      id: '1',
      title: 'Classic T-Shirt',
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80',
      price: 11.00,
      oldPrice: null,
      category: 'shirts',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'White', 'Grey'],
      isOnSale: false,
    ),
    Product(
      id: '2',
      title: 'Print Tee',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      price: 12.50,
      oldPrice: 15.00,
      category: 'shirts',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Red'],
      isOnSale: true,
    ),
    Product(
      id: '3',
      title: 'Essential Tee',
      imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=600&q=80',
      price: 9.99,
      oldPrice: null,
      category: 'shirts',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['White', 'Black', 'Grey', 'Navy'],
      isOnSale: false,
    ),
    // Hoodies
    Product(
      id: '4',
      title: 'Classic Hoodie',
      imageUrl: 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=600&q=80',
      price: 23.00,
      oldPrice: 30.00,
      category: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Grey', 'Navy'],
      isOnSale: true,
    ),
    Product(
      id: '5',
      title: 'Signature Hoodie',
      imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=600&q=80',
      price: 25.00,
      oldPrice: null,
      category: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Black', 'White', 'Grey'],
      isOnSale: false,
    ),
    Product(
      id: '6',
      title: 'Zip Hoodie',
      imageUrl: 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=600&q=80',
      price: 28.00,
      oldPrice: null,
      category: 'hoodies',
      sizes: ['M', 'L', 'XL'],
      colors: ['Black', 'Navy'],
      isOnSale: false,
    ),
    // Accessories
    Product(
      id: '7',
      title: 'Classic Beanie Hat',
      imageUrl: 'https://images.unsplash.com/photo-1576871337622-98d48d1cf531?auto=format&fit=crop&w=600&q=80',
      price: 12.00,
      oldPrice: null,
      category: 'accessories',
      sizes: ['One Size'],
      colors: ['Black', 'Grey', 'Navy'],
      isOnSale: false,
    ),
    Product(
      id: '8',
      title: 'Keep Cup',
      imageUrl: 'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?auto=format&fit=crop&w=600&q=80',
      price: 6.50,
      oldPrice: null,
      category: 'accessories',
      sizes: ['One Size'],
      colors: ['Purple', 'Black', 'White'],
      isOnSale: false,
    ),
    Product(
      id: '9',
      title: 'Tote Bag',
      imageUrl: 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=600&q=80',
      price: 8.00,
      oldPrice: 10.00,
      category: 'accessories',
      sizes: ['One Size'],
      colors: ['Natural', 'Black'],
      isOnSale: true,
    ),
  ];

  static List<Product> getProductsByCategory(String category) {
    return _allProducts.where((p) => p.category == category).toList();
  }

  static List<Product> filterProducts(
    List<Product> products, {
    String? sortBy,
    double? maxPrice,
    bool? onSaleOnly,
  }) {
    var filtered = List<Product>.from(products);

    // Filter by sale
    if (onSaleOnly == true) {
      filtered = filtered.where((p) => p.isOnSale).toList();
    }

    // Filter by price
    if (maxPrice != null) {
      filtered = filtered.where((p) => p.price <= maxPrice).toList();
    }

    // Sort
    if (sortBy == 'price_low') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'price_high') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy == 'name') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    }

    return filtered;
  }

  static List<Product> paginateProducts(
    List<Product> products,
    int page,
    int itemsPerPage,
  ) {
    final startIndex = page * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, products.length);
    
    if (startIndex >= products.length) return [];
    
    return products.sublist(startIndex, endIndex);
  }
}
