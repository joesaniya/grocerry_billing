import 'package:flutter/material.dart';
import 'package:flutter_bill/models/product.dart';
import 'package:flutter_bill/views/widgets/alert_box.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String selectedCategory = 'All Items';
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
        (100.0 + product['name']!.length * 5).toDouble(); 
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
                            title: Text(
                              category,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedCategory == category
                                      ? Colors.blue
                                      : Colors.black),
                            ),
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
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8))),
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  // color: Colors.blueGrey[100],
                  child: const Text(
                    'Cart',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      print('Cart:$item');
                      return ListTile(
                        title: Text(
                          item['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16),
                        ),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                              ),
                              onPressed: () => updateCartItem(
                                  item['name'], item['quantity'] - 1),
                            ),
                            Text(
                              '${item['quantity']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => updateCartItem(
                                  item['name'], item['quantity'] + 1),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
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

                      Text(
                        'Tax (${(taxRate * 100).toStringAsFixed(0)}%): ₹${(getCartTotal() - (getCartTotal() / (1 + taxRate))).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        'Total: ₹${getCartTotal().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey
                                    .shade100, 
                                foregroundColor: Colors.white, 
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 12.0), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                print('items:$cartItems');
                                showTotalAmountAlert(
                                    context, getCartTotal(), cartItems);
                              },
                              child: const Text(
                                'Cash [F1]',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey
                                    .shade100,
                                foregroundColor: Colors.white, 
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 12.0), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Credit Card [F2]',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey
                                    .shade100,
                                foregroundColor: Colors.white, 
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 12.0), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'UPI [F3]',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
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
