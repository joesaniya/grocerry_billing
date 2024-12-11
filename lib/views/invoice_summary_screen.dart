import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/foundation.dart' show kIsWeb;

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

  Future<void> _generateInvoicePDF() async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Company: Zylker Family Mart',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text('Customer: $customerName'),
            pw.Text('Contact: $customerContact'),
            pw.Text('Address: $customerAddress'),
            pw.SizedBox(height: 20),
            pw.Text('Items:',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.ListView(
              children: cartItems.map((item) {
                final price = item['price'];
                final qty = item['quantity'];
                final amount = price * qty;

                return pw.Row(
                  children: [
                    pw.Expanded(child: pw.Text(item['name'])),
                    pw.Expanded(child: pw.Text(price.toString())),
                    pw.Expanded(child: pw.Text(qty.toString())),
                    pw.Expanded(child: pw.Text(amount.toString())),
                  ],
                );
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Row(
              children: [
                pw.Expanded(child: pw.Text('Sub Total')),
                pw.Text(total.toString()),
              ],
            ),
            pw.Row(
              children: [
                pw.Expanded(child: pw.Text('Tax')),
                pw.Text(tax.toString()),
              ],
            ),
            pw.Row(
              children: [
                pw.Expanded(child: pw.Text('Total')),
                pw.Text(total.round().toString(),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ],
        );
      },
    ));

    // Show the print dialog or save the file
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  Future<void> generateInvoicePDF() async {
    if (kIsWeb) {
      // Skip printing functionality or show a message that it's not supported in web
      print('Printing is not supported on the web.');
    } else {
      final pdf = pw.Document();

      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Company: Zylker Family Mart',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Customer: Shinchan'),
              pw.Text('Contact: 9087654421'),
              pw.Text('Address: Tuticorin'),
              pw.SizedBox(height: 20),
              pw.Text('Items:',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final price = item['price'];
                  final qty = item['quantity'];
                  final amount = price * qty;

                  return pw.Row(
                    children: [
                      pw.Expanded(child: pw.Text(item['name'])),
                      pw.Expanded(child: pw.Text(price.toString())),
                      pw.Expanded(child: pw.Text(qty.toString())),
                      pw.Expanded(child: pw.Text(amount.toString())),
                    ],
                  );
                },
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Sub Total')),
                  pw.Text(
                    total.toString(),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Tax')),
                  pw.Text(tax.toString()),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Total')),
                  pw.Text(total.round().toString(),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ));

      // Show the print dialog or save the file
      await Printing.layoutPdf(
        onLayout: (format) async => pdf.save(),
      );
    }
  }

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
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.blueGrey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 2, child: Text('Name')),
                              Expanded(
                                  child: Text('price',
                                      textAlign: TextAlign.center)),
                              Expanded(
                                  child:
                                      Text('Qty', textAlign: TextAlign.center)),
                              Expanded(
                                  child: Text('Disc',
                                      textAlign: TextAlign.center)),
                              Expanded(
                                  child: Text('Amount',
                                      textAlign: TextAlign.right)),
                            ],
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: cartItems.map((item) {
                            final price = item['price'];
                            final qty = item['quantity'];
                            final amount = price * qty;
                            print('amount:$amount');

                            return _buildItemRow(
                              item['name'],
                              price.toString(),
                              qty.toString(),
                              '0.0',
                              amount.toString(),
                            );
                          }).toList(),
                        ),
                      ],
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
                    onPressed: () async {
                      // Call the method to generate the PDF
                      await _generateInvoicePDF();
                    },
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
