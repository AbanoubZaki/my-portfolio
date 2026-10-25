import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      background: AppColors.bgSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: context.tr('Key Achievements', 'Wichtige Erfolge'),
              title: context.tr('Recognition along the way', 'Auszeichnungen'),
              accent: AppColors.yellow,
            ),
          ),
          const SizedBox(height: 48),
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: _Achievement(
                emoji: '🌍',
                title: 'Google DSC Solution Challenge 2020',
                body: context.tr(
                  'Top 13 teams in MENA, with the ResQ app.',
                  'Unter den Top 13 Teams der MENA-Region, mit der ResQ-App.',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Achievement extends StatelessWidget {
  const _Achievement({required this.emoji, required this.title, required this.body});
  final String emoji;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.01,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hovered ? AppColors.borderStrong : AppColors.border,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.bodyStrong(16)),
                  const SizedBox(height: 4),
                  Text(body, style: AppText.body(14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
