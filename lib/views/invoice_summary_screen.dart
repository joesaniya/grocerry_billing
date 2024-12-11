import 'package:flutter/material.dart';

class InvoiceSummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final double subtotal;
  final double tax;
  final double total;
  final String paymentType;
  final String customerName;
  final String customerContact;
  final String customerAddress;

  InvoiceSummaryScreen({
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.paymentType,
    required this.customerName,
    required this.customerContact,
    required this.customerAddress,
  });
  @override
  Widget build(BuildContext context) {
    print('cartItem:$cartItems');
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Invoice'),
        backgroundColor: Colors.indigo,
      ),
      body: Row(
        children: [
          // Left Section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Company: Zylker Family Mart',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: cartItems.map((item) {
                        final price = item['price']; // Fallback to 0.0 if null
                        final qty = item['quantity']; // Fallback to 0 if null
                        final amount = price * qty;
                        print('amount:$amount');

                        return _buildItemRow(
                          item['name'],
                          price.toString(), // Ensure it's a string
                          qty.toString(), // Ensure it's a string
                          '0.0',
                          amount.toString(), // Convert result to string
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(),
                  _buildSummaryRow('Sub Total', total),
                  _buildSummaryRow('Tax', tax),
                  _buildSummaryRow('Round Off', total.round().toDouble()),
                  Divider(),
                  _buildSummaryRow('Total', total, isTotal: true),
                ],
              ),
            ),
          ),

          // Right Section
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 48),
                        SizedBox(height: 10),
                        Text('Billed Successfully',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRightRow('Order Number', 'CTR362'),
                  _buildRightRow('Bill Number', 'SI178'),
                  Divider(),
                  _buildRightRow('Payment Summary', ''),
                  _buildRightRow('Cash', '₹1,407.00'),
                  _buildRightRow('Total amount paid', '₹1,407.00'),
                  _buildRightRow('Remaining amount', '₹0.00'),
                  Divider(),
                  _buildRightRow('Customer Info', ''),
                  Text('Mr. Deepak Rajkumar',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('No. 30/21, Winston Apartments, Chennai - 600038'),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Generate Invoice as PDF'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48)),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('New Sale'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(
      String name, String price, String qty, String disc, String amount,
      {bool isOffer = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2, child: Text(name)),
              Expanded(child: Text(price, textAlign: TextAlign.center)),
              Expanded(child: Text(qty, textAlign: TextAlign.center)),
              Expanded(child: Text(disc, textAlign: TextAlign.center)),
              Expanded(child: Text(amount, textAlign: TextAlign.right)),
            ],
          ),
          /*  if (isOffer)
            Text('Weekend Offer',
                style: TextStyle(color: Colors.orange, fontSize: 12)),*/
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value.toString(),
              style: TextStyle(
                  fontSize: isTotal ? 18 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildRightRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          if (value.isNotEmpty) Text(value),
        ],
      ),
    );
  }
}
/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Summary'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items Table
                    Text(
                      'Cart Items',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: const {
                        0: FlexColumnWidth(0.5),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                      },
                      children: [
                        // Table Header
                        TableRow(
                          decoration:
                              BoxDecoration(color: Colors.blueGrey[100]),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('No',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Name',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Price',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Qty',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Amount',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        // Cart Items
                        ...cartItems.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final item = entry.value;
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(index.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['name']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '₹${item['price'].toStringAsFixed(2)}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['quantity'].toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Payment Summary
                Text(
                  'Payment Summary',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal:'),
                    Text('₹${subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tax:'),
                    Text('₹${tax.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:'),
                    Text(
                      '₹${total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Customer Info
                Text(
                  'Customer Info',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text('Name: $customerName'),
                Text('Contact: $customerContact'),
                Text('Address: $customerAddress'),

                const SizedBox(height: 20),

                // Generate Invoice Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('PDF'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('XPS'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Print'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      /*  body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items Table
                    Text(
                      'Cart Items',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: const {
                        0: FlexColumnWidth(0.5),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                      },
                      children: [
                        // Table Header
                        TableRow(
                          decoration:
                              BoxDecoration(color: Colors.blueGrey[100]),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('No',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Name',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Price',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Qty',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Amount',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        // Cart Items
                        ...cartItems.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final item = entry.value;
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(index.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['name']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '₹${item['price'].toStringAsFixed(2)}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['quantity'].toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Payment Summary
                    Text(
                      'Payment Summary',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text('₹${subtotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tax:'),
                        Text('₹${tax.toStringAsFixed(2)}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:'),
                        Text(
                          '₹${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Customer Info
                    Text(
                      'Customer Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text('Name: $customerName'),
                    Text('Contact: $customerContact'),
                    Text('Address: $customerAddress'),

                    const SizedBox(height: 20),

                    // Generate Invoice Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('PDF'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('XPS'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Print'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // New Sale Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('New Sale'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
   */
    );
  }*/
