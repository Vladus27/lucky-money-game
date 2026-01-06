import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final double balance = 24;
  double _minCount = 1.0;
  final List<int> bets = [10, 50, 100];
  int? _selectedBet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('data')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(alpha: .8),
                      borderRadius: BorderRadius.circular(12),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     theme.colorScheme.primary,
                      //     theme.colorScheme.onSurface,
                      //     // theme.colorScheme.onSurface.withValues(alpha: 0.9),
                      //   ],
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: .8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Множник'.toUpperCase(),
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text('x10.0', style: theme.textTheme.labelMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.onSecondaryContainer,
                          // theme.colorScheme.onSurface.withValues(alpha: 0.9),
                        ],
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: .8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'виплата'.toUpperCase(),
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text('100.00', style: theme.textTheme.labelMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: BoxBorder.all(
                  width: 8,
                  color: theme.colorScheme.secondary,
                ),
                color: theme.colorScheme.onSurface,
              ),

              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: 9,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 колонки
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1, //  квадрат
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: index == 6
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.surface.withValues(alpha: .1),
                    ),
                    alignment: Alignment.center,

                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 0,
                    blurRadius: .8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _showBottomSheet();
                      },
                      child: Text('налаштувати'.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Наступний множник: x1.47',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      barrierColor: Colors.black.withValues(alpha: 0.9),
      isScrollControlled: true,
      // shape: ShapeBorder,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xfff5f5f5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              top: 14,
              bottom: 32,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ставка'),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Баланс: 300 WBT',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                // color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      Text(
                        '10 WBT',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  StatefulBuilder(
                    builder: (context, setModalState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,s
                            children: bets.map((bet) {
                              final isAvailable = balance >= bet;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: ChoiceChip(
                                    label: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '$bet',
                                        style: TextStyle(
                                          color: _selectedBet == bet
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.surface
                                              : null,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    selected: _selectedBet == bet,
                                    onSelected: isAvailable
                                        ? (bool selected) {
                                            setModalState(() {
                                              _selectedBet = selected
                                                  ? bet
                                                  : null;
                                            });
                                          }
                                        : null, // ❗ disabled
                                    disabledColor: Colors.grey.shade300,
                                    iconTheme: IconThemeData(
                                      color: _selectedBet == bet
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.surface
                                          : null,
                                    ),

                                    selectedColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            // maxLength: 64,
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              icon: const Icon(Icons.password_outlined),
                              hintText: 'Введи свою ставку',
                              labelText: 'Ставка',

                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).colorScheme.surfaceContainer,

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),

                          Slider(
                            min: 1,
                            max: 8,
                            divisions: 7,
                            value: _minCount,
                            label: _minCount.toStringAsFixed(0),
                            onChanged: (double val) {
                              setModalState(() {
                                _minCount = val;
                              });
                            },
                          ),
                          Text(
                            'Кількість мін: ${_minCount.toStringAsFixed(0)}',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ПОЧАТИ ГРУ'),
                    ),
                  ),
                  Text(
                    'Перший множник: x1.47',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
