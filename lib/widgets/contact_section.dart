import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';

const String kGitHubUrl = 'https://github.com/abanoub4055';
const String kLinkedInUrl = 'https://www.linkedin.com/in/abanoub-michael';
const String kEmail = 'abanoub4055@gmail.com';
const String kPhone = '+49 152 1453 5320';
const String kPhoneTel = 'tel:+4915214535320';

// Served as a static file from web/. Drop the PDF at web/resume.pdf.
const String kResumeUrl = 'resume.pdf';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      background: AppColors.bgSection,
      child: Reveal(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SectionHeader(
                  eyebrow: context.tr('Contact', 'Kontakt'),
                  title: context.tr("Let's Work Together", 'Lassen Sie uns zusammenarbeiten'),
                  accent: AppColors.orange,
                  center: true,
                ),
                const SizedBox(height: 18),
                Text(
                  context.tr(
                    "Have a project in mind or a role to fill? I'm always open to "
                        "discussing new opportunities, collaborations, and ideas.",
                    'Haben Sie ein Projekt im Kopf oder eine Stelle zu besetzen? Ich bin '
                        'jederzeit offen für neue Möglichkeiten, Kooperationen und Ideen.',
                  ),
                  textAlign: TextAlign.center,
                  style: AppText.body(16),
                ),
                const SizedBox(height: 32),
                _EmailLink(),
                const SizedBox(height: 16),
                Text(
                  context.tr(
                    '📍 Kornwestheim, Baden-Württemberg, Germany · $kPhone',
                    '📍 Kornwestheim, Baden-Württemberg, Deutschland · $kPhone',
                  ),
                  textAlign: TextAlign.center,
                  style: AppText.body(14.5),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    const _LinkButton(
                      iconAsset: 'assets/images/github.png',
                      invertAsset: true,
                      label: 'GitHub',
                      url: kGitHubUrl,
                    ),
                    const _LinkButton(
                      iconAsset: 'assets/images/linkedin.png',
                      assetSize: 26,
                      label: 'LinkedIn',
                      url: kLinkedInUrl,
                    ),
                    _LinkButton(
                      icon: Icons.phone,
                      label: context.tr('Call Me', 'Anrufen'),
                      url: kPhoneTel,
                    ),
                    _LinkButton(
                      icon: Icons.download,
                      label: context.tr('Download CV', 'Lebenslauf'),
                      url: kResumeUrl,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailLink extends StatefulWidget {
  @override
  State<_EmailLink> createState() => _EmailLinkState();
}

class _EmailLinkState extends State<_EmailLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Semantics(
        button: true,
        label: 'Email $kEmail',
        child: GestureDetector(
        onTap: () => openUrl('mailto:$kEmail'),
        child: Text(
          kEmail,
          textAlign: TextAlign.center,
          style: AppText.heroName(isMobile ? 20 : 28).copyWith(
            color: AppColors.orange,
            decoration: _hovered ? TextDecoration.underline : TextDecoration.none,
            decorationColor: AppColors.orange,
          ),
        ),
      ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    this.icon,
    this.iconAsset,
    this.invertAsset = false,
    this.assetSize = 20,
    required this.label,
    required this.url,
  }) : assert(icon != null || iconAsset != null, 'Provide icon or iconAsset');

  final IconData? icon;
  final String? iconAsset;

  /// Invert the asset's colors (e.g. a dark logo that vanishes on the dark card).
  final bool invertAsset;

  /// Rendered size of [iconAsset]; lets logos with built-in padding match visually.
  final double assetSize;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.05,
      builder: (context, hovered) => Semantics(
        button: true,
        label: label,
        child: GestureDetector(
        onTap: () => openUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: hovered ? AppColors.orange.withValues(alpha: 0.6) : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconAsset != null)
                _AssetIcon(asset: iconAsset!, invert: invertAsset, size: assetSize)
              else
                Icon(icon, size: 18, color: AppColors.textPrimary),
              const SizedBox(width: 10),
              Text(label, style: AppText.bodyStrong(15)),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

/// A 20px logo image, optionally rendered with inverted colors so a dark logo
/// stays visible on the dark card.
class _AssetIcon extends StatelessWidget {
  const _AssetIcon({required this.asset, this.invert = false, this.size = 20});

  final String asset;
  final bool invert;
  final double size;

  // Inverts RGB channels while preserving alpha.
  static const List<double> _invertMatrix = <double>[
    -1, 0, 0, 0, 255, //
    0, -1, 0, 0, 255, //
    0, 0, -1, 0, 255, //
    0, 0, 0, 1, 0, //
  ];

  @override
  Widget build(BuildContext context) {
    final image =
        Image.asset(asset, width: size, height: size, fit: BoxFit.contain);
    if (!invert) return image;
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(_invertMatrix),
      child: image,
    );
  }
}
