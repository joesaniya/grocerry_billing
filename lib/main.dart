import 'package:flutter/material.dart';
import 'package:flutter_bill/views/invoice_screen.dart';

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
