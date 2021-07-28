import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 450,
          child: Opacity(
            opacity: 0.9,
            child: ClipRRect(
              borderRadius: _borderRadiusTargetGeneral(),
              child: this.url != null
                  ? FadeInImage(
                      image: NetworkImage(this.url!),
                      placeholder: AssetImage('assets/images/jar-loading.gif'),
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: AssetImage('assets/images/no-image.png'),
                      fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
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
