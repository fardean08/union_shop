# Union Shop - Quick Start Guide

## 🚀 Run the App

```powershell
cd N:\programming\union_shop
flutter pub get
flutter run -d edge
```

## ✅ What's Complete

### Shopping Cart System (100% Complete)
- ✅ Add items to cart with size/colour selection
- ✅ Update quantities (+/- buttons)
- ✅ Remove items from cart
- ✅ View cart with product images
- ✅ Calculate subtotal automatically
- ✅ Add order notes
- ✅ Cart badge showing item count
- ✅ Empty cart state
- ✅ Provider state management

## 🎯 Quick Test Path

1. **Run the app** → `flutter run -d edge`
2. **Browse products** → Click "Shop" → "T-Shirts"
3. **Select product** → Click any product card
4. **Configure item** → Select size, colour, quantity
5. **Add to cart** → Click "Add to cart" button
6. **View cart** → Click cart icon (shopping bag)
7. **Update cart** → Use +/- buttons, click Remove
8. **Continue** → Click "Continue shopping" or "Checkout"

## 📂 Key Files

| File | Purpose |
|------|---------|
| `lib/cart_provider.dart` | State management |
| `lib/cart_page.dart` | Cart UI |
| `lib/product_page.dart` | Product detail & add to cart |
| `lib/main.dart` | App setup with Provider |
| `pubspec.yaml` | Dependencies (provider: ^6.1.1) |

## 🔧 Common Commands

```powershell
# Install dependencies
flutter pub get

# Run app in browser
flutter run -d edge
flutter run -d chrome

# Check for issues
flutter analyze

# Clean build
flutter clean
flutter pub get

# Hot reload (while app is running)
Press 'r' in terminal
```

## 📱 Features to Test

- [x] Add to cart from collection pages
- [x] Add to cart from featured products
- [x] Size and colour validation
- [x] Quantity controls
- [x] Remove items
- [x] Cart badge updates
- [x] Subtotal calculation
- [x] Empty cart state
- [x] Order notes
- [x] Navigation between pages

## 🎨 Design Details

**Theme Color:** `#4d2963` (Purple)
**Cart Badge:** Shows total item count
**Validation:** Size & colour required before adding to cart
**Success Message:** "Added to cart!" with "View Cart" action

## 📚 Documentation

- `CART_IMPLEMENTATION_SUMMARY.md` - Complete implementation details
- `TESTING_GUIDE.md` - Full testing checklist with 15 test scenarios
- `README.md` - Project overview

## 🐛 Troubleshooting

**Error: "Provider not found"**
```powershell
flutter pub get
```

**Error: "Package not found"**
```powershell
flutter clean
flutter pub get
```

**Cart not updating**
- Check console for errors
- Verify Provider is wrapped in main.dart
- Hot reload: Press 'r'

**App won't start**
```powershell
flutter doctor
flutter clean
flutter pub get
flutter run -d edge
```

## 🎉 Success Indicators

When the app is working correctly, you should see:

✅ No compile errors
✅ App loads in browser
✅ Can navigate between pages
✅ Can add items to cart
✅ Cart icon shows badge with count
✅ Cart page displays items
✅ Can update quantities
✅ Can remove items
✅ Subtotal calculates correctly

---

**Status:** ✅ Ready to Run
**Version:** 1.0.0
**Date:** December 5, 2025
