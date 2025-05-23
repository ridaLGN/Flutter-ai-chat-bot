import 'package:flutter/material.dart';
import '../data/openrouter_api_service.dart'; // ✅ changé
import '../model/message.dart';

class ChatProvider with ChangeNotifier {
  // Mets ta clé API OpenRouter ici (commence par org-...)
  final _apiService = OpenRouterAPIService(
    apiKey:
        "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",
  );

  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.sendMessage(content);

      final responseMessage = Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(responseMessage);
    } catch (e) {
      final errorMessage = Message(
        content: 'Error: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(errorMessage);
    }

    _isLoading = false;
    notifyListeners();
  }
}
