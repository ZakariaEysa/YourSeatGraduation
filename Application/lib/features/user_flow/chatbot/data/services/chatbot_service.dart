import 'package:dio/dio.dart';
import '../../../../../core/Network/api_service.dart';
import '../models/chat_message_model.dart';

class ChatbotService {
  final ApiService _apiService = ApiService(dio: Dio());

  Future<Map<String, dynamic>> sendMessage(String message) async {
    try {
      final response = await _apiService.postWithoutToken(
        endPoint: '/recommend',
        body: {'message': message},
      );

      // Check if response is a string (error message)
      if (response.data is String) {
        throw response.data;
      }

      // Check if response has the expected structure
      if (response.data == null || response.data['bot'] == null) {
        throw 'Invalid response format from server';
      }

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChatMessage> getRecommendations(String message) async {
    try {
      final jsonResponse = await sendMessage(message);

      final botMessage = jsonResponse['bot'] as String;

      List<MovieRecommendation> recommendations = [];
      if (jsonResponse['recommendations'] != null) {
        try {
          recommendations = (jsonResponse['recommendations'] as List)
              .map((recommendation) =>
                  MovieRecommendation.fromJson(recommendation))
              .toList();
        } catch (e) {
          // Continue without recommendations if parsing fails
        }
      }

      return ChatMessage(
        message: botMessage,
        type: MessageType.bot,
        recommendations: recommendations,
      );
    } catch (e) {
      final errorMessage = e is String
          ? e
          : 'Sorry, I encountered an error. Please try again later.';
      return ChatMessage(
        message: errorMessage,
        type: MessageType.bot,
      );
    }
  }
}
