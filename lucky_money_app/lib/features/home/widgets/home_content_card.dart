import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucky_money_app/common/constant/home_strings.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';
import 'package:lucky_money_app/common/widgets/box_shadow.dart';

class HomeContentCard extends StatelessWidget {
  const HomeContentCard({super.key, required this.isAuthenticated});
  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: containerShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(gameLogo, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isAuthenticated
                      ? () {
                          context.push('/my-gane');
                        }
                      : null,
                  child: const Text(homeLabelBtn),
                ),
              ),
            ),
            const Text(homeLabelCard, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
