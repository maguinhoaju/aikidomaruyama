//authimport 'dart:convert';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? message;
  String? token;
  dynamic body;

  final _url = "https://identitytoolkit.googleapis.com";
  final _resource = "/v1/accounts";
  final _apiKey = "AIzaSyActAMh0_pmCmOAwVGYYVCz6qrxDnGcJbc";

  // Registrar novo usuário
  Future<bool> signUp(String email, String password) async {
    String sUri = '$_url$_resource:signUp?key=$_apiKey';
    Uri uri = Uri.parse(sUri);

    var response = await http.post(
      uri,
      body: {'email': email, 'password': password, 'returnSecureToken': 'true'},
    );

    if (response.statusCode == 200) {
      message = "Usuário cadastrado com sucesso.";
      body = jsonDecode(response.body);
      token = body['idToken'];
      return true;
    } else {
      message = "Erro ao cadastrar Usuário.";
      return false;
    }
  }

  //Log in de usuário cadastrado
  Future<bool> signIn(String email, String password) async {
    String sUri = '$_url$_resource:signInWithPassword?key=$_apiKey';
    Uri uri = Uri.parse(sUri);

    var response = await http.post(
      uri,
      body: {'email': email, 'password': password, 'returnSecureToken': 'true'},
    );

    if (response.statusCode == 200) {
      message = "Usuário autenticado com sucesso.";
      body = jsonDecode(response.body);
      token = body['idToken'];
      return true;
    } else {
      message = 'Falha ao autenticar o Usuário.';
      return false;
    }
  }

  //Encerrar sessão do usuário
  void logout() {
    body = null;
    token = null;
  }
}
