import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/models/models.dart';
import 'package:productos_app_firebase/src/screens/screens.dart';
import 'package:productos_app_firebase/src/services/services.dart';
import 'package:productos_app_firebase/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return LoadindScreen();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Productos'),
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext _, int index) => GestureDetector(
          onTap: () {
            // Obtener el producto seleccionado
            productsService.selectedProduct =
                productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(
            product: productsService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
