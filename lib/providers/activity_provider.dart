import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../models/mock_activities.dart'; // Importação do mock

class ActivityProvider extends ChangeNotifier {
  final List<ActivityModel> _activities = [];

  /// Mapa para facilitar acesso por data
  Map<DateTime, List<ActivityModel>> get trainingByDate {
    Map<DateTime, List<ActivityModel>> map = {};

    for (var activity in _activities) {
      final date = DateTime(
        activity.date.year,
        activity.date.month,
        activity.date.day,
      );
      map.putIfAbsent(date, () => []);
      map[date]!.add(activity);
    }

    return map;
  }

  List<ActivityModel> get allActivities => _activities;

  // Retorna atividades de um mês específico
  List<ActivityModel> getActivitiesForMonth(int year, int month) {
    return _activities
        .where(
          (activity) =>
              activity.date.year == year && activity.date.month == month,
        )
        .toList();
  }

  // Adiciona uma atividade
  void addActivity(ActivityModel activity) {
    _activities.add(activity);
    notifyListeners();
  }

  // Deleta uma atividade
  void deleteActivity(ActivityModel activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  // Edita uma atividade existente
  void editActivity(ActivityModel oldActivity, ActivityModel updatedActivity) {
    final index = _activities.indexWhere(
      (a) =>
          a.date.year == oldActivity.date.year &&
          a.date.month == oldActivity.date.month &&
          a.date.day == oldActivity.date.day &&
          a.periodoDoDia == oldActivity.periodoDoDia &&
          a.tipoTreino == oldActivity.tipoTreino,
    );

    if (index != -1) {
      _activities[index] = updatedActivity;
      notifyListeners();
    }
  }

  // Inicializa o provider com os dados mockados
  void loadMockActivities() {
    _activities.clear();
    _activities.addAll(mockActivities);
    notifyListeners();
  }

  ActivityProvider() {
    loadMockActivities();
  }
}
