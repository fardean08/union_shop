# Cart System Quick Reference

## Adding Items to Cart

### From Product Page
```dart
import 'models/cart_variant.dart';
import 'cart_provider.dart';

final cart = Provider.of<CartProvider>(context, listen: false);

cart.addItem(
  productId: product.id,           // Required: Unique product ID
  name: product.title,              // Required: Product name
  image: product.imageUrl,          // Required: Image URL
  price: product.priceString,       // Required: Price string (e.g., "£12.99")
  oldPrice: product.oldPriceString, // Optional: Original price for discounts
  quantity: 1,                      // Optional: Default is 1
  variant: CartVariant(             // Optional: Size, color, etc.
    size: 'M',
    colour: 'Black',
  ),
  notes: 'Gift wrap please',        // Optional: Custom notes
  maxQuantity: 10,                  // Optional: Max allowed quantity
  metadata: {'category': 'hoodies'}, // Optional: Extra data
);
```

## Accessing Cart Data

### Get Cart Items
```dart
final cart = Provider.of<CartProvider>(context);

// All items
List<CartItem> items = cart.items;

// Item count
int count = cart.itemCount;

// Total price
double total = cart.totalPrice; // or cart.totalAmount

// Check if loading
bool loading = cart.isLoading;
```

## Updating Cart

### Update Quantity
```dart
cart.updateQuantity(index, newQuantity);
```

### Update Variant (Size/Color)
```dart
cart.updateItemVariant(index, newSize, newColor);
// Example:
cart.updateItemVariant(0, 'L', 'Navy');
```

### Remove Item
```dart
// By index
cart.removeItem(index);

// By ID
cart.removeItemById(itemId);
```

### Clear Cart
```dart
cart.clearCart();
```

## Cart Item Properties

### Available Properties
```dart
CartItem item = cart.items[0];

// Basic Info
String id = item.id;                    // UUID
String productId = item.productId;      // Product reference
String name = item.name;                // Product name
String title = item.title;              // Alias for name
String image = item.image;              // Image URL
String imageUrl = item.imageUrl;        // Alias for image
String price = item.price;              // Price string
String? oldPrice = item.oldPrice;       // Original price
int quantity = item.quantity;           // Quantity

// Variant Info
CartVariant? variant = item.variant;
String? size = item.variant?.size;
String? colour = item.variant?.colour;

// Calculated Values
double numericPrice = item.numericPrice;        // Price as number
double totalPrice = item.totalPrice;            // Quantity × price
bool hasDiscount = item.hasDiscount;            // Has oldPrice?
double discountAmount = item.discountAmount;    // Discount value
double discountPercentage = item.discountPercentage; // Discount %
bool atMax = item.isAtMaxQuantity;              // At limit?

// Metadata
DateTime addedAt = item.addedAt;               // When added
String? notes = item.notes;                     // Custom notes
int? maxQuantity = item.maxQuantity;           // Max allowed
Map<String, dynamic>? metadata = item.metadata; // Extra data
```

## Advanced Operations

### Export Cart (for sharing/backup)
```dart
String? jsonString = await cart.exportCart();
// Save jsonString to file or share
```

### Import Cart
```dart
String jsonString = '...'; // From file or network
bool success = await cart.importCart(jsonString);
```

### Merge Imported Cart
```dart
// Combines with existing cart
bool success = await cart.mergeImportedCart(jsonString);
```

### Backup & Restore
```dart
// Create backup
bool backed = await cart.backupCart();

// Restore from backup
bool restored = await cart.restoreFromBackup();
```

### Validation
```dart
// Check cart integrity
bool isValid = await cart.validateCart();

// Remove invalid items
await cart.cleanupCart();
```

## Display in UI

