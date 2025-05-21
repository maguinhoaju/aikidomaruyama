import 'package:aikidomaruyama/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              // ação de logout, como limpar sessão ou redirecionar
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}


/*
    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        children: [
          //Cabeçalho
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[700]),
            child: Text(
              'Academia Sergipana de Aikido',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          //Lista de itens do menu
          Expanded(
            child: ListView(
              children: [
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
              ],
            ),
          ),
          // Botão de logout no fundo
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () {
              // ação de logout, como limpar sessão ou redirecionar
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );






Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  //             _authenticationService.signOut();
                },
              ),
              ListTile(
                title: const Text(
                  "Home",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/homepage');
                },
              ),
              ListTile(
                title: const Text(
                  "Administração",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/adminpage');
                },
              ),
              ListTile(
                title: const Text(
                  "Perfil",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/profilepage');
                },
              ),
              ListTile(
                title: const Text(
                  "Cadastro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/registerpage');
                },
              ),
            ],
          ),
        ),
*/