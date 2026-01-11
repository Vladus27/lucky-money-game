import 'dart:math';

import 'package:flutter/material.dart';

class ExampleGameScreen extends StatefulWidget {
  const ExampleGameScreen({super.key});

  @override
  State<ExampleGameScreen> createState() => _ExampleGameScreenState();
}

enum GameStatus { betting, playing, ended }

class _ExampleGameScreenState extends State<ExampleGameScreen> {
  double bet = 10.0;
  int minesCount = 3;
  double houseEdge = 0.02;

  GameStatus status = GameStatus.betting;
  List<bool?> grid = List.generate(
    9,
    (_) => null,
  ); // null: приховано, true: безпечно, false: бомба
  List<int> bombPositions = [];
  int openedCount = 0;

  // Математика: Комбінаторика nCr
  double nCr(int n, int r) {
    if (r < 0 || r > n) return 0;
    if (r == 0 || r == n) return 1;
    if (r > n / 2) r = n - r;
    double res = 1;
    for (int i = 1; i <= r; i++) {
      res = res * (n - i + 1) / i;
    }
    return res;
  }

  // Розрахунок множника
  double get currentMultiplier {
    if (openedCount == 0) return 1.0;
    double p = nCr(9 - minesCount, openedCount) / nCr(9, openedCount);
    return (1 - houseEdge) / p;
  }

  double get nextMultiplier {
    double p = nCr(9 - minesCount, openedCount + 1) / nCr(9, openedCount + 1);
    return (1 - houseEdge) / p;
  }

  // Логіка гри
  void startGame() {
    setState(() {
      bombPositions = [];
      var rng = Random();
      while (bombPositions.length < minesCount) {
        int r = rng.nextInt(9);
        if (!bombPositions.contains(r)) bombPositions.add(r);
      }
      grid = List.generate(9, (_) => null);
      openedCount = 0;
      status = GameStatus.playing;
    });
  }

  void handleCellClick(int index) {
    if (status != GameStatus.playing || grid[index] != null) return;

    setState(() {
      if (bombPositions.contains(index)) {
        // Програш
        for (var pos in bombPositions) {
          grid[pos] = false;
        }
        status = GameStatus.ended;
      } else {
        // Безпечно
        grid[index] = true;
        openedCount++;
        if (openedCount == 9 - minesCount) {
          status = GameStatus.ended;
        }
      }
    });
  }

  void cashout() {
    if (status != GameStatus.playing || openedCount == 0) return;
    setState(() {
      for (var pos in bombPositions) {
        if (grid[pos] == null) grid[pos] = false; // Показати невідкриті бомби
      }
      status = GameStatus.ended;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryRed = const Color(0xFFB11226);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header Stats
              Row(
                children: [
                  _buildStatCard(
                    "Множник",
                    "x${currentMultiplier.toStringAsFixed(2)}",
                    Icons.trending_up,
                    primaryRed,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    "Виплата",
                    "${(bet * currentMultiplier).toStringAsFixed(2)}",
                    Icons.account_balance_wallet,
                    Colors.amber,
                  ),
                ],
              ),
              const Spacer(),

              // Game Grid
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Slate 900
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: const Color(0xFF1E293B)),
                  ),
                  child: Stack(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: 9,
                        itemBuilder: (context, i) => _buildCell(i),
                      ),
                      if (status == GameStatus.ended)
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                setState(() => status = GameStatus.betting),
                            icon: const Icon(Icons.refresh),
                            label: const Text(
                              "ЗАНОВО",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Controls Panel
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withOpacity(0.8),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bet Selection
                    _buildLabel("Ставка", "${bet.toInt()} WBT"),
                    Row(
                      children: [10, 50, 100]
                          .map(
                            (val) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ChoiceChip(
                                  label: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text("$val"),
                                  ),
                                  selected: bet == val.toDouble(),
                                  onSelected: status == GameStatus.playing
                                      ? null
                                      : (s) => setState(
                                          () => bet = val.toDouble(),
                                        ),
                                  selectedColor: primaryRed,
                                  backgroundColor: const Color(0xFF020617),
                                  labelStyle: TextStyle(
                                    color: bet == val.toDouble()
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20),

                    // Mines Slider
                    _buildLabel(
                      "Міни",
                      "$minesCount",
                      icon: Icons.settings_suggest,
                    ),
                    Slider(
                      value: minesCount.toDouble(),
                      min: 1,
                      max: 8,
                      divisions: 7,
                      activeColor: primaryRed,
                      inactiveColor: const Color(0xFF020617),
                      onChanged: status == GameStatus.playing
                          ? null
                          : (v) => setState(() => minesCount = v.toInt()),
                    ),
                    const SizedBox(height: 20),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: status == GameStatus.playing
                            ? (openedCount > 0 ? cashout : null)
                            : startGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: status == GameStatus.playing
                              ? Colors.green[700]
                              : primaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                        ),
                        child: Text(
                          status == GameStatus.playing
                              ? "КЕШАУТ (${(bet * currentMultiplier).toStringAsFixed(2)})"
                              : "ГРАТИ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Наступний множник: x${nextMultiplier.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, String val, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) Icon(icon, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                text.toUpperCase(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          Text(
            val,
            style: const TextStyle(
              color: Color(0xFFB11226),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(int index) {
    bool? val = grid[index];
    return GestureDetector(
      onTap: () => handleCellClick(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: val == null
              ? const Color(0xFF1E293B)
              : (val ? Colors.green[600] : const Color(0xFFB11226)),
          boxShadow: val != null
              ? [
                  BoxShadow(
                    color: (val ? Colors.green : const Color(0xFFB11226))
                        .withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: val == null
              ? Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    shape: BoxShape.circle,
                  ),
                )
              : Icon(
                  val ? Icons.shield : Icons.bolt,
                  color: Colors.white,
                  size: 32,
                ),
        ),
      ),
    );
  }
}
