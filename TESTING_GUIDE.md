# Union Shop - Shopping Cart Testing Guide

## Setup Instructions

### 1. Install Dependencies
Before running the app, make sure all dependencies are installed:

```powershell
cd N:\programming\union_shop
flutter pub get
```

### 2. Run the Application
To run the app in your browser (Edge or Chrome):

```powershell
# For Edge
flutter run -d edge

# For Chrome
flutter run -d chrome
```

## What Was Implemented

### ✅ Cart Provider (State Management)
- **File:** `lib/cart_provider.dart`
- Uses `ChangeNotifier` for reactive state management
- Manages cart items globally across the app
- Methods: `addItem()`, `removeItem()`, `updateQuantity()`, `clearCart()`
- Computed properties: `totalPrice`, `itemCount`

### ✅ Cart Page (User Interface)
- **File:** `lib/cart_page.dart`
- Modern, clean design matching reference
- Product images (100x100px)
- Quantity controls (+/- buttons)
- Remove button for each item
- Subtotal display
- Tax and shipping message
- "Add a note to your order" section
- "Continue shopping" link
- Checkout button
- Empty cart state

### ✅ Product Page (Add to Cart)
- **File:** `lib/product_page.dart`
- Accepts `Product` object or shows placeholder
- Size selection (required)
- Colour selection (required)
- Quantity selector
- "Add to cart" button with validation
- Cart icon badge showing item count
- Success notifications
- Navigates to cart

### ✅ Collection Pages Integration
- **Files:** 
  - `lib/collections_shirts_page.dart`
  - `lib/collections_hoodies_page.dart`
  - `lib/collections_accessories_page.dart`
- All pass full `Product` object to ProductPage
- Clicking a product opens detail page

### ✅ Main App Configuration
- **File:** `lib/main.dart`
- Wrapped with `ChangeNotifierProvider<CartProvider>`
- Route handler updated to accept `Product` objects
- Removed duplicate ProductPage class
- FeaturedSection products navigate properly

## Testing Checklist

### Test 1: Browse and View Products
1. ✅ Start the app
2. ✅ Navigate to "Shop" → "T-Shirts"
3. ✅ Click on any product
4. ✅ Verify product details display correctly
5. ✅ Verify size and colour options appear

### Test 2: Add Item to Cart (Validation)
1. ✅ On product page, click "Add to cart" WITHOUT selecting size/colour
2. ✅ Verify error message appears: "Please select a size and colour"
3. ✅ Select a size (click on a size chip)
4. ✅ Verify size chip turns purple when selected
5. ✅ Select a colour (click on a colour chip)
6. ✅ Verify colour chip turns purple when selected

### Test 3: Add Item to Cart (Success)
1. ✅ Select size and colour
2. ✅ Adjust quantity using +/- buttons (try setting to 3)
3. ✅ Click "Add to cart"
4. ✅ Verify success message appears: "Added to cart!"
5. ✅ Verify cart icon badge shows item count (3)
6. ✅ Click "View Cart" in the snackbar

### Test 4: View Cart
1. ✅ Verify cart page opens
2. ✅ Verify item appears with:
   - Product image
   - Product title
   - Size and colour information
   - Quantity (3)
   - Price
3. ✅ Verify subtotal is calculated correctly (price × quantity)
4. ✅ Verify "Tax included and shipping calculated at checkout" message

### Test 5: Update Quantity in Cart
1. ✅ Click the "+" button next to quantity
2. ✅ Verify quantity increases to 4
3. ✅ Verify subtotal updates automatically
4. ✅ Click the "-" button
5. ✅ Verify quantity decreases to 3
6. ✅ Verify subtotal updates again

### Test 6: Remove Item from Cart
1. ✅ Click "Remove" link on an item
2. ✅ Verify item is removed from cart
3. ✅ Verify "Item removed from cart" message appears
4. ✅ If cart is now empty, verify empty cart message

### Test 7: Add Multiple Different Items
1. ✅ Click "Continue shopping"
2. ✅ Navigate to a different collection (e.g., Hoodies)
3. ✅ Select a different product
4. ✅ Select size and colour
5. ✅ Click "Add to cart"
6. ✅ Go to cart
7. ✅ Verify both items appear in cart
8. ✅ Verify subtotal is sum of both items

### Test 8: Add Same Item with Different Options
1. ✅ Go back to a product you already have in cart
2. ✅ Select a DIFFERENT size or colour
3. ✅ Add to cart
4. ✅ Go to cart
5. ✅ Verify this appears as a separate line item
6. ✅ Verify subtotal includes both

### Test 9: Add Same Item with Same Options
1. ✅ Go back to a product already in cart
2. ✅ Select the SAME size and colour
3. ✅ Set quantity to 2
4. ✅ Add to cart
5. ✅ Go to cart
6. ✅ Verify quantity increased by 2 (not a new line item)
7. ✅ Verify subtotal is correct

### Test 10: Add Order Note
1. ✅ In cart page, click "+ Add a note to your order"
2. ✅ Verify text field appears
3. ✅ Type a note (e.g., "Please wrap as a gift")
4. ✅ Verify note is saved (stays when you scroll)

### Test 11: Empty Cart
1. ✅ Remove all items from cart one by one
2. ✅ Verify empty cart state appears
3. ✅ Verify message: "Your cart is empty."
4. ✅ Click "Continue shopping"
5. ✅ Verify navigation to home page

