import 'package:flutter/material.dart';
// Fixed: The shared_preferences package must be added to pubspec.yaml for this import to work.
// TODO: Run 'flutter pub add shared_preferences' in your project root to resolve this error.
import 'package:shared_preferences/shared_preferences.dart';

// Fixed: Corrected import paths from 'screens/' to 'screen/'
import 'screen/auth_screen.dart';
import 'screen/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This method checks if the user is already logged in
  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // FutureBuilder is used to check the login status before building the app
      home: FutureBuilder(
        future: _isLoggedIn(),
        builder: (ctx, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while we check the token
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (authSnapshot.data == true) {
            // If the user is logged in, show the ProductListScreen
            // Fixed: ProductListScreen is now imported from the correct path
            return const ProductListScreen();
          } else {
            // If not logged in, show the AuthScreen
            // Fixed: AuthScreen is now imported from the correct path
            return const AuthScreen();
          }
        },
      ),
      routes: {
  // Fixed: AuthScreen and ProductListScreen are now imported from the correct path
  '/auth': (ctx) => const AuthScreen(),
  '/home': (ctx) => const ProductListScreen(),
      },
    );
  }
}