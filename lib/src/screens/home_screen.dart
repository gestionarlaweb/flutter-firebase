import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Productos'),
        ),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext _, int index) => ProductCard(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
