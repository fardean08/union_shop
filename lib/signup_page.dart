import 'package:flutter/material.dart';
import 'main.dart';
import 'utils/responsive.dart';
import 'widgets/mobile_drawer.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsiveHelper.isMobile(context) ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Navbar(),
            SignupForm(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: ResponsiveHelper.fontSize(
                    context: context,
                    mobile: 28.0,
                    desktop: 32.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4d2963),
                ),
              ),
              SizedBox(
                height: ResponsiveHelper.value(
                  context: context,
                  mobile: 24.0,
                  desktop: 32.0,
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
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
                      const SnackBar(content: Text('Sign Up button pressed')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
                    'Sign Up',
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
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    fontSize: ResponsiveHelper.fontSize(
                      context: context,
                      mobile: 14.0,
                      desktop: 16.0,
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
