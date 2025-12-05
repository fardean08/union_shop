class Product {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final bool isOnSale;
  final String? description;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.isOnSale,
    this.description,
  });

  String get priceString => '£${price.toStringAsFixed(2)}';
  String? get oldPriceString =>
      oldPrice != null ? '£${oldPrice!.toStringAsFixed(2)}' : null;
  
  String get productDescription {
    if (description != null && description!.isNotEmpty) {
      return description!;
    }
    // Generate description based on product name and category
    return _generateDescription();
  }

  String _generateDescription() {
    if (title.toLowerCase().contains('hoodie')) {
      return 'Premium quality hoodie featuring a comfortable fit and stylish design. Perfect for casual wear and staying warm. Made with soft, durable fabric for long-lasting comfort.';
    } else if (title.toLowerCase().contains('t-shirt') || title.toLowerCase().contains('tee')) {
      return 'Classic t-shirt made from high-quality, breathable fabric. Features a comfortable regular fit that\'s perfect for everyday wear. Durable construction ensures this tee will be a wardrobe staple for years to come.';
    } else if (title.toLowerCase().contains('essential')) {
      return 'Part of our Essential range - quality basics designed for everyday comfort and style. Crafted with attention to detail and built to last. A versatile addition to any wardrobe.';
    } else if (title.toLowerCase().contains('signature')) {
      return 'From our premium Signature collection, this piece combines style and comfort. Designed with superior materials and attention to detail. Make a statement with this standout piece.';
    } else if (category.toLowerCase().contains('accessories')) {
      return 'High-quality accessory designed to complement your style. Durable construction and thoughtful design make this a must-have addition to your collection.';
    } else {
      return 'Quality apparel from The UNION Shop. Designed for comfort, style, and durability. Perfect for students and anyone looking for great everyday wear.';
    }
  }
}
