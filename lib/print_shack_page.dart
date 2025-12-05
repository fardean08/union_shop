import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  String _selectedLines = 'One Line of Text';
  final TextEditingController _line1Controller = TextEditingController();
  int _quantity = 1;

  @override
  void dispose() {
    _line1Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Announcement Bar
            Container(
              width: double.infinity,
              color: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text(
                'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                style: TextStyle(
                    color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Navbar placeholder
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF4d2963)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_540x.png?v=1614735854',
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          'The UNION',
                          style: TextStyle(
                            color: Color(0xFF4d2963),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Page content placeholder
            Container(
              padding: const EdgeInsets.all(24),
              child: const Center(
                child: Text(
                  'Print Shack - Personalisation Service',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
