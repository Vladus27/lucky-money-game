import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/api_error.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/common/models/user.dart';
import 'package:lucky_money_app/services/secure_storage_service.dart';

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

  Future<Result<User>> userData() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ви не авторизовані'));
      }
      final response = await _dio.get(
        "$_basicUrl/api/auth/me",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data["isOk"] == true) {
        final responseData = response.data['value'] as Map<String, dynamic>;
        final user = User.fromJson(responseData);
        return Result.success(user);
      } else {
        return Result.failure(
          ApiError(
            message: 'якась Помилка сервера',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Result.failure(
        ApiError(
          message: 'Помилка сервера',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (_) {
      return Result.failure(ApiError(message: 'Невідома помилка'));
    }
  }

  Future<Result<String>> getBalance() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'не вдалось отримати баланс'));
      }
      final response = await _dio.get(
        "$_basicUrl/api/auth/balance",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data["isOk"] == true) {
        final responseData = response.data['value'];
        return Result.success(responseData.toString());
      } else {
        return Result.failure(
          ApiError(
            message: 'не вдалось отримати баланс',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Result.failure(
        ApiError(
          message: 'Помилка сервера',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (_) {
      return Result.failure(ApiError(message: 'Невідома помилка'));
    }
  }

  Future<Result<String>> setWalletAddressConnect(String address) async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ти не залогінений'));
      }
      final response = await _dio.put(
        "$_basicUrl/api/auth/wallet-address",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'walletAddress': address},
      );
      if (response.data["isOk"] == true) {
        return Result.success('Адресу гаманця успішно встановлено');
      } else {
        return Result.failure(ApiError(message: 'не вдалось задати гаманець'));
      }
    } on DioException catch (e) {
      return Result.failure(
        ApiError(
          message: 'Помилка сервера',
          statusCode: e.response?.statusCode,
        ),
      );
    }
  }

  Future<Result<String?>> getWalletAddressConnect() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ти не залогінений'));
      }
      final response = await _dio.put(
        "$_basicUrl/api/auth/wallet-address",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data["isOk"] == true) {
        final responseData = response.data["value"];

        return Result.success(responseData);
      } else {
        return Result.failure(
          ApiError(message: 'не вдалось отримати гаманець'),
        );
      }
    } on DioException catch (e) {
      return Result.failure(
        ApiError(
          message: 'Помилка сервера',
          statusCode: e.response?.statusCode,
        ),
      );
    }
  }
}
