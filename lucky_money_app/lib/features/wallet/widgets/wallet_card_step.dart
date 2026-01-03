import 'package:flutter/material.dart';

class WalletStepCard extends StatelessWidget {
  const WalletStepCard({
    super.key,
    required this.stepNum,
    required this.stepLabel,
    required this.stepDescription,
    required this.stepContent,
  });
  final String stepLabel;
  final String stepNum;
  final String stepDescription;
  final Widget stepContent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          stepLabel,
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.surface.withValues(alpha: .8),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Text(stepNum, style: theme.textTheme.labelLarge),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        stepDescription,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onPrimary.withValues(
                            alpha: .9,
                          ),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    stepContent,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
