import 'package:aikidomaruyama/screens/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aikidomaruyama/providers/activity_provider.dart';

class ActivitiesPage extends StatelessWidget {
  final DateTime date;

  const ActivitiesPage({required this.date});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivityProvider>();

    // Obtem atividades do dia diretamente do Provider
    final activities =
        provider.allActivities
            .where(
              (activity) =>
                  activity.date.year == date.year &&
                  activity.date.month == date.month &&
                  activity.date.day == date.day,
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atividades - ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ActivityPage(date: date)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body:
          activities.isEmpty
              ? const Center(child: Text('Nenhuma atividade registrada.'))
              : ListView.builder(
                itemCount: activities.length,
                itemBuilder: (_, index) {
                  final activity = activities[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.fitness_center),
                      title: Text(
                        'Tipo de treino: ${activity.tipoTreino.descricao}',
                      ),
                      subtitle: Text(
                        'Turno: ${activity.periodoDoDia.descricao}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ActivityPage(
                                        date: activity.date,
                                        existingActivity: activity,
                                      ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.deleteActivity(activity);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Atividade removida'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
