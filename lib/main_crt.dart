import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice UI',
      home: InvoiceScreen(),
    );
  }
}

class InvoiceScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'name': 'Almonds',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
    {
      'name': 'Mixed Fruit Preserve',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
    {
      'name': 'Assorted Biscuits',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
    {
      'name': 'Organic Honey',
      'image':
          'https://5.imimg.com/data5/QN/EJ/MY-12250086/honey-pouring_1_6-500x500.jpg'
    },
    {
      'name': 'Rice',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
    {
      'name': 'Natural Black Pepper',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
    {
      'name': 'Dark Chocolate',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
    {
      'name': 'Olive Oil',
      'image':
          'https://png.pngtree.com/png-vector/20231115/ourmid/pngtree-apple-market-sweet-healthy-png-image_10516470.png'
    },
  ];

  final List<Map<String, dynamic>> cartItems = [
    {'name': 'Mixed Fruit Preserve', 'price': 280.00},
    {'name': 'Organic Honey', 'price': 750.00},
    {'name': 'Natural Black Pepper', 'price': 162.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Create Invoice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(right: BorderSide(color: Colors.blueGrey.shade100))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: const Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: const [
                      ListTile(title: Text('All Items')),
                      ListTile(title: Text('Fresh Fruits')),
                      ListTile(title: Text('Fresh Vegetables')),
                      ListTile(title: Text('Pulses and Grains')),
                      ListTile(title: Text('Spices')),
                      ListTile(title: Text('Oils')),
                      ListTile(title: Text('Dairy')),
                      ListTile(title: Text('Chocolates')),
                      ListTile(title: Text('Snacks')),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type here to search [F10]',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

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
                    itemCount: products.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Container(
                        width: 200, // Container width
                        height: 150, // Container height
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                /*  boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],*/
                                image: DecorationImage(
                                  image: NetworkImage(
                                    product['image']!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Text overlay at the bottom
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8.0)),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  product['name']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                border:
                    Border(left: BorderSide(color: Colors.blueGrey.shade100))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  color: Colors.blueGrey[100],
                  child: const Text(
                    'Cart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item['name']),
                        trailing: Text('₹${item['price'].toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total:',
                        // 'Total: ₹${cartItems.fold(0, (sum, item) => sum + item['price']).toStringAsFixed(2)}',
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
                              onPressed: () {},
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
