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
  });

  String get priceString => '£${price.toStringAsFixed(2)}';
  String? get oldPriceString =>
      oldPrice != null ? '£${oldPrice!.toStringAsFixed(2)}' : null;
}
