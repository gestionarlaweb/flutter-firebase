import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

// Obtenemos una cópia del producto
  Product product;
  ProductFormProvider(this.product);

  // Para el check de disponible o no
  updateAvailability(bool value) {
    this.product.available = value;
    notifyListeners(); // Para redibujar
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);
    // Si es valido devuelve true sinó ?? false
    return formKey.currentState?.validate() ?? false;
  }
}
