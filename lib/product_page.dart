import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'models/cart_variant.dart';
import 'cart_provider.dart';
import 'utils/responsive.dart';
import 'widgets/mobile_drawer.dart';

class ProductPage extends StatefulWidget {
  final Product? product;

  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? selectedSize;
  String? selectedColour;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    // Set default values based on product or use defaults
    selectedSize = widget.product?.sizes.first ?? 'L';
    selectedColour = widget.product?.colors.first ?? 'Baby Pink';
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  void addToCart(BuildContext context) {
    if (selectedSize == null || selectedColour == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a size and colour'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }    final cart = Provider.of<CartProvider>(context, listen: false);
    final product = widget.product;
    
    if (product != null) {
      cart.addItem(
        productId: product.id,
        name: product.title,
        image: product.imageUrl,
        price: product.priceString,
        oldPrice: product.oldPriceString,
        quantity: quantity,
        variant: CartVariant(
          size: selectedSize!,
          colour: selectedColour!,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Added to cart!'),
          backgroundColor: const Color(0xFF4d2963),
          action: SnackBarAction(
            label: 'View Cart',
            textColor: Colors.white,
            onPressed: () => navigateToCart(context),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use provided product or fallback to placeholder
    final product = widget.product;
    final cart = Provider.of<CartProvider>(context);    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [                  // Top banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.value(
                        context: context,
                        mobile: 6.0,
                        desktop: 8.0,
                      ),
                    ),
                    color: const Color(0xFF4d2963),
                    child: Text(
                      'The UNION Shop - Quality Apparel & Accessories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveHelper.fontSize(
                          context: context,
                          mobile: 11.0,
                          tablet: 13.0,
                          desktop: 16.0,
                        ),
                      ),
                    ),
                  ),
                  // Main header
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          // Hamburger menu on mobile
                          if (isMobile)
                            Builder(
                              builder: (context) => IconButton(
                                icon: const Icon(Icons.menu, color: Color(0xFF4d2963)),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                          
                          GestureDetector(
                            onTap: () {
                              navigateToHome(context);
                            },
                            child: SizedBox(
                              height: ResponsiveHelper.value(
                                context: context,
                                mobile: 35.0,
                                tablet: 40.0,
                                desktop: 40.0,
                              ),
                              child: Image.network(
                                'https://memplus-dev.ams3.cdn.digitaloceanspaces.com/media/RRzv6t6W0mp2ty8R9h4pMz6P4XQDBejVMUn8D2Hb.png',
                                height: ResponsiveHelper.value(
                                  context: context,
                                  mobile: 35.0,
                                  tablet: 40.0,
                                  desktop: 40.0,
                                ),
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                        strokeWidth: 2,
                                        color: const Color(0xFF4d2963),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Text(
                                    'The UNION',
                                    style: TextStyle(
                                      color: const Color(0xFF4d2963),
                                      fontSize: ResponsiveHelper.fontSize(
                                        context: context,
                                        mobile: 16.0,
                                        desktop: 20.0,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Cart icon (always visible)
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: ResponsiveHelper.value(
                                    context: context,
                                    mobile: 24.0,
                                    desktop: 28.0,
                                  ),
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () => navigateToCart(context),
                              ),
                              if (cart.itemCount > 0)
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4d2963),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: ResponsiveHelper.value(
                                        context: context,
                                        mobile: 16.0,
                                        desktop: 18.0,
                                      ),
                                      minHeight: ResponsiveHelper.value(
                                        context: context,
                                        mobile: 16.0,
                                        desktop: 18.0,
                                      ),
                                    ),
                                    child: Text(
                                      '${cart.itemCount}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveHelper.fontSize(
                                          context: context,
                                          mobile: 9.0,
                                          desktop: 10.0,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),            // Product details
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(
                ResponsiveHelper.value(
                  context: context,
                  mobile: 16.0,
                  tablet: 20.0,
                  desktop: 24.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    height: ResponsiveHelper.value(
                      context: context,
                      mobile: 300.0,
                      tablet: 350.0,
                      desktop: 400.0,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product?.imageUrl ?? 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: ResponsiveHelper.value(
                                      context: context,
                                      mobile: 48.0,
                                      desktop: 64.0,
                                    ),
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Image unavailable',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ResponsiveHelper.fontSize(
                                        context: context,
                                        mobile: 12.0,
                                        desktop: 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: ResponsiveHelper.value(
                      context: context,
                      mobile: 16.0,
                      desktop: 24.0,
                    ),
                  ),

                  // Product name
                  Text(
                    product?.title ?? 'UNION Shop Product',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.fontSize(
                        context: context,
                        mobile: 20.0,
                        tablet: 24.0,
                        desktop: 28.0,
                      ),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(
                    height: ResponsiveHelper.value(
                      context: context,
                      mobile: 8.0,
                      desktop: 12.0,
                    ),
                  ),

                  // Product price
                  Row(
                    children: [
                      Text(
                        product?.priceString ?? '£15.00',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.fontSize(
                            context: context,
                            mobile: 20.0,
                            tablet: 22.0,
                            desktop: 24.0,
                          ),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4d2963),
                        ),
                      ),
                      if (product?.oldPrice != null) ...[
                        const SizedBox(width: 12),
                        Text(
                          product!.oldPriceString!,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 16.0,
                              desktop: 18.0,
                            ),
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 8),
                  
                  Text(
                    'Tax included.',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.fontSize(
                        context: context,
                        mobile: 12.0,
                        desktop: 14.0,
                      ),
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(
                    height: ResponsiveHelper.value(
                      context: context,
                      mobile: 16.0,
                      desktop: 24.0,
                    ),
                  ),                  // Color, Size and Quantity Row
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Color Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.fontSize(
                                      context: context,
                                      mobile: 13.0,
                                      desktop: 14.0,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedColour,
                                      isExpanded: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      items: (product?.colors ?? ['Black', 'White', 'Navy']).map((colour) {
                                        return DropdownMenuItem(
                                          value: colour,
                                          child: Text(colour),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedColour = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Size Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.fontSize(
                                      context: context,
                                      mobile: 13.0,
                                      desktop: 14.0,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedSize,
                                      isExpanded: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      items: (product?.sizes ?? ['S', 'M', 'L', 'XL']).map((size) {
                                        return DropdownMenuItem(
                                          value: size,
                                          child: Text(size),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedSize = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Quantity Input
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.fontSize(
                                      context: context,
                                      mobile: 13.0,
                                      desktop: 14.0,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '$quantity',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  quantity++;
                                                });
                                              },
                                              child: Container(
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(color: Colors.grey.shade300),
                                                    bottom: BorderSide(color: Colors.grey.shade300),
                                                  ),
                                                ),
                                                child: const Icon(Icons.arrow_drop_up, size: 20),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (quantity > 1) {
                                                  setState(() {
                                                    quantity--;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(color: Colors.grey.shade300),
                                                  ),
                                                ),
                                                child: const Icon(Icons.arrow_drop_down, size: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Color Dropdown
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Color',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedColour,
                                  isExpanded: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  items: (product?.colors ?? ['Black', 'White', 'Navy']).map((colour) {
                                    return DropdownMenuItem(
                                      value: colour,
                                      child: Text(colour),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedColour = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Size Dropdown
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Size',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedSize,
                                  isExpanded: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  items: (product?.sizes ?? ['S', 'M', 'L', 'XL']).map((size) {
                                    return DropdownMenuItem(
                                      value: size,
                                      child: Text(size),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSize = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Quantity Input
                      SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$quantity',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                          child: Container(
                                            width: 30,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(color: Colors.grey.shade300),
                                                bottom: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                            child: const Icon(Icons.arrow_drop_up, size: 20),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 30,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                            child: const Icon(Icons.arrow_drop_down, size: 20),
                                          ),
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
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Add to cart button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => addToCart(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),                  // Product description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product?.productDescription ?? 'Quality apparel from The UNION Shop. Designed for comfort, style, and durability. Perfect for students and anyone looking for great everyday wear.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '© 2025 The UNION Shop',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 24),
                      Text(
                        '•',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Quality Apparel & Accessories',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),],
        ),
      ),
    );
  }
}
