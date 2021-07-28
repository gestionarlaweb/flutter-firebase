// Peticiones Http con Provider
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/global/environment.dart';
import 'package:productos_app_firebase/src/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = '${Environment.baseUrl}';
  final List<Product> products = [];

  // Cargando o no
  bool isLoading = true;
  // Para Guardar o Crear
  bool isSaving = false;

  // Producto seleccionado
  late Product selectedProduct;

  ProductsService() {
    this.loadProducts();
  }

// Listado de productos
  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
    //print(productsMap);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });
    //print(this.products[0].name);

    this.isLoading = false;
    notifyListeners();
    return this.products;
  }

  // Guardar o Crear los datos
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();
    // Confirmar el id del producto
    if (product.id == null) {
      // Crear producto
      await this.createProduct(product);
    } else {
      // Actualizar
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

// Petición al Backend
// para Actualizar
  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson()); // PUT
    final decodeData = resp.body;

    print(decodeData);

    // Actualizar el listado de productos para que se actualizen en el dispositivo
    // Regresa el indice del producto cuyo id es = id que estoy recibiendo
    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;
    return product.id!;
  }

// Petición al Backend
// para Crear
  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson()); // POST
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];
    //print('${product.id}...product.id');

    this.products.add(product);

    return product.id!;
  }
}
