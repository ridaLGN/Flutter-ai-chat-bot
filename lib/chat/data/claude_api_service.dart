import 'dart:convert';

import 'package:http/http.dart' as http;
/*

  services  class to handle  all claude api stuff 

*/

class ClaudeAPIService {
  // Function to get the Claude API key from the environment variables
  static const String _baseUrl = 'https://api.anthropic.com/v1/complete';
  static const String _apiVersion = '2025-5-22';
  static const String _model = 'claude-3-opus-20240229';
  static const int _maxTokens = 1024;

// store the api key securly
  final String _apiKey;
//  require API key
  ClaudeAPIService({required String apiKey}) : _apiKey = apiKey;

/* 
send message to api & return the response 

*/

  Future<String> sendMessage(String content) async {
    try {
      // make  Post  request to the API
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _getHeaders(),
        body: _getrequestBody(content),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content']['0']['text'];
      } else {
        throw Exception(
            'Failed to get response from claude API:${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get response from claude API: $e');
    }
  }

  // create required headers
  Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
        'x-api-key': _apiKey,
        'anthropic-version': _apiVersion,
        //  format reaquest body according to claude  Api specs
      };

  String _getrequestBody(String content) => jsonEncode({
        'model': _model,
        'messages': [
          {'role': 'user', 'content': content}
        ],
        'max_tokens': _maxTokens
      });
}
