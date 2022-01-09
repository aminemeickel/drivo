import 'package:drivo/component/navigation_bar.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  static const id = '/orders';
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const AppNavigationBar(position: 1),
      body: const Center(
        child: Text('Orders'),
      ),
    );
  }
}
