import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucky_money_app/common/models/history_model.dart';
import 'package:lucky_money_app/common/widgets/error_state.dart';
import 'package:lucky_money_app/features/history/widgets/history_adaptive_view.dart';
import 'package:lucky_money_app/features/history/widgets/history_empty_state.dart';
import 'package:lucky_money_app/features/history/widgets/history_tile.dart';
import 'package:lucky_money_app/features/history/widgets/history_unauthenticated_state.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHistory = ref.watch(getHistoryOperationProvider);
    List<HistoryItem> history = [];

    return asyncHistory.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => HistoryUnauthenticatedState(
        onLoginPressed: () {
          Navigator.pushNamed(context, '/auth-login');
        },
        onRegisterPressed: () {
          Navigator.pushNamed(context, '/auth-register');
        },
      ),
      data: (result) {
        if (!result.isSuccess) {
          if (result.error?.statusCode == 408) {
            return HistoryAdaptiveView(
              child: ErrorState(
                message: result.error!.message,
                statusCode: result.error?.statusCode,
              ),
            );
          }
          return HistoryAdaptiveView(
            child: HistoryUnauthenticatedState(
              onLoginPressed: () {
                Navigator.pushNamed(context, '/auth-login');
              },
              onRegisterPressed: () {
                Navigator.pushNamed(context, '/auth-register');
              },
            ),
          );
        }
        history = result.data!;
        if (history.isEmpty) {
          return HistoryAdaptiveView(
            child: HistoryEmptyState(
              onDepositPressed: () {
                Navigator.pushNamed(context, '/wallet');
              },
            ),
          );
        }
        return ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            return HistoryTile(item: history[index]);
          },
        );
      },
    );
  }
}
