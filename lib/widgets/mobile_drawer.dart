import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/cart_provider.dart';

/// Mobile navigation drawer for hamburger menu
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header with logo
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4d2963),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://memplus-dev.ams3.cdn.digitaloceanspaces.com/media/RRzv6t6W0mp2ty8R9h4pMz6P4XQDBejVMUn8D2Hb.png',
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'The ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'cursive',
                            ),
                          ),
                          TextSpan(
                            text: 'UNION',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  'Shop Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation Items
          _buildDrawerItem(
            context: context,
            icon: Icons.home_outlined,
            title: 'Home',
            route: '/',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.shopping_bag_outlined,
            title: 'Shop',
            route: '/collections',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.print_outlined,
            title: 'Print Shack',
            route: '/print-shack',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.local_offer_outlined,
            title: 'SALE!',
            route: '/sale',
            highlight: true,
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.info_outline,
            title: 'About',
            route: '/about',
          ),
          
          const Divider(),
          
          // User Actions
          _buildDrawerItem(
            context: context,
            icon: Icons.search,
            title: 'Search',
            route: '/search',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.person_outline,
            title: 'Login',
            route: '/login',
          ),
          
          // Cart with badge
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return ListTile(
                leading: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, color: Color(0xFF4d2963)),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  'Cart${cart.itemCount > 0 ? " (${cart.itemCount})" : ""}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/cart');
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    bool highlight = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: highlight ? Colors.red : const Color(0xFF4d2963),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
          color: highlight ? Colors.red : Colors.black87,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.pushNamed(context, route);
      },
    );
  }
}
