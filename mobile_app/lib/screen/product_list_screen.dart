// lib/screens/product_list_screen.dart
import 'package:flutter/material.dart';
// Fixed: Removed unused import 'package:http/http.dart' as http;
// Fixed: Changed to relative imports for local files
import '../models/product.dart';
import '../dummy_data.dart';
import 'add_product_screen.dart';
// Fixed: Removed unused import 'auth_screen.dart';
import '../services/auth_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Fixed: AuthService and Product are now imported from the correct paths
  final AuthService _authService = AuthService();
  late Future<List<Product>> _futureProducts;

  // Fixed: dummyProducts is now imported from the correct path
  Future<List<Product>> fetchProducts() async {
    return Future.delayed(const Duration(seconds: 1), () => dummyProducts);
  }

  // New logout function
  void _logout() async {
    await _authService.logout();
    // Navigate back to the authentication screen after logging out
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          // The new logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Tsh ${product.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No products found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
          if (result == true) {
            setState(() {
              _futureProducts = fetchProducts();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}