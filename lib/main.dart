import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => AuthService())
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
      initialRoute: 'login',
      routes: {
        'checking': (_) => CheckAuthScreen(),
        'home': (_) => HomeScreen(),
        'product': (_) => ProductScreen(),
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
      },
      // NotificationsService no neceito instancialo porque es Static
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(color: Colors.blueGrey, elevation: 0),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey),
      ),
    );
  }
}
