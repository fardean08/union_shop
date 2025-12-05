import 'package:flutter/material.dart';
import 'cart_provider.dart';

final cartProvider = CartProvider();

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = cartProvider;
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Image.network(item.imageUrl,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(item.title),
                  subtitle: Text(
                      'Size: ${item.size}, Colour: ${item.colour}\nQuantity: ${item.quantity}'),
                  trailing: Text(item.price),
                );
              },
            ),
      bottomNavigationBar: cart.items.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: £${cart.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      cart.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order placed!')));
                      setState(() {});
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
