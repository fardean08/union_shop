import 'package:flutter/material.dart';
import 'main.dart';
import 'utils/responsive.dart';
import 'widgets/mobile_drawer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsiveHelper.isMobile(context) ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Navbar(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveHelper.value(
                  context: context,
                  mobile: 24.0,
                  desktop: 48.0,
                ),
                horizontal: ResponsiveHelper.value(
                  context: context,
                  mobile: 16.0,
                  tablet: 24.0,
                  desktop: 24.0,
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveHelper.value(
                      context: context,
                      mobile: double.infinity,
                      tablet: 500.0,
                      desktop: 500.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.fontSize(
                            context: context,
                            mobile: 28.0,
                            desktop: 32.0,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveHelper.value(
                          context: context,
                          mobile: 24.0,
                          desktop: 32.0,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveHelper.value(
                          context: context,
                          mobile: 24.0,
                          desktop: 32.0,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login button pressed')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: ResponsiveHelper.value(
                                context: context,
                                mobile: 14.0,
                                desktop: 16.0,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.fontSize(
                                context: context,
                                mobile: 16.0,
                                desktop: 18.0,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(
                              context: context,
                              mobile: 14.0,
                              desktop: 16.0,
                            ),
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
