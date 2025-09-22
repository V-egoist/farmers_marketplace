import 'package:flutter/material.dart';

class WidgetsDemo extends StatelessWidget {
  const WidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widgets Demo")),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text("Tomatoes"),
            subtitle: Text("Price: \$5 per kg"),
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text("Onions"),
            subtitle: Text("Price: \$3 per kg"),
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text("Carrots"),
            subtitle: Text("Price: \$4 per kg"),
          ),
        ],
      ),
    );
  }
}
