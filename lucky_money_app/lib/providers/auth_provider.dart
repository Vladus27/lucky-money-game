import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/models/api_error.dart';
import 'package:lucky_money_app/common/models/user.dart';
import 'package:lucky_money_app/repo/user_repository.dart';

final userControllerProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userProvider = FutureProvider<Result<User>>((ref) async {
  return ref.read(userControllerProvider).userData();
});

final balanceProvider = FutureProvider<Result<String>>((ref) async {
  return ref.read(userControllerProvider).getBalance();
});