### Test 12: Cart Badge Updates
1. ✅ Add items to cart
2. ✅ Navigate to different pages (About, Sale, etc.)
3. ✅ Verify cart badge always shows correct count
4. ✅ Click cart icon from any page
5. ✅ Verify cart opens with items

### Test 13: Featured Products on Home Page
1. ✅ Navigate to home page
2. ✅ Click on a featured product (Essential or Signature range)
3. ✅ Verify product page opens correctly
4. ✅ Verify you can select size, colour, and add to cart
5. ✅ Verify cart functionality works the same

### Test 14: Responsive Design
1. ✅ Resize browser window to mobile size (~400px)
2. ✅ Verify cart page layout adjusts
3. ✅ Verify product images stack properly
4. ✅ Verify buttons remain clickable
5. ✅ Test on tablet size (~768px)
6. ✅ Test on desktop size (>1024px)

### Test 15: Error Handling
1. ✅ Disconnect internet
2. ✅ Try to view products
3. ✅ Verify placeholder images appear for broken image links
4. ✅ Reconnect internet
5. ✅ Verify images load properly

## Known Limitations

1. **Cart Persistence:** Cart items are cleared when you refresh the page (no local storage yet)
2. **Checkout:** Checkout button shows placeholder message (not implemented)
3. **Order Notes:** Notes are not persisted (UI only)
4. **Stock Management:** No stock availability checks
5. **User Accounts:** Cart is not tied to user accounts

## Architecture Overview

```
┌─────────────────────────────────────────────────┐
│                   main.dart                      │
│  (Wraps app with ChangeNotifierProvider)        │
└────────────────┬────────────────────────────────┘
                 │
                 ├── HomeScreen
                 ├── CollectionsPage
                 │   ├── CollectionsShirtsPage ──┐
                 │   ├── CollectionsHoodiesPage ─┼─> ProductPage
                 │   └── CollectionsAccessoriesPage ┘
                 │
                 ├── ProductPage ───────────────────> CartProvider.addItem()
                 │   (Uses Provider.of<CartProvider>)
                 │
                 └── CartPage ──────────────────────> CartProvider
                     (Uses Provider.of<CartProvider>)
                     
CartProvider (ChangeNotifier)
├── items: List<CartItem>
├── itemCount: int
├── totalPrice: double
├── addItem(CartItem)
├── removeItem(int index)
├── updateQuantity(int index, int quantity)
└── clearCart()
```

## File Changes Summary

| File | Status | Changes |
|------|--------|---------|
| `pubspec.yaml` | ✅ Modified | Added `provider: ^6.1.1` dependency |
| `lib/cart_provider.dart` | ✅ Updated | Complete CartProvider with ChangeNotifier |
| `lib/cart_page.dart` | ✅ Updated | Full UI redesign with Provider integration |
| `lib/product_page.dart` | ✅ Updated | Accepts Product, size/colour selection, cart integration |
| `lib/main.dart` | ✅ Updated | Provider wrapper, route updates, removed duplicate class |
| `lib/collections_shirts_page.dart` | ✅ Updated | Pass Product object to route |
| `lib/collections_hoodies_page.dart` | ✅ Updated | Pass Product object to route |
| `lib/collections_accessories_page.dart` | ✅ Updated | Pass Product object to route |
| `lib/models/product.dart` | ℹ️ Unchanged | Product model already existed |
| `lib/services/product_service.dart` | ℹ️ Unchanged | Product service already existed |

## Troubleshooting

### "Provider not found" error
**Solution:** Make sure you ran `flutter pub get` after updating `pubspec.yaml`

```powershell
flutter pub get
```

### Cart badge not updating
**Solution:** Make sure the widget tree is using `Consumer<CartProvider>` or `Provider.of<CartProvider>(context)` with `listen: true`

### Items not appearing in cart
**Solution:** Check that:
1. Size and colour are selected
2. ProductPage is using `Provider.of<CartProvider>(context, listen: false)` to add items
3. CartPage is using `Provider.of<CartProvider>(context)` to read items

### App won't run
**Solution:** 
1. Check for compile errors: `flutter analyze`
2. Clean and rebuild: `flutter clean && flutter pub get`
3. Restart VS Code

## Next Steps (Future Enhancements)

1. **Cart Persistence**
   - Save cart to SharedPreferences or local storage
   - Restore cart on app restart

2. **Checkout Flow**
   - Create checkout page
   - Collect shipping information
   - Payment integration

3. **User Authentication**
   - Login/signup functionality
   - Tie cart to user account
   - Order history

4. **Product Improvements**
   - Product reviews and ratings
   - Product variants (more colors/sizes)
   - Stock availability indicators
   - Product search and filters

5. **Cart Enhancements**
   - Save for later functionality
   - Recently viewed items
   - Product recommendations
   - Discount codes/coupons

## Support

If you encounter any issues:
1. Check the console for error messages
2. Run `flutter doctor` to check your Flutter installation
3. Ensure all dependencies are installed with `flutter pub get`
4. Check the CART_IMPLEMENTATION_SUMMARY.md for detailed implementation notes

---

**Version:** 1.0.0  
**Last Updated:** December 5, 2025  
**Status:** ✅ Complete and Ready for Testing
