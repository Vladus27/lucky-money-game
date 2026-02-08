import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/api_error.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/common/models/game/cashout.dart';
import 'package:lucky_money_app/common/models/game/current_game.dart';
import 'package:lucky_money_app/common/models/game/reveal_bomb.dart';
import 'package:lucky_money_app/services/secure_storage_service.dart';

class GameRepository {
  final Dio _dio = Dio();
  final String _basicUrl = Environment.apiUrl;
  final storage = SecureStorageService();

  Future<Result<String>> gameStart({
    required double betAmount,
    required int minesCount,
  }) async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ви не авторизовані'));
      }
      final response = await _dio.post(
        '$_basicUrl/api/mines-game/start',
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
      return Result.success('Гра успішно почалась');
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

  Future<Result<RevealBomb>> revealPosition({required int positionId}) async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ви не авторизовані'));
      }
      final response = await _dio.post(
        '$_basicUrl/api/mines-game/reveal',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {'positionId': positionId},
      );
      if (response.data['statusCode'] == 30003) {
        return Result.failure(ApiError(message: 'Ця позиція вже відкрита'));
      }
      final responseData = response.data['value'] as Map<String, dynamic>;
      final revealBomb = RevealBomb.fromJson(responseData);
      return Result.success(revealBomb);
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

  Future<Result<Cashout?>> getCashout() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(ApiError(message: 'Ви не авторизовані'));
      }
      final response = await _dio.get(
        '$_basicUrl/api/mines-game/cashout',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (!response.data['isOk']) {
        return Result.failure(ApiError(message: 'сталась бідося'));
      }
      final responseData = response.data['value'];
      if (responseData == null) {
        return Result.success(responseData);
      }
      final cashoutData = Cashout.fromJson(responseData);

      return Result.success(cashoutData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Result.failure(
          ApiError(
            message: 'Ви не авторизовані',
            statusCode: e.response?.statusCode,
          ),
        );
      }
      if (e.response?.statusCode == 404) {
        return Result.failure(
          ApiError(message: 'Гри не знайдено щоб вивести кошти'),
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

  Future<Result<CurrentGame>> getCurrentGame() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Result.failure(
          ApiError(message: 'Ви не авторизовані', statusCode: 401),
        );
      }
      final response = await _dio.get(
        '$_basicUrl/api/mines-game/current',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (!response.data['isOk']) {
        return Result.failure(ApiError(message: 'сталась бідося'));
      }
      final responseData = response.data['value'];
      if (responseData == null) {
        // return Result.success(
        //   CurrentGame(
        //     id: 'id',
        //     betAmount: 0,
        //     createdAt: DateTime.now(),
        //     currentMultiplier: 0,
        //     currentPayoutAmount: 0,
        //     // nextMultiplier: 1,
        //     minesCount: 0,
        //     status: GameStatus.cashedOut,
        //     revealedPositions: {},
        //   ),
        // );

        return Result.failure(
          ApiError(
            message: 'Поточної гри не знайдено',
            statusCode: response.data['statusCode'],
          ),
        );
      }
      final currentGameData = CurrentGame.fromJson(responseData);
      return Result.success(currentGameData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Result.failure(
          ApiError(
            message: 'Ви не авторизовані',
            statusCode: e.response?.statusCode,
          ),
        );
      }
      if (e.response?.statusCode == 404) {
        return Result.failure(ApiError(message: 'Поточної гри не знайдено'));
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
