import 'dart:collection';
import 'dart:io';
import 'package:aikidomaruyama/common/my_drawer.dart';
import 'package:aikidomaruyama/models/practitioner_model.dart';
//import 'package:aikidomaruyama/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../common/utils.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  final AuthenticationService _authenticationService = AuthenticationService();
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  String _nome = '';
  String _fotoPath = '';
  String _graduacao = 'BRANCA';

  final PractitionerModel _practitionerModel = PractitionerModel(
    name: "Carlos Magno de França Veiga",
    adultWorkoutsRequirement: "30",
    adultWorkouts: "12",
    seminarsRequirement: "2",
    seminars: "1",
    ukesRequirement: "1",
    ukes: "1",
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _fotoPath = prefs.getString('fotoPath') ?? '';
      _graduacao = prefs.getString('graduacao') ?? 'BRANCA';
    });
  }

  Color _getGraduacaoColor(String graduacao) {
    switch (graduacao) {
      case 'AMARELA':
        return Colors.yellow;
      case 'ROXA':
        return Colors.purple;
      case 'VERDE':
        return Colors.green;
      case 'AZUL':
        return Colors.blue;
      case 'MARROM':
        return Colors.brown;
      case 'SHODAN':
      case 'NIDAN':
      case 'SANDAN':
      case 'YODAN':
      case 'GODAN':
      case 'ROKUDAN':
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  Color _getTextGraduacaoColor(String graduacao) {
    switch (graduacao) {
      case 'BRANCA':
      case 'AMARELA':
        return Colors.black;
      case 'ROXA':
        return Colors.white;
      case 'VERDE':
      case 'AZUL':
        return Colors.black;
      case 'MARROM':
      case 'SHODAN':
      case 'NIDAN':
      case 'SANDAN':
      case 'YODAN':
      case 'GODAN':
      case 'ROKUDAN':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [for (final d in days) ..._getEventsForDay(d)];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        _fotoPath.isNotEmpty
                            ? FileImage(File(_fotoPath))
                            : null,
                    child:
                        _fotoPath.isEmpty
                            ? const Icon(Icons.person, size: 50)
                            : null,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _nome,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Treinos de Adultos: ${_practitionerModel.adultWorkouts} / ${_practitionerModel.adultWorkoutsRequirement}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Seminários: ${_practitionerModel.seminars} / ${_practitionerModel.seminarsRequirement}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Ukes: ${_practitionerModel.ukes} / ${_practitionerModel.ukesRequirement}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _getGraduacaoColor(_graduacao),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _graduacao,
                  style: TextStyle(
                    color: _getTextGraduacaoColor(_graduacao),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                alignment: Alignment.center,
                height: 32,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  "Registro de Atividades",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                selectedDayPredicate: (day) {
                  // Use values from Set to mark multiple days as selected
                  return _selectedDays.contains(day);
                },
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              ElevatedButton(
                child: const Text('Clear selection'),
                onPressed: () {
                  setState(() {
                    _selectedDays.clear();
                    _selectedEvents.value = [];
                  });
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
