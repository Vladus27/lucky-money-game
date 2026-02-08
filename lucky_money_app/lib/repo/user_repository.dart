import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/api_error.dart';
import 'package:lucky_money_app/common/models/deposit_model.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/common/models/history_model.dart';
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
      if (response.data["statusCode"] == 20001) {
        return 'Користувач вже є під таким псевдонімом';
      }

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
        return 'Помилка сервера (${e.response?.statusCode}';
      }

      if (e.response == null) {
        return 'Помилка сервера: ${e.message}';
      } else {
        return 'Помилка сервера: ${e.message} статускод: (${e.response?.statusCode})';
      }
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
      if (e.response?.statusCode == 401) {
        storage.deleteToken();
        return Result.failure(
          ApiError(
            message: 'Помилка сервера ${e.response?.statusMessage}',
            statusCode: e.response?.statusCode,
          ),
        );
      }
      return Result.failure(
        ApiError(
          message: 'Помилка сервера ${e.message}',
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
      if (e.response?.statusCode == 401) {
        return Result.failure(
          ApiError(
            message: 'Ви не авторизовані',
            statusCode: e.response?.statusCode,
          ),
        );
      }
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
      if (response.data["statusCode"] == 20001) {
        return Result.failure(
          ApiError(message: 'Данний адрес вже встановлений'),
        );
      }
      if (response.data["isOk"] != true) {
        return Result.failure(
          ApiError(
            message: 'не вдалось задати гаманець',
            statusCode: response.statusCode,
          ),
        );
      }

      return Result.success('Адресу гаманця успішно встановлено');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Result.failure(
          ApiError(
            message: 'Ви не авторизовані',
            statusCode: e.response?.statusCode,
          ),
        );
      }
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
      final response = await _dio.get(
        "$_basicUrl/api/auth/wallet-address",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data["isOk"] == true) {
        final responseData = response.data["value"];

        return Result.success(responseData);
      } else {
        return Result.failure(
          ApiError(
            message: 'не вдалось отримати гаманець',
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
    }
  }

  Future<Result<Deposit>> getDepositData() async {
    try {
      final response = await _dio.get(
        "$_basicUrl/api/crypto-wallet/deposit-address",
      );
      return Result.success(Deposit.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Result.failure(
          ApiError(
            message: 'Ви не авторизовані',
            statusCode: e.response?.statusCode,
          ),
        );
      }
      return Result.failure(
        ApiError(
          message: 'Помилка сервера',
          statusCode: e.response?.statusCode,
        ),
      );
    }
  }

  Future<Result<List<HistoryItem>>> getHistory() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(
          ApiError(message: 'Ти не залогінений', statusCode: 401),
        );
      }
      final response = await _dio.get(
        "$_basicUrl/api/wallet/operations",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data["isOk"] == false) {
        return Result.failure(ApiError(message: 'сталась халепа'));
      }
      final data = response.data as Map<String, dynamic>;
      final value = data['value'] as Map<String, dynamic>;
      final items = value['items'] as List;
      final historyItems = items
          .map<HistoryItem>((e) {
            return HistoryItem.fromJson(e as Map<String, dynamic>);
          })
          .toList()
          .reversed
          .toList();

      return Result.success(historyItems);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return Result.failure(
          ApiError(
            message: "Помилка з'єднання: не виявлено підключення до інтернету",
            statusCode: 408,
          ),
        );
      }
      return Result.failure(
        ApiError(
          message: 'Помилка сервера',
          statusCode: e.response?.statusCode,
        ),
      );
    }
  }
}
