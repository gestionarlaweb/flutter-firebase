/*
               validator: (value) {
                    return utils.isNumeric(value) ? null : 'invalid number';},
.....

bool isNumeric(String s) {
  return num.tryParse(s) != null;
}
*/

String? validateEmail(value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value ?? '') ? null : 'Email no valido';
}

String? validatePassword(value) {
  return (value != null && value.length >= 6)
      ? null
      : 'El password debe de tener 6 caracteres mínimo';
}
