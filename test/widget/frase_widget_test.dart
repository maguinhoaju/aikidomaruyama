import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aikidomaruyama/common/frase_widget.dart';
import 'package:aikidomaruyama/services/frase_service.dart';
import 'package:aikidomaruyama/models/frase_model.dart';

void main() {
  setUp(() {
    fetchTranslatedQuote = _fakeDefault;
  });

  testWidgets('Exibe frase traduzida e autor ao concluir com sucesso', (
    WidgetTester tester,
  ) async {
    fetchTranslatedQuote =
        () async => Frase(
          translatedText: 'A persistência é o caminho do êxito.',
          author: 'Charles Chaplin',
          originalText: 'Perseverance is the path to success.',
        );

    await tester.pumpWidget(const MaterialApp(home: FraseWidget()));

    await tester.pumpAndSettle();

    expect(find.text('"A persistência é o caminho do êxito."'), findsOneWidget);
    expect(find.text('- Charles Chaplin'), findsOneWidget);
  });

  testWidgets('Exibe mensagem de erro se a função lançar uma exceção', (
    WidgetTester tester,
  ) async {
    fetchTranslatedQuote = () async => throw Exception('Erro simulado');

    await tester.pumpWidget(const MaterialApp(home: FraseWidget()));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Erro: Exception: Erro simulado'),
      findsOneWidget,
    );
  });
}

/// Fallback da função (restauração segura)
Future<Frase> _fakeDefault() async => Frase(
  translatedText: 'Texto padrão',
  author: 'Desconhecido',
  originalText: 'Texto original',
);
