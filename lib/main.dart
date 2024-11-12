import 'package:flutter/material.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductList(),
    );
  }
}

class Product {
  final String name;
  final String imagePath;
  int quantity;

  Product({required this.name, required this.imagePath, this.quantity = 0});
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Brigadeiro', imagePath: 'assets/images/brigadeiro.png'),
    Product(name: 'Beijinho', imagePath: 'assets/images/beijinho.png'),
    Product(name: 'Moranguinho', imagePath: 'assets/images/moranguinho.png'),
  ];

  void adjustQuantity(Product product, int value) {
    setState(() {
      product.quantity += value;
      if (product.quantity < 0) {
        product.quantity = 0;
      }
    });
  }

  void purchaseProducts() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Compra Realizada"),
          content: const Text("Produtos comprados com sucesso!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Produtos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.asset(
                    product.imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text("Quantidade: ${product.quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => adjustQuantity(product, -25),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => adjustQuantity(product, 25),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: purchaseProducts,
              child: const Text("Comprar"),
            ),
          ),
        ],
      ),
    );
  }
}
