import 'package:aikidomaruyama/routes.dart';
import 'package:aikidomaruyama_auth/aikidomaruyama_auth.dart';
import 'package:flutter/material.dart';
import 'package:aikidomaruyama/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AikidoMaruyamaAuth authProvider = Provider.of<AikidoMaruyamaAuth>(
      context,
      listen: false,
    );
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[700]),
            child: Text(
              'Academia Sergipana de Aikido',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.HOME);
            },
          ),
          ListTile(
            title: const Text(
              "Administração",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.ADMIN);
            },
          ),
          ListTile(
            title: const Text(
              "Perfil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.PROFILE);
            },
          ),
          ListTile(
            title: const Text(
              "Cadastro Complementar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.COMPLETEREGISTER);
            },
          ),
          // Botão de logout no fundo
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () {
              authProvider.logout();
              Navigator.pushNamed(context, Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
