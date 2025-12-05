import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'utils/responsive.dart';
import 'widgets/mobile_drawer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _noteController = TextEditingController();
  bool _showNoteField = false;
  String? _editingItemId; // Track which item is being edited

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final bool isMobile = ResponsiveHelper.isMobile(context);
    
    return Scaffold(
      drawer: isMobile ? const MobileDrawer() : null,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              height: ResponsiveHelper.value(
                context: context,
                mobile: 35.0,
                desktop: 40.0,
              ),              child: Image.network(
                'https://memplus-dev.ams3.cdn.digitaloceanspaces.com/media/RRzv6t6W0mp2ty8R9h4pMz6P4XQDBejVMUn8D2Hb.png',
                height: ResponsiveHelper.value(
                  context: context,
                  mobile: 35.0,
                  desktop: 40.0,
                ),
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 40,
                    width: 150,
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
                  return RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'The ',
                          style: TextStyle(
                            color: Color(0xFF4d2963),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'cursive',
                          ),
                        ),
                        TextSpan(
                          text: 'UNION',
                          style: TextStyle(
                            color: Color(0xFF4d2963),
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),            const SizedBox(width: 16),
            Text(
              'Your cart',
              style: TextStyle(
                color: Colors.black,
                fontSize: ResponsiveHelper.fontSize(
                  context: context,
                  mobile: 18.0,
                  tablet: 20.0,
                  desktop: 24.0,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),body: cart.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4d2963),
              ),
            )
          : cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your cart is empty.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Text(
                      'Continue shopping',
                      style: TextStyle(
                        color: Color(0xFF4d2963),
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            )          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveHelper.value(
                    context: context,
                    mobile: 12.0,
                    tablet: 16.0,
                    desktop: 16.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart items
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.items.length,
                      separatorBuilder: (context, index) => const Divider(height: 32),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return _buildCartItem(context, item, index, cart);
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Add note section
                    if (!_showNoteField)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showNoteField = true;
                          });
                        },
                        child: const Text(
                          '+ Add a note to your order',
                          style: TextStyle(
                            color: Color(0xFF4d2963),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add a note to your order',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _noteController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'How can we help you?',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF4d2963)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                    const SizedBox(height: 24),
                      // Subtotal
                    const Divider(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 16.0,
                              desktop: 18.0,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '£${cart.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 16.0,
                              desktop: 18.0,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tax included and shipping calculated at checkout',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.fontSize(
                          context: context,
                          mobile: 12.0,
                          desktop: 14.0,
                        ),
                        color: Colors.grey,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Checkout button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Proceeding to checkout...'),
                              backgroundColor: Color(0xFF4d2963),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Continue shopping
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/'),
                        child: const Text(
                          'Continue shopping',
                          style: TextStyle(
                            color: Color(0xFF4d2963),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, int index, CartProvider cart) {
    final isEditing = _editingItemId == item.id;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Product details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              
              // Size and Color - editable when in edit mode
              if (isEditing)
                _buildEditableVariant(item, index, cart)
              else
                _buildVariantDisplay(item),
              
              const SizedBox(height: 8),
                // Quantity controls
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 16),
                          onPressed: item.quantity > 1
                              ? () {
                                  cart.updateQuantity(index, item.quantity - 1);
                                }
                              : null,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          padding: const EdgeInsets.all(4),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 16),
                          onPressed: () {
                            cart.updateQuantity(index, item.quantity + 1);
                          },
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          padding: const EdgeInsets.all(4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Edit button
                  if (!isEditing)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _editingItemId = item.id;
                        });
                      },
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF4d2963),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    )
                  else
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _editingItemId = null;
                        });
                      },
                      icon: const Icon(Icons.check, size: 16),
                      label: const Text('Done'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      cart.removeItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item removed from cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                        color: Color(0xFF4d2963),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (item.oldPrice != null)
              Text(
                item.oldPrice!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        ),
      ],
    );
  }
  Widget _buildVariantDisplay(CartItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size: ${item.variant?.size ?? 'M'}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          'Colour: ${item.variant?.colour ?? 'Black'}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
  Widget _buildEditableVariant(CartItem item, int index, CartProvider cart) {
    final currentSize = item.variant?.size ?? 'M';
    final currentColour = item.variant?.colour ?? 'Black';
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Size selector
          Row(
            children: [
              const Text(
                'Size:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  children: ['XS', 'S', 'M', 'L', 'XL', 'XXL'].map((size) {
                    return ChoiceChip(
                      label: Text(
                        size,
                        style: const TextStyle(fontSize: 12),
                      ),
                      selected: currentSize == size,
                      onSelected: (selected) {
                        if (selected) {
                          cart.updateItemVariant(index, size, currentColour);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Size updated to $size'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      selectedColor: const Color(0xFF4d2963).withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: currentSize == size
                            ? const Color(0xFF4d2963)
                            : Colors.black87,
                        fontWeight: currentSize == size
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Color selector
          Row(
            children: [
              const Text(
                'Colour:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  children: ['Black', 'White', 'Purple', 'Navy', 'Grey'].map((colour) {
                    return ChoiceChip(
                      label: Text(
                        colour,
                        style: const TextStyle(fontSize: 12),
                      ),
                      selected: currentColour == colour,
                      onSelected: (selected) {
                        if (selected) {
                          cart.updateItemVariant(index, currentSize, colour);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Colour updated to $colour'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      selectedColor: const Color(0xFF4d2963).withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: currentColour == colour
                            ? const Color(0xFF4d2963)
                            : Colors.black87,
                        fontWeight: currentColour == colour
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
