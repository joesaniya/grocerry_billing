import 'package:flutter/material.dart';
import 'package:flutter_bill/views/widgets/alert_box.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String selectedCategory = 'All Items';

  final List<Map<String, String>> products = [
    {
      'name': 'Almonds',
      'category': 'Snacks',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Mixed Fruit Preserve',
      'category': 'Fresh Fruits',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Assorted Biscuits',
      'category': 'Snacks',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Organic Honey',
      'category': 'Oils',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Rice',
      'category': 'Pulses and Grains',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Natural Black Pepper',
      'category': 'Spices',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Dark Chocolate',
      'category': 'Chocolates',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Olive Oil',
      'category': 'Oils',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];
  double discount = 0.0;
  double taxRate = 0.1;

  double getCartTotal() {
    double subtotal = cartItems.fold(
        0,
        (total, item) =>
            total + (item['price'] as double) * (item['quantity'] as int));
    double tax = subtotal * taxRate;
    return subtotal - discount + tax;
  }

  void addToCart(Map<String, String> product) {
    final price =
        (100.0 + product['name']!.length * 5).toDouble(); // Example price logic
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == product['name'],
        orElse: () => {},
      );

      if (existingItem.isEmpty) {
        cartItems.add({'name': product['name'], 'price': price, 'quantity': 1});
      } else {
        existingItem['quantity'] += 1;
      }
    });
  }

  void updateCartItem(String name, int quantity) {
    setState(() {
      final item = cartItems.firstWhere((item) => item['name'] == name);
      if (quantity <= 0) {
        cartItems.remove(item);
      } else {
        item['quantity'] = quantity;
      }
    });
  }

  void removeCartItem(String name) {
    setState(() {
      cartItems.removeWhere((item) => item['name'] == name);
    });
  }

  List<Map<String, String>> getFilteredProducts() {
    if (selectedCategory == 'All Items') {
      return products;
    }
    return products
        .where((product) => product['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Create Invoice'),
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.blueGrey.shade100),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      'All Items',
                      'Fresh Fruits',
                      'Fresh Vegetables',
                      'Pulses and Grains',
                      'Spices',
                      'Oils',
                      'Dairy',
                      'Chocolates',
                      'Snacks',
                    ]
                        .map(
                          (category) => ListTile(
                            title: Text(category),
                            selected: selectedCategory == category,
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Product Grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: getFilteredProducts().length,
                    itemBuilder: (context, index) {
                      final product = getFilteredProducts()[index];
                      return GestureDetector(
                        onTap: () => addToCart(product),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(product['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.black.withOpacity(0.6),
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    product['name']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Cart Section
          Container(
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(color: Colors.blueGrey.shade100)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blueGrey[100],
                  child: const Text(
                    'Cart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      print('Cart:$item');
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => updateCartItem(
                                  item['name'], item['quantity'] - 1),
                            ),
                            Text('${item['quantity']}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => updateCartItem(
                                  item['name'], item['quantity'] + 1),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                        ),
                        onLongPress: () => removeCartItem(item['name']),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Discount',
                          prefixText: '₹',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            discount = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      // Show the tax rate and calculate the tax
                      Text(
                        'Tax (${(taxRate * 100).toStringAsFixed(0)}%): ₹${(getCartTotal() - (getCartTotal() / (1 + taxRate))).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Show the total amount
                      Text(
                        'Total: ₹${getCartTotal().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                print('items:$cartItems');
                                showTotalAmountAlert(
                                    context, getCartTotal(), cartItems);
                              },
                              child: const Text('Cash [F1]'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Credit Card [F2]'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('UPI [F3]'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}