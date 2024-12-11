import 'package:flutter/material.dart';
import 'package:flutter_bill/views/invoice_summary_screen.dart';
import 'package:flutter/material.dart';

void showTotalAmountAlert(BuildContext context, double totalAmount,
    List<Map<String, dynamic>> cartItems) {
  TextEditingController amountReceivedController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  amountReceivedController.text = totalAmount.toStringAsFixed(2);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      double stillRemaining = 0.0;

      void updateStillRemaining(String value) {
        double received = double.tryParse(value) ?? 0.0;
        stillRemaining = totalAmount - received;
      }

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cash',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '₹${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: amountReceivedController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        updateStillRemaining(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Amount Received',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (double preset in [
                        totalAmount,
                        totalAmount + 3,
                        totalAmount + 10,
                        totalAmount + 20,
                        totalAmount + 30,
                        totalAmount + 50
                      ])
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              amountReceivedController.text =
                                  preset.toStringAsFixed(2);
                              updateStillRemaining(preset.toString());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          child: Text('₹${preset.toStringAsFixed(2)}'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Still Remaining',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '₹${stillRemaining.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceSummaryScreen(
                          cartItems: cartItems,
                          subtotal: totalAmount / 1.1,
                          tax: totalAmount - (totalAmount / 1.1),
                          total: totalAmount,
                          paymentType: 'Cash',
                          customerName: 'Shinchan',
                          customerContact: '9099977778',
                          customerAddress: 'Tuticorin'),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '₹${totalAmount.toStringAsFixed(2)} Item was added!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(
                          top: 50.0, left: 20.0, right: 20.0),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  'Tender',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

void showTotalAmountAlertt(BuildContext context, double totalAmount,
    List<Map<String, dynamic>> cartItems) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Total Amount'),
        content: Text('The total amount is ₹${totalAmount.toStringAsFixed(2)}'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InvoiceSummaryScreen(
                      cartItems: cartItems,
                      subtotal: totalAmount / 1.1,
                      tax: totalAmount - (totalAmount / 1.1),
                      total: totalAmount,
                      paymentType: 'Cash',
                      customerName: 'Shinchan',
                      customerContact: '9099977778',
                      customerAddress: 'Tuticorin'),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '₹${totalAmount.toStringAsFixed(2)} Item was added!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  margin:
                      const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
