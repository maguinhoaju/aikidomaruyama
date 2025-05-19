import 'package:aikidomaruyama/common/my_snackbar.dart';
import 'package:aikidomaruyama/components/decoration.dart';
import 'package:aikidomaruyama/screens/admin_page.dart';
//import 'package:aikidomaruyama/providers/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequirementsPage extends StatefulWidget {
  const RequirementsPage({super.key});

  @override
  _RequirementsPageState createState() => _RequirementsPageState();
}

class _RequirementsPageState extends State<RequirementsPage> {
  //  final AuthenticationService _authenticationService = AuthenticationService();

  //final _formKey = GlobalKey<FormState>();
  final _adultWorkoutsController = TextEditingController();
  final _graduateWorkoutsController = TextEditingController();
  final _yudanshaWorkoutsController = TextEditingController();
  final _ukesController = TextEditingController();
  final _yearsController = TextEditingController();
  final _seminarsController = TextEditingController();
  final _evaluationBoardsController = TextEditingController();

  String _graduacaoSelecionada = 'BRANCA'; // Valor padrão

  final List<String> _graduacoes = [
    'BRANCA',
    'AMARELA',
    'ROXA',
    'VERDE',
    'AZUL',
    'MARROM',
    'SHODAN',
    'NIDAN',
    'SANDAN',
    'YODAN',
    'GODAN',
    'ROKUDAN',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _adultWorkoutsController.text =
          (prefs.getString('adult_workouts') ?? '0');
      _graduateWorkoutsController.text =
          (prefs.getString('graduate_workouts') ?? '0');
      _yudanshaWorkoutsController.text =
          (prefs.getString('yudansha_workouts') ?? '0');
      _ukesController.text = (prefs.getString('ukes') ?? '0');
      _yearsController.text = (prefs.getString('years') ?? '0');
      _seminarsController.text = (prefs.getString('seminars') ?? '0');
      _evaluationBoardsController.text =
          (prefs.getString('evaluation_boards') ?? '0');

      // Carregar e definir a graduação, garantindo que seja um valor válido
      final savedGraduacao = prefs.getString('graduacao');
      if (savedGraduacao != null && _graduacoes.contains(savedGraduacao)) {
        _graduacaoSelecionada = savedGraduacao;
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('graduacao', _graduacaoSelecionada);
    await prefs.setString('adult_workouts', _adultWorkoutsController.text);
    await prefs.setString(
      'graduate_workouts',
      _graduateWorkoutsController.text,
    );
    await prefs.setString(
      'yudansha_workouts',
      _yudanshaWorkoutsController.text,
    );
    await prefs.setString('ukes', _ukesController.text);
    await prefs.setString('years', _yearsController.text);
    await prefs.setString('seminars', _seminarsController.text);
    await prefs.setString(
      'evaluation_boards',
      _evaluationBoardsController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    final adultWorkouts = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          showSnackBar(context: context, text: 'Campo Obrigatório!');
          return 'Campo Obrigatório!';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _adultWorkoutsController,
      decoration: getHintTextInputDecoration("Treinos de Adultos"),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
    );

    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Requisitos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  //        _authenticationService.signOut();
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
        body: Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return null;
            },
          ),
        ),
      ),
    );
  }
}