### Basic Cart Display
```dart
Consumer<CartProvider>(
  builder: (context, cart, child) {
    if (cart.isLoading) {
      return CircularProgressIndicator();
    }
    
    if (cart.items.isEmpty) {
      return Text('Cart is empty');
    }
    
    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        final item = cart.items[index];
        return ListTile(
          leading: Image.network(item.imageUrl),
          title: Text(item.title),
          subtitle: Text('Size: ${item.variant?.size ?? 'N/A'}'),
          trailing: Text(item.price),
        );
      },
    );
  },
)
```

### Cart Badge (Item Count)
```dart
Consumer<CartProvider>(
  builder: (context, cart, child) {
    return Badge(
      label: Text('${cart.itemCount}'),
      child: Icon(Icons.shopping_cart),
    );
  },
)
```

## Cart Initialization

### In main.dart
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final cartProvider = CartProvider();
  await cartProvider.loadCart(); // Load saved cart
  
  runApp(
    ChangeNotifierProvider.value(
      value: cartProvider,
      child: MyApp(),
    ),
  );
}
```

## Storage Details

### Location
- **Platform**: SharedPreferences
- **Key**: `shopping_cart`
- **Format**: JSON
- **Version**: 1 (with migration support)

### Storage Structure
```json
{
  "version": 1,
  "items": [
    {
      "id": "uuid-here",
      "productId": "product-123",
      "name": "Purple Hoodie",
      "price": "£29.99",
      "image": "https://...",
      "quantity": 2,
      "variant": {
        "size": "L",
        "colour": "Purple"
      },
      "oldPrice": "£39.99",
      "addedAt": "2025-12-05T10:30:00.000Z",
      "notes": null,
      "maxQuantity": null,
      "metadata": null
    }
  ],
  "lastSaved": "2025-12-05T10:30:00.000Z"
}
```

## Error Handling

### Adding Items
```dart
// Max quantity is enforced automatically
cart.addItem(
  productId: 'product-1',
  name: 'Item',
  image: 'url',
  price: '£10',
  quantity: 100,
  maxQuantity: 10, // Will prevent adding more than 10
);
```

### Loading Cart
```dart
// Automatically handles errors, returns empty cart on failure
await cart.loadCart(); // Never throws
```

### Validation
```dart
// Check before checkout
if (await cart.validateCart()) {
  // Cart is valid, proceed to checkout
} else {
  // Clean up invalid items
  await cart.cleanupCart();
}
```

## Best Practices

1. **Always use variants** for products with size/color options
2. **Set maxQuantity** for limited stock items
3. **Use oldPrice** to show discounts/sales
4. **Call loadCart()** in main.dart on app startup
5. **Validate cart** before checkout
6. **Use listen: false** when adding items to prevent rebuilds
7. **Show loading state** while cart is loading
8. **Handle empty state** gracefully

## Common Patterns

### Add to Cart with Confirmation
```dart
void addToCart(BuildContext context, Product product) {
  final cart = Provider.of<CartProvider>(context, listen: false);
  
  cart.addItem(
    productId: product.id,
    name: product.title,
    image: product.imageUrl,
    price: product.priceString,
    variant: CartVariant(size: selectedSize, colour: selectedColor),
  );
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Added to cart!'),
      action: SnackBarAction(
        label: 'View Cart',
        onPressed: () => Navigator.pushNamed(context, '/cart'),
      ),
    ),
  );
}
```

### Update Quantity with Limits
```dart
void incrementQuantity(CartProvider cart, int index) {
  final item = cart.items[index];
  if (item.isAtMaxQuantity) {
    // Show error
    return;
  }
  cart.updateQuantity(index, item.quantity + 1);
}
```

### Filter by Product
```dart
// Get all variants of a product
List<CartItem> productItems = cart.getItemsByProduct('product-123');

// Get unique variants
List<CartVariant> variants = cart.getVariantsForProduct('product-123');
```

---

**Quick Tips:**
- 💾 Cart auto-saves on every change
- 🔄 Duplicates are merged by product + variant
- 🎨 Variants make items unique (same product, different size = separate items)
- 📦 Use `metadata` for custom data (gift wrap, engraving, etc.)
- 🔢 Quantity limits are enforced automatically
