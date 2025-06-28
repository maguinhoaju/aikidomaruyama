import 'package:flutter_test/flutter_test.dart';
import 'package:aikidomaruyama/models/activity_model.dart';
import 'package:aikidomaruyama/enums/periodo_dia.dart';
import 'package:aikidomaruyama/enums/tipo_treino.dart';

void main() {
  group('Activity Model', () {
    test('toMap converte corretamente para Map', () {
      final activity = Activity(
        id: '123',
        date: DateTime.parse('2025-06-28T10:00:00.000'),
        periodoDoDia: PeriodoDoDia.manha,
        tipoTreino: TipoTreino.kids,
        latitude: -23.55,
        longitude: -46.63,
      );

      final map = activity.toMap();

      expect(map['id'], '123');
      expect(map['date'], '2025-06-28T10:00:00.000');
      expect(map['periodoDoDia'], 'Manhã');
      expect(map['tipoTreino'], 'Kids');
      expect(map['latitude'], -23.55);
      expect(map['longitude'], -46.63);
    });

    test('deve converter corretamente fromMap de Map', () {
      final map = {
        "date": "2025-06-28T10:00:00.000",
        "periodoDoDia": "Noite",
        "tipoTreino": "Yudansha",
        "latitude": -12.0,
        "longitude": -34.0,
      };

      final activity = Activity.fromMap(map, 'abc');

      expect(activity.id, 'abc');
      expect(activity.date, DateTime.parse("2025-06-28T10:00:00.000"));
      expect(activity.periodoDoDia, PeriodoDoDia.noite);
      expect(activity.tipoTreino, TipoTreino.yudansha);
      expect(activity.latitude, -12.0);
      expect(activity.longitude, -34.0);
    });

    test('fromMap com campos nulos de latitude/longitude', () {
      final map = {
        "date": "2025-01-01T08:00:00.000",
        "periodoDoDia": "Manhã",
        "tipoTreino": "Graduado",
        "latitude": null,
        "longitude": null,
      };

      final activity = Activity.fromMap(map, '001');

      expect(activity.latitude, isNull);
      expect(activity.longitude, isNull);
    });

    test('fromMap com valores inválidos usa fallback dos enums', () {
      final map = {
        "date": "2025-01-01T08:00:00.000",
        "periodoDoDia": "Inexistente",
        "tipoTreino": "OutroTreino",
      };

      final activity = Activity.fromMap(map, '002');

      expect(activity.periodoDoDia, PeriodoDoDia.tarde);
      expect(activity.tipoTreino, TipoTreino.normal);
    });

    test('Conversão toMap + fromMap deve ser reversível', () {
      final original = Activity(
        id: 'xyz',
        date: DateTime(2025, 6, 28, 15, 30),
        periodoDoDia: PeriodoDoDia.noite,
        tipoTreino: TipoTreino.graduado,
        latitude: 11.11,
        longitude: 22.22,
      );

      final map = original.toMap();
      final restored = Activity.fromMap(map, map['id']);

      expect(restored.id, original.id);
      expect(restored.date.toIso8601String(), original.date.toIso8601String());
      expect(restored.periodoDoDia, original.periodoDoDia);
      expect(restored.tipoTreino, original.tipoTreino);
      expect(restored.latitude, original.latitude);
      expect(restored.longitude, original.longitude);
    });
  });
}
