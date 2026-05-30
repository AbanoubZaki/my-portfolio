import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final bio = [
      context.tr(
        "I'm a Software Development Engineer specializing in Flutter and native iOS "
            "development, currently based in Kornwestheim, Germany. With over 5 years of "
            "hands-on experience, I've architected and shipped 30+ production "
            "applications used by real users across the globe.",
        'Ich bin Software Development Engineer mit Schwerpunkt auf Flutter und nativer '
            'iOS-Entwicklung und lebe derzeit in Kornwestheim, Deutschland. Mit über 5 Jahren '
            'praktischer Erfahrung habe ich mehr als 30 produktive Anwendungen konzipiert und '
            'veröffentlicht, die von echten Nutzern weltweit verwendet werden.',
      ),
      context.tr(
        "I thrive in challenging environments — whether that's leading a team of 10+ "
            "developers across concurrent projects, reducing infrastructure costs by "
            "30%, or cutting bugs by 75% through rigorous testing practices.",
        'Ich blühe in anspruchsvollen Umfeldern auf – sei es bei der Leitung eines Teams '
            'von über 10 Entwicklern in parallelen Projekten, der Senkung der '
            'Infrastrukturkosten um 30 % oder der Reduzierung von Fehlern um 75 % durch '
            'konsequentes Testen.',
      ),
      context.tr(
        "My technical depth spans clean architecture, state management patterns, "
            "CI/CD pipelines, and cross-platform development. But beyond the code, I "
            "care deeply about user experience, product quality, and team dynamics.",
        'Meine technische Tiefe reicht von Clean Architecture über State-Management-Muster '
            'und CI/CD-Pipelines bis zur plattformübergreifenden Entwicklung. Doch über den '
            'Code hinaus liegen mir Nutzererlebnis, Produktqualität und Teamdynamik sehr am '
            'Herzen.',
      ),
    ];

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in bio) ...[
          Text(p, style: AppText.body(16)),
          const SizedBox(height: 20),
        ],
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _LangPill(
              language: context.tr('Arabic', 'Arabisch'),
              level: context.tr('Native', 'Muttersprache'),
              color: AppColors.teal,
            ),
            _LangPill(
              language: context.tr('English', 'Englisch'),
              level: context.tr('C1 Proficient', 'C1 (Fließend)'),
              color: AppColors.yellow,
            ),
            _LangPill(
              language: context.tr('German', 'Deutsch'),
              level: context.tr('A1 Beginner', 'A1 (Grundkenntnisse)'),
              color: AppColors.purple,
            ),
          ],
        ),
      ],
    );

    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _EducationCard(),
        const SizedBox(height: 20),
        _Achievement(
          emoji: '🥇',
          title: context.tr('1st Place — IRI Hackathon 2019', '1. Platz — IRI Hackathon 2019'),
          body: context.tr(
            'Won first place across Egypt with the Haky Shoyyab app.',
            'Erster Platz in ganz Ägypten mit der App Haky Shoyyab.',
          ),
        ),
        const SizedBox(height: 14),
        _Achievement(
          emoji: '🌍',
          title: 'Google DSC Solution Challenge 2020',
          body: context.tr(
            'Top 13 teams in the MENA region — semi-finals with the ResQ app.',
            'Top-13-Team der MENA-Region — Halbfinale mit der ResQ-App.',
          ),
        ),
        const SizedBox(height: 14),
        _Achievement(
          emoji: '🎓',
          title: context.tr('Vice Class Representative', 'Stellvertretender Klassensprecher'),
          body: context.tr(
            'Alexandria University Faculty of Engineering CSED, 2018–2019.',
            'Universität Alexandria, Fakultät für Ingenieurwesen, CSED, 2018–2019.',
          ),
        ),
      ],
    );

    return SectionContainer(
      background: AppColors.bgSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: context.tr('About', 'Über mich'),
              title: context.tr('Engineering with intent', 'Entwicklung mit Anspruch'),
              accent: AppColors.teal,
            ),
          ),
          const SizedBox(height: 48),
          if (isDesktop)
            Reveal(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: left),
                  const SizedBox(width: 56),
                  Expanded(flex: 5, child: right),
                ],
              ),
            )
          else ...[
            Reveal(child: left),
            const SizedBox(height: 40),
            Reveal(delay: const Duration(milliseconds: 60), child: right),
          ],
        ],
      ),
    );
  }
}

class _LangPill extends StatelessWidget {
  const _LangPill({required this.language, required this.level, required this.color});
  final String language;
  final String level;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Text(language, style: AppText.bodyStrong(14)),
          Text('  ·  $level', style: AppText.body(13.5)),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.01,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hovered ? AppColors.teal.withValues(alpha: 0.5) : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('Alexandria University', 'Universität Alexandria'),
                style: AppText.cardTitle(22)),
            const SizedBox(height: 6),
            Text(
              context.tr('B.S. in Computer and Systems Engineering',
                  'B.Sc. in Computer- und Systemtechnik'),
              style: AppText.body(15),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.teal.withValues(alpha: 0.4)),
              ),
              child: Text(
                context.tr('87.6% — Excellent with Honors', '87,6 % — Sehr gut mit Auszeichnung'),
                style: TextStyle(
                  color: AppColors.teal,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('Sep 2016 – Jun 2021 · Alexandria, Egypt',
                  'Sep. 2016 – Juni 2021 · Alexandria, Ägypten'),
              style: AppText.body(13.5),
            ),
          ],
        ),
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
