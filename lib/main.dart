import 'package:flutter/material.dart';
import 'package:productos_app_firebase/src/providers/product_form_provider.dart';
import 'package:productos_app_firebase/src/screens/screens.dart';
import 'package:productos_app_firebase/src/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos Firebase',
      initialRoute: 'home',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'product': (_) => ProductScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(color: Colors.blueGrey, elevation: 0),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey),
      ),
    );
  }
}
