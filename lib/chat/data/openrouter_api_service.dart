import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenRouterAPIService {
  final String apiKey;

  OpenRouterAPIService({required this.apiKey});

  Future<String> sendMessage(String content) async {
    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-4o-mini", // <-- Modèle corrigé, valide sur OpenRouter
        "messages": [
          {"role": "user", "content": content}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception("Erreur OpenRouter: ${response.body}");
    }
  }
}
