import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/frase_model.dart';

// Tradução com a API pública do Google Translate (não-oficial)
Future<String> traduzirTextoGoogle(String textoIngles) async {
  final uri = Uri.parse(
    'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=pt&dt=t&q=${Uri.encodeComponent(textoIngles)}',
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse[0][0][0];
  } else {
    throw Exception('Erro ao traduzir com Google Translate');
  }
}

// Busca uma citação em inglês e traduz para português
Future<Frase> fetchTranslatedQuote() async {
  // Buscar frase em inglês da ZenQuotes
  final zenResponse = await http.get(
    Uri.parse('https://zenquotes.io/api/random'),
  );

  print(
    'Erro ao buscar frase da ZenQuotes: ${zenResponse.statusCode} - ${zenResponse.body}',
  );

  if (zenResponse.statusCode != 200) {
    throw Exception('Erro ao buscar frase da ZenQuotes');
  }

  final zenJson = json.decode(zenResponse.body);
  final originalText = zenJson[0]['q'];
  final author = zenJson[0]['a'];

  // Traduzir para português
  final translatedText = await traduzirTextoGoogle(originalText);

  return Frase(
    originalText: originalText,
    translatedText: translatedText,
    author: author,
  );
}
