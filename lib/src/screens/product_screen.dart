import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/providers/product_form_provider.dart';
import 'package:productos_app_firebase/src/screens/screens.dart';
import 'package:productos_app_firebase/src/services/products_service.dart';
import 'package:productos_app_firebase/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    // Provider
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // Al hacer scroll se oculta el teclado
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new,
                        size: 40, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: pressedImageButton,
                    icon: Icon(Icons.camera, size: 40, color: Colors.white),
                  ),
                ),
              ],
            ),
            //_ProductForm(),
            ProductFormScreen(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endDocked, // Colocarlo más abajo
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Icon(Icons.save_outlined),
        onPressed: productService.isSaving
            ? null
            : () async {
                // Si no es valido
                if (!productForm.isValidForm()) return;
                // Si es valido
                final String? imageUrl = await productService.uploadImage();
                if (imageUrl != null) productForm.product.picture = imageUrl;
                await productService.saveOrCreateProduct(productForm.product);
              },
      ),
    );
  }

  void pressedImageButton() async {
    final picker = new ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    if (pickedFile == null) {
      print('No hay nada seleccionado');
      return;
    }
    print('Tenemos imagen ${pickedFile.path}');
    productService.updateSelectedProductImage(pickedFile.path);
  }
}
