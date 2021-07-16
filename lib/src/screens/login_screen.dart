import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/providers/login_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:productos_app_firebase/src/ui_widgets/input_decorations.dart';

class LoginScreen extends StatelessWidget {
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
            // Image(
            //   image: AssetImage('assets/images/logo.png'),
            //   width: 390.0,
            //   height: 250.0,
            //   alignment: Alignment.center,
            // ),
            // SizedBox(
            //   height: 15.0,
            // ),
            Text(
              'Login',
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
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = new RegExp(pattern);
                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'Email no valido';
                    },
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
                    validator: (value) {
                      return (value != null && value.length >= 6)
                          ? null
                          : 'El password debe de tener 6 caracteres mínimo';
                    },
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
                              // Si no es valido no hagas nada, Return
                              if (!loginFormProvider.isValidForm()) return;
                              // Si es valido lo pasar a true
                              loginFormProvider.isLoading = true;
                              // Simular una espera de 2 segundos
                              await Future.delayed(Duration(seconds: 2));
                              Navigator.pushReplacementNamed(context, 'home');
                            }),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                print('Click');
                //Navigator.pushNamed(context, '/register_screen');
              },
              child: Text('No tienes cuenta ? Registrate.',
                  style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        ),
      ),
    );
  }
}
