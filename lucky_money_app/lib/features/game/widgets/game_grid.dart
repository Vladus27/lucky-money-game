import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/models/game/game_model.dart';
import 'package:lucky_money_app/common/models/game/game_state.dart';
import 'package:lucky_money_app/providers/game_provider.dart';

// Модель для стану клітинки
enum CellState {
  hidden, // Закрита
  safe, // Відкрита безпечна (клевер)
  mine, // Бомба (череп)
  animating, // Анімація відкриття
}

class GameGrid extends ConsumerStatefulWidget {
  const GameGrid({super.key});

  @override
  ConsumerState<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends ConsumerState<GameGrid> {
  int? _animatingCell;

  Future<void> _handleCellClick(int position, GameStatus gameStatus) async {
    // Перевіряємо чи гра активна
    if (gameStatus != GameStatus.active) {
      return;
    }

    final gameState = ref.read(gameNotifierProvider).value;
    if (gameState == null || gameState.game == null) return;

    final revealedPositions = gameState.game!.revealedPositions;

    // Перевіряємо чи клітинка вже відкрита
    if (revealedPositions.contains(position)) {
      _showSnackBar('Ця позиція вже відкрита');
      return;
    }

    // Запускаємо анімацію
    setState(() {
      _animatingCell = position;
    });

    // Викликаємо API
    final result = await ref
        .read(gameNotifierProvider.notifier)
        .revealPosition(position);

    // Зупиняємо анімацію
    if (mounted) {
      setState(() {
        _animatingCell = null;
      });
    }

    if (!result.success && mounted) {
      final error = ref.read(gameNotifierProvider).value?.errorMessage;
      if (error != null) {
        _showSnackBar(error);
      }
      return;
    }

    // Перевіряємо чи підірвалися
    if (result.revealBomb?.isBomb == true && mounted) {
      _showSnackBar('💥 Бомба! Ви програли', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  CellState _getCellState(int position, GameState gameState) {
    if (_animatingCell == position) {
      return CellState.animating;
    }

    if (gameState.game == null) {
      return CellState.hidden;
    }

    final game = gameState.game!;
    final revealedPositions = game.revealedPositions;
    final safePositions = gameState.safeRevealedPositions;

    // Якщо гра програна
    if (game.status == GameStatus.lost) {
      // Перевіряємо чи це позиція з бомбою
      if (revealedPositions.contains(position)) {
        return CellState.mine; // Це бомба
      }

      // Показуємо безпечні клітинки які відкрили до програшу
      if (safePositions.contains(position)) {
        return CellState.safe;
      }

      return CellState.hidden;
    }

    // Активна гра - показуємо тільки відкриті безпечні
    if (revealedPositions.contains(position)) {
      return CellState.safe;
    }

    return CellState.hidden;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameState = ref.watch(gameNotifierProvider);

    return gameState.when(
      loading: () => _buildLoadingGrid(theme),
      error: (_, __) => _buildGrid(theme, null, GameStatus.cashedOut),
      data: (state) =>
          _buildGrid(theme, state, state.game?.status ?? GameStatus.cashedOut),
    );
  }

  Widget _buildLoadingGrid(ThemeData theme) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 6,
          color: const Color(0xFFD4AF37), // Золотий колір
        ),
        color: const Color(0xFF1a1a2e),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
      ),
    );
  }

  Widget _buildGrid(ThemeData theme, GameState? gameState, GameStatus status) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 6,
          color: const Color(0xFFD4AF37), // Золотий колір як на картинці
        ),
        color: const Color(0xFF1a1a2e), // Темно-синій фон
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9, // 3x3 сітка
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final cellState = gameState != null
              ? _getCellState(index, gameState)
              : CellState.hidden;

          return _GameCell(
            position: index,
            state: cellState,
            onTap: () => _handleCellClick(index, status),
            isGameActive: status == GameStatus.active,
          );
        },
      ),
    );
  }
}

class _GameCell extends StatefulWidget {
  final int position;
  final CellState state;
  final VoidCallback onTap;
  final bool isGameActive;

  const _GameCell({
    required this.position,
    required this.state,
    required this.onTap,
    required this.isGameActive,
  });

  @override
  State<_GameCell> createState() => _GameCellState();
}

class _GameCellState extends State<_GameCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void didUpdateWidget(_GameCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.state == CellState.safe || widget.state == CellState.mine) &&
        oldWidget.state != widget.state) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.state) {
      case CellState.hidden:
        return const Color(0xFF2d3561); // Темно-синій для закритих
      case CellState.safe:
        return const Color(0xFF1a5c4a); // Темно-зелений для клеверів
      case CellState.mine:
        return const Color(0xFF5c1a1a); // Темно-червоний для черепів
      case CellState.animating:
        return const Color(0xFF3d4575); // Світліший синій при анімації
    }
  }

  Widget _getCellContent() {
    switch (widget.state) {
      case CellState.hidden:
        return const Icon(
          Icons.help_outline,
          color: Color(0xFF4a5580),
          size: 32,
        );
      case CellState.safe:
        // Клевер (можна використати як емодзі або кастомну іконку)
        return const Text('🍀', style: TextStyle(fontSize: 40));
      case CellState.mine:
        // Череп
        return const Text('💀', style: TextStyle(fontSize: 40));
      case CellState.animating:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Color(0xFFD4AF37),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isGameActive ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final isRevealed =
              widget.state == CellState.safe || widget.state == CellState.mine;

          return Transform.scale(
            scale: isRevealed ? _scaleAnimation.value : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _getBackgroundColor(),
                border: Border.all(
                  color: isRevealed
                      ? (widget.state == CellState.safe
                            ? const Color(0xFF2ecc71)
                            : const Color(0xFFe74c3c))
                      : const Color(0xFF3d4575),
                  width: isRevealed ? 3 : 2,
                ),
                boxShadow: [
                  if (widget.state == CellState.safe)
                    BoxShadow(
                      color: const Color(0xFF2ecc71).withValues(alpha: 0.6),
                      blurRadius: 20,
                      spreadRadius: 3,
                    ),
                  if (widget.state == CellState.mine)
                    BoxShadow(
                      color: const Color(0xFFe74c3c).withValues(alpha: 0.6),
                      blurRadius: 20,
                      spreadRadius: 3,
                    ),
                ],
              ),
              alignment: Alignment.center,
              child: child,
            ),
          );
        },
        child: _getCellContent(),
      ),
    );
  }
}
