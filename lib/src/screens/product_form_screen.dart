import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app_firebase/src/providers/product_form_provider.dart';
import 'package:productos_app_firebase/src/ui_widgets/input_decorations.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          // En caso de no ser valido el campo le quita el texto del 'hintText'
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10.0),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del producto', labelText: 'Nombre:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  // import 'package:flutter/services.dart';
                  // obliga a que solo sean números con un máximo de 2 decimales
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  product.price =
                      double.tryParse(value) == null ? 0 : double.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '\$150', labelText: 'Precio:'),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: product.available,
                title: Text('Disponibilidad'),
                activeColor: Colors.indigo,
                onChanged: (value) => productForm.updateAvailability(value),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5)
        ],
      );
}
