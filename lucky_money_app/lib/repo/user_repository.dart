import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/repo/secure_storage_service.dart';

class UserRepository {
  final String _basicUrl = Environment.apiUrl;
  final Dio _dio = Dio();
  final storage = SecureStorageService();

  Future<String?> registerUser({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$_basicUrl/api/auth/register',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'userName': username, 'password': password},
      );

      if (response.data['isOk'] == false) {
        return 'Невірний формат логіну або паролю';
      }

      final accessToken = response.data['value']['token'];
      if (accessToken != null) {
        await storage.saveToken(accessToken);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return 'Недотримався принципів потужного паролю';
      }
      return 'Помилка сервера (${e.response?.statusCode})';
    }
  }

  Future<String?> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$_basicUrl/api/auth/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'userName': username, 'password': password},
      );
      if (response.data['isOk'] == false) {
        return 'Невірний логін або пароль';
      }

      final accessToken = response.data['value']['token'];
      if (accessToken != null) {
        await storage.saveToken(accessToken);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return 'Невірний логін або пароль';
      }
      return 'Помилка сервера (${e.response?.statusCode})';
    }
  }
}
