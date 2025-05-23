import 'package:aikidomaruyama/providers/activity_provider.dart';
import 'package:aikidomaruyama/routes.dart';
import 'package:aikidomaruyama/screens/admin_page.dart';
import 'package:aikidomaruyama/screens/home_page.dart';
import 'package:aikidomaruyama/screens/login_page.dart';
import 'package:aikidomaruyama/screens/profile_page.dart';
import 'package:aikidomaruyama/screens/register_page.dart';
import 'package:aikidomaruyama/screens/complete_register_page.dart';
import 'package:aikidomaruyama/providers/auth_provider.dart';
import 'package:aikidomaruyama/screens/requirements_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ActivityProvider>(
          create: (context) => ActivityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Aikido Maruyama',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routes: {
          Routes.LOGIN: (context) => LoginPage(),
          Routes.HOME: (context) => HomePage(),
          Routes.REGISTER: (context) => RegisterPage(),
          Routes.ADMIN: (context) => AdminPage(),
          Routes.PROFILE: (context) => ProfilePage(),
          Routes.REQUIREMENTS: (context) => RequirementsPage(),
          Routes.COMPLETEREGISTER: (context) => CompleteRegisterPage(),
        },
      ),
    );
  }
}
