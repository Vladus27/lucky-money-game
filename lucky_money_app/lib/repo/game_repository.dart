import 'package:dio/dio.dart';
import 'package:lucky_money_app/common/models/environment.dart';
import 'package:lucky_money_app/services/secure_storage_service.dart';

class GameRepository {
  final Dio _dio = Dio();
  final String _basicUrl = Environment.apiUrl;
  final storage = SecureStorageService();
}
