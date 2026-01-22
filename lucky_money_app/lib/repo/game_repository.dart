import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/api_error.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/services/secure_storage_service.dart';

class GameRepository {
  final Dio _dio = Dio();
  final String _basicUrl = Environment.apiUrl;
  final storage = SecureStorageService();

  Future<Result<String?>> gameStart({
    required double betAmount,
    required int minesCount,
  }) async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ви не авторизовані'));
      }
      final response = await _dio.post(
        '$_basicUrl/api/mines-game/start​',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {'betAmount': betAmount, 'minesCount': minesCount},
      );
      if (response.data['statusCode'] == 30001) {
        return Result.failure(ApiError(message: 'Гра вже почалась'));
      }
      if (response.data['statusCode'] == 30002) {
        return Result.failure(ApiError(message: 'Недостатньо коштів'));
      }
      return Result.success(null);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Result.failure(ApiError(message: 'Ви не авторизовані'));
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
