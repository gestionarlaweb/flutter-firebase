import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/providers/login_form_provider.dart';
import 'package:productos_app_firebase/src/services/services.dart';
import 'package:productos_app_firebase/src/utils/validators.dart';
import 'package:provider/provider.dart';
import 'package:productos_app_firebase/src/ui_widgets/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.greenAccent,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Envolverlo con el Provider
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inicializar el Provider
    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Container(
      color: Colors.white60,
      child: Form(
        // Key desde provider
        key: loginFormProvider.formKey,

        // Autovalidaciones
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            SizedBox(
              height: 35.0,
            ),
            Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Email
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'nombreCorreo@gmail.com',
                        labelText: 'Email',
                        prefixIcon: Icons.alternate_email_rounded),
                    onChanged: (value) => loginFormProvider.email = value,
                    validator: validateEmail,
                    style: TextStyle(fontSize: 14.0),
                  ),

                  // Password
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecorations.authInputDecoration(
                      hintText: '*******',
                      labelText: 'Password',
                      prefixIcon: Icons.lock_sharp,
                    ),
                    style: TextStyle(fontSize: 14.0),
                    onChanged: (value) => loginFormProvider.password = value,
                    validator: validatePassword,
                  ),
                  // Button
                  SizedBox(
                    height: 10.0,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.deepPurple,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12),
                          child: Text(
                            // Provider
                            loginFormProvider.isLoading ? 'Espere' : 'Ingresar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // Provider
                      onPressed: loginFormProvider.isLoading
                          ? null
                          : () async {
                              // Quitar el teclado
                              FocusScope.of(context).unfocus();
                              // Instanaciar el AuthService Provider
                              // listen :false porque no puedes estar escuchando dentro de un método
                              final authService = Provider.of<AuthService>(
                                  context,
                                  listen: false);

                              // Si no es valido no hagas nada, Return
                              if (!loginFormProvider.isValidForm()) return;
                              // Si es valido lo pasar a true
                              loginFormProvider.isLoading = true;

                              // Validar si el Token es correcto
                              final String? errorMessage =
                                  await authService.createUSer(
                                      loginFormProvider.email,
                                      loginFormProvider.password);

                              // Si es null todo correcto
                              if (errorMessage == null) {
                                Navigator.pushReplacementNamed(context, 'home');
                              } else {
                                // Mostrar error en pantalla
                                print(errorMessage);
                                NotificationsService.showSnackbar(
                                    'El email ya existe !');
                                loginFormProvider.isLoading = false;
                              }
                            }),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Text('Ya tienes cuenta ? Logeate.',
                  style: TextStyle(fontSize: 14, color: Colors.deepPurple)),
            ),
          ],
        ),
      ),
    );
  }
}
