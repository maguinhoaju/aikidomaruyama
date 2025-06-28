import 'package:aikidomaruyama/enums/periodo_dia.dart';
import 'package:aikidomaruyama/enums/tipo_treino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  DateTime date;
  PeriodoDoDia periodoDoDia;
  TipoTreino tipoTreino;
  double? latitude;
  double? longitude;

  // Construtor
  Activity({
    required this.id,
    required this.date,
    required this.periodoDoDia,
    required this.tipoTreino,
    this.latitude,
    this.longitude,
  });

  // fromMap
  Activity.fromMap(Map<String, dynamic> map, this.id)
    : date = DateTime.parse(map["date"]),
      periodoDoDia = PeriodoDoDia.fromDescricao(map["periodoDoDia"]),
      tipoTreino = TipoTreino.fromDescricao(map["tipoTreino"]),
      latitude = map["latitude"],
      longitude = map["longitude"];

  // toMap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date.toIso8601String(),
      "periodoDoDia": periodoDoDia.descricao,
      "tipoTreino": tipoTreino.descricao,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
