import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/repo/secure_storage_service.dart';

class UserRepository {
  final String _basicUrl = Environment.apiUrl;
  final Dio dio = Dio();
  final storage = SecureStorageService();

  Future<void> registerUser({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '$_basicUrl/api/auth/register',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'userName': username, 'password': password},
      );

      final accessToken = response.data['value']['token'];
      if (accessToken != null) {
        await storage.saveToken(accessToken);
      }
    } on DioException catch (e) {
      // e.response?.data -> відповідає даним від сервера
      // e.message -> локальне повідомлення про помилку
      throw e.response?.data ?? e.message;
    }
  }

  Future<void> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '$_basicUrl/api/auth/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'userName': username, 'password': password},
      );

      final accessToken = response.data['value']['token'];
      if (accessToken != null) {
        await storage.saveToken(accessToken);
      }
    } on DioException catch (e) {
      // e.response?.data -> відповідає даним від сервера
      // e.message -> локальне повідомлення про помилку
      throw e.response?.data ?? e.message;
    }
  }
}
