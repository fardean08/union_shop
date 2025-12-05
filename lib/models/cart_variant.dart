/// Represents a product variant (combination of attributes like size, color)
class CartVariant {
  final String size;
  final String colour;
  final Map<String, String>? additionalAttributes;

  CartVariant({
    required this.size,
    required this.colour,
    this.additionalAttributes,
  });

  /// Get a unique key for this variant combination
  String get variantKey {
    final parts = [size, colour];
    if (additionalAttributes != null) {
      final sorted = additionalAttributes!.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      parts.addAll(sorted.map((e) => '${e.key}:${e.value}'));
    }
    return parts.join('|');
  }

  /// Check if two variants are the same
  bool matches(CartVariant other) {
    return variantKey == other.variantKey;
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'colour': colour,
      'additionalAttributes': additionalAttributes,
    };
  }

  /// Create from JSON
  factory CartVariant.fromJson(Map<String, dynamic> json) {
    return CartVariant(
      size: json['size'] as String,
      colour: json['colour'] as String,
      additionalAttributes: json['additionalAttributes'] != null
          ? Map<String, String>.from(json['additionalAttributes'] as Map)
          : null,
    );
  }

  /// Create a copy with modified fields
  CartVariant copyWith({
    String? size,
    String? colour,
    Map<String, String>? additionalAttributes,
  }) {
    return CartVariant(
      size: size ?? this.size,
      colour: colour ?? this.colour,
      additionalAttributes: additionalAttributes ?? this.additionalAttributes,
    );
  }

  @override
  String toString() {
    final parts = ['Size: $size', 'Colour: $colour'];
    if (additionalAttributes != null && additionalAttributes!.isNotEmpty) {
      additionalAttributes!.forEach((key, value) {
        parts.add('$key: $value');
      });
    }
    return parts.join(', ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartVariant && other.variantKey == variantKey;
  }

  @override
  int get hashCode => variantKey.hashCode;
}
