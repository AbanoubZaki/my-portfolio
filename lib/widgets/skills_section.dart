import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import 'common.dart';

class _SkillCategory {
  const _SkillCategory(this.label, this.color, this.skills);
  final L label;
  final Color color;
  final List<L> skills;
}

const List<_SkillCategory> _categories = [
  _SkillCategory(
      L('AI-Assisted Development', 'KI-gestützte Entwicklung'), AppColors.teal, [
    L('Claude Code', 'Claude Code'),
    L('AI Coding Agents', 'KI-Coding-Agenten'),
    L('AI Pair Programming', 'KI-Pair-Programming'),
    L('Prompt Engineering', 'Prompt Engineering'),
    L('AI-Assisted Workflows', 'KI-gestützte Workflows'),
  ]),
  _SkillCategory(L('Flutter & Dart', 'Flutter & Dart'), AppColors.pink, [
    L('Flutter', 'Flutter'), L('Dart', 'Dart'), L('BloC', 'BloC'),
    L('Riverpod', 'Riverpod'), L('Provider', 'Provider'), L('Cubit', 'Cubit'),
    L('Flutter Web', 'Flutter Web'), L('Flutter Flavors', 'Flutter Flavors'),
  ]),
  _SkillCategory(L('iOS Development', 'iOS-Entwicklung'), AppColors.purple, [
    L('Swift', 'Swift'), L('SwiftUI', 'SwiftUI'), L('VIPER', 'VIPER'),
    L('MVVM', 'MVVM'), L('ARKit', 'ARKit'), L('VoIP', 'VoIP'),
  ]),
  _SkillCategory(L('Architecture & Patterns', 'Architektur & Muster'), AppColors.yellow, [
    L('Clean Architecture', 'Clean Architecture'), L('MVVM', 'MVVM'), L('MVC', 'MVC'),
    L('RESTful APIs', 'RESTful APIs'), L('OOP', 'OOP'),
    L('Data Structures', 'Datenstrukturen'), L('Algorithms', 'Algorithmen'),
  ]),
  _SkillCategory(L('Tools & Infrastructure', 'Tools & Infrastruktur'), AppColors.orange, [
    L('Firebase', 'Firebase'), L('Git', 'Git'), L('CI/CD', 'CI/CD'),
    L('Codemagic', 'Codemagic'), L('SQLite', 'SQLite'), L('Google Maps API', 'Google Maps API'),
  ]),
  _SkillCategory(L('Soft Skills', 'Soft Skills'), AppColors.pink, [
    L('Leadership', 'Führung'), L('Problem-Solving', 'Problemlösung'),
    L('Collaboration', 'Zusammenarbeit'), L('Time Management', 'Zeitmanagement'),
    L('Team Management', 'Teammanagement'), L('Communication', 'Kommunikation'),
  ]),
];

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width > Responsive.desktop
        ? 3
        : width >= Responsive.tablet
            ? 2
            : 1;

    return SectionContainer(
      background: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: context.tr('Skills', 'Fähigkeiten'),
              title: context.tr('The toolbox', 'Der Werkzeugkasten'),
              accent: AppColors.orange,
            ),
          ),
          const SizedBox(height: 48),
          EqualHeightGrid(
            columns: columns,
            children: [
              for (var i = 0; i < _categories.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 80 * i),
                  child: _SkillCard(category: _categories[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.category});
  final _SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.02,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hovered ? category.color.withValues(alpha: 0.5) : AppColors.border,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: category.color.withValues(alpha: 0.16),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.label.of(context).toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: category.color,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final s in category.skills)
                  TagChip(label: s.of(context), color: category.color, filled: hovered),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
