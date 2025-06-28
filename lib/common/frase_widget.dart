import 'package:flutter/material.dart';
import '../models/frase_model.dart';
import '../services/frase_service.dart';

class FraseWidget extends StatelessWidget {
  const FraseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Frase>(
      future: fetchTranslatedQuote(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Erro ao carregar a frase: ${snapshot.error}');
          return Text('');
        } else if (snapshot.hasData) {
          final quote = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '"${quote.translatedText}"',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 3),
              Text(
                '- ${quote.author}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}
