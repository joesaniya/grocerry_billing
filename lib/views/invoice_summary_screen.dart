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

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  Future<void> generateInvoicePDF() async {
    if (kIsWeb) {
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
        backgroundColor: Colors.blueGrey[900],
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
                    'Zego Mart',
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
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  )),
                              Expanded(
                                  child: Text('price',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.center)),
                              Expanded(
                                  child: Text('Qty',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.center)),
                              Expanded(
                                  child: Text('Disc',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.center)),
                              Expanded(
                                  child: Text('Amount',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
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
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRightRow('Order Number', 'CTR362'),
                  _buildRightRow('Bill Number', 'SI178'),
                  Divider(),
                  Text('Payment Summary',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  buildRightRow('Cash', total),
                  buildRightRow('Total amount paid', total),
                  _buildRightRow('Remaining amount', '0.0'),
                  Divider(),
                  _buildRightRow('Customer Info', ''),
                  Text('Mr. Shinchan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                  Text('No. 5, Tuticorin, Tuticorin - 600008'),
                  Spacer(),
                  Text(
                    'Generate Invoice As',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade100,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () async {
                            await _generateInvoicePDF();
                          },
                          child: const Text(
                            'PDF',
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
                            backgroundColor: Colors.blueGrey.shade100,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () async {
                            await _generateInvoicePDF();
                          },
                          child: const Text(
                            'XPS',
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
                            backgroundColor: Colors.blueGrey.shade100,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () async {
                            await _generateInvoicePDF();
                          },
                          child: const Text(
                            'Print',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('New Sale'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
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
              Expanded(
                  flex: 2,
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w900),
                  )),
              Expanded(
                  child: Text(
                '₹ $price',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              )),
              Expanded(
                  child: Text(
                qty,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              )),
              Expanded(
                  child: Text(
                '₹$disc',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              )),
              Expanded(
                  child: Text(
                '₹ $amount',
                textAlign: TextAlign.right,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              )),
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
          Text(label, style: TextStyle(fontWeight: FontWeight.w900)),
          Text('₹ ${value.toStringAsFixed(2)}'.toString(),
              style: TextStyle(
                  color: isTotal ? Colors.blue : Colors.black,
                  fontWeight: FontWeight.w900
                  /*fontSize: isTotal ? 18 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal*/
                  )),
        ],
      ),
    );
  }

  Widget _buildRightRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
          if (value.isNotEmpty)
            Text(value, style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget buildRightRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text('₹ ${value.toStringAsFixed(2)}'.toString(),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600
                  /*fontSize: isTotal ? 18 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal*/
                  )),
        ],
      ),
    );
  }
}
