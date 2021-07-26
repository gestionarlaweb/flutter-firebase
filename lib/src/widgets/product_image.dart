import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 450,
          child: ClipRRect(
            borderRadius: _borderRadiusTargetGeneral(),
            child: FadeInImage(
              image: NetworkImage('https://via.placeholder.com/400x300/green'),
              placeholder: AssetImage('assets/images/jar-loading.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: _borderRadiusTargetGeneral(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      );
}

BorderRadius _borderRadiusTargetGeneral() {
  return BorderRadius.only(
      topLeft: Radius.circular(45), topRight: Radius.circular(45));
}
