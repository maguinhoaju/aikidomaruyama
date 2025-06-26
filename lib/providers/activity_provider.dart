import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import 'package:aikidomaruyama/services/activity_service.dart';

class ActivityProvider extends ChangeNotifier {
  //propriedades privadas
  final ActivityService _activityService;
  Activity? _selectedActivity;
  List<Activity> _activities = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Construtor que recebe o serviço de atividades
  ActivityProvider(this._activityService);

  // Getters para acessar as propriedades
  Activity? get selectedActivity => _selectedActivity;
  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para buscar atividades do serviço
  Future<void> getAll() async {
    _initIsLoading();
    try {
      _activities = await _activityService.getAll();
      _errorMessage =
          null; // Limpa a mensagem de erro se a busca for bem-sucedida
    } catch (e) {
      _errorMessage = 'Erro ao buscar atividades: $e';
    } finally {
      _initIsLoading(false);
    }
  }

  // Método para adicionar uma atividade
  Future<void> add(Activity activity) async {
    //_initIsLoading();
    _isLoading = true;
    try {
      String? id = await _activityService.add(activity);
      if (id != null) {
        activity.id = id;
        _activities.add(activity);
        _errorMessage = null;
      }
    } catch (e) {
      _errorMessage = 'Erro ao adicionar atividade: $e';
    } finally {
      //_initIsLoading(false);
      _isLoading = false;
    }
  }

  // Método para obter uma atividade por id
  Future<Activity?> getById(String id) async {
    _initIsLoading();
    try {
      final activity = await _activityService.getById(id);
      _errorMessage = null;
      return activity;
    } catch (e) {
      _errorMessage = 'Erro ao buscar atividade: $e';
      return null;
    } finally {
      _initIsLoading(false);
    }
  }

  // Método para atualizar uma atividade
  Future<void> update(Activity activity) async {
    _initIsLoading();
    try {
      await _activityService.update(activity);
      final index = _activities.indexWhere((a) => a.id == activity.id);
      if (index != -1) {
        _activities[index] = activity; // Atualiza a atividade na lista
        _errorMessage = null;
      }
    } catch (e) {
      _errorMessage = 'Erro ao atualizar atividade: $e';
    } finally {
      _initIsLoading(false);
    }
  }

  // Método para deletar uma atividade
  Future<void> delete(String id) async {
    _initIsLoading();
    try {
      await _activityService.delete(id);
      _activities.removeWhere((activity) => activity.id == id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao deletar atividade: $e';
    } finally {
      _initIsLoading(false);
    }
  }

  // Mapa para facilitar acesso por data
  Map<DateTime, List<Activity>> get trainingByDate {
    Map<DateTime, List<Activity>> map = {};

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

  List<Activity> get allActivities => _activities;

  // Retorna atividades de um mês específico
  List<Activity> getActivitiesForMonth(int year, int month) {
    return _activities
        .where(
          (activity) =>
              activity.date.year == year && activity.date.month == month,
        )
        .toList();
  }

  // Adiciona uma atividade
  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  // Deleta uma atividade
  void deleteActivity(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  void _initIsLoading([value = true]) {
    _isLoading = value;
    //notifyListeners();
  }
}
