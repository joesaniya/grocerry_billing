import 'package:flutter/material.dart';
import 'package:flutter_bill/views/invoice_summary_screen.dart';

// This function will be used to show the alert box
void showTotalAmountAlert(BuildContext context, double totalAmount,
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
                      subtotal:
                          totalAmount / 1.1, // Example: subtotal calculation
                      tax: totalAmount -
                          (totalAmount / 1.1), // Example: tax calculation
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
