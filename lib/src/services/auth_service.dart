import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app_firebase/src/global/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  // Registro
  // https://firebase.google.com/docs/reference/rest/auth#section-create-email-password

  // Login
  // https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password

  final String _baseUrlGoogle = '${Environment.baseUrlGoogle}';
  final String _firebaseToken = '${Environment.firebaseToken}';

  // flutter_secure_storage para guardar el Token
  final storage = new FlutterSecureStorage();

// REGISTRO
// Si retornamos algo es un error, sinó todo bien !
  Future<String?> createUSer(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrlGoogle, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      // Token guardado y correcto
      // Guardar Token en el Storage
      await storage.write(key: 'keyToken', value: decodedResp['idToken']);

      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

// LOGIN
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrlGoogle, '/v1/accounts:signInWithPassword',
        {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      // Token guardado y correcto
      // Guardar Token en el Storage
      await storage.write(key: 'keyToken', value: decodedResp['idToken']);

      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  // AL CERRAR SESIÓN ELIMINA EL TOKEN
  Future logout() async {
    await storage.delete(key: 'keyToken');
    return;
  }

  // VERIFICAR SI HAY TOKEN PARA CERRAR O NO SESSION
  Future<String> readToken() async {
    return await storage.read(key: 'keyToken') ??
        ''; // Si no exite ?? el token devuelve un String vacío ''
  }
}
