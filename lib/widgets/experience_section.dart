import 'package:flutter/material.dart';

import '../data/experience_data.dart';
import '../l10n/l10n.dart';
import '../models/experience.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  // Gradient down the timeline: orange -> purple -> teal.
  static Color _railColor(double t) {
    if (t <= 0.5) {
      return Color.lerp(AppColors.orange, AppColors.purple, t / 0.5)!;
    }
    return Color.lerp(AppColors.purple, AppColors.teal, (t - 0.5) / 0.5)!;
  }

  @override
  Widget build(BuildContext context) {
    final n = kExperiences.length;
    return SectionContainer(
      background: AppColors.bgSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: context.tr('Experience', 'Berufserfahrung'),
              title: context.tr('Where I have shipped', 'Wo ich geliefert habe'),
              accent: AppColors.purple,
            ),
          ),
          const SizedBox(height: 48),
          for (var i = 0; i < n; i++)
            Reveal(
              delay: Duration(milliseconds: 35 * i),
              child: _TimelineItem(
                experience: kExperiences[i],
                topColor: _railColor(i / (n - 1)),
                bottomColor: _railColor((i + 1) / (n - 1)),
                isLast: i == n - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.experience,
    required this.topColor,
    required this.bottomColor,
    required this.isLast,
  });

  final Experience experience;
  final Color topColor;
  final Color bottomColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Stack(
              children: [
                if (!isLast)
                  Positioned(
                    left: 21,
                    top: 10,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [topColor, bottomColor],
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 14,
                  top: 6,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bgSection, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orange.withValues(alpha: 0.5),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, bottom: isLast ? 0 : 32),
              child: _ExperienceCard(experience: experience),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience});
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final e = experience;
    return Hoverable(
      scale: 1.01,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hovered ? AppColors.purple.withValues(alpha: 0.45) : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (e.iconAsset != null) ...[
                  _CompanyIcon(asset: e.iconAsset!, height: e.iconHeight),
                  const SizedBox(width: 12),
                ],
                Flexible(child: _CompanyName(name: e.company, url: e.url)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    e.period.of(context),
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(e.role.of(context), style: AppText.bodyStrong(15.5)),
            const SizedBox(height: 2),
            Text('📍 ${e.location.of(context)}', style: AppText.body(13.5)),
            const SizedBox(height: 16),
            for (final b in e.bullets) _Bullet(text: b.of(context)),
          ],
        ),
      ),
    );
  }
}

class _CompanyIcon extends StatelessWidget {
  const _CompanyIcon({required this.asset, required this.height});
  final String asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Image.asset(
        asset,
        height: height,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (_, _, _) => const SizedBox.shrink(),
      ),
    );
  }
}

class _CompanyName extends StatelessWidget {
  const _CompanyName({required this.name, this.url});
  final String name;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final style = AppText.cardTitle(21);
    if (url == null) {
      return Text(name, style: style);
    }
    return Hoverable(
      scale: 1.0,
      builder: (context, hovered) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Semantics(
          button: true,
          label: '$name website',
          child: GestureDetector(
          onTap: () => openUrl(url!),
          child: Text.rich(
            TextSpan(
              text: name,
              children: [
                const WidgetSpan(child: SizedBox(width: 6)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.north_east,
                    size: 16,
                    color: hovered ? AppColors.orange : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            style: style.copyWith(color: hovered ? AppColors.orange : null),
          ),
        ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text('→ ',
                style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.w700, fontSize: 15)),
          ),
          Expanded(child: Text(text, style: AppText.body(14.5))),
        ],
      ),
    );
  }
}
