import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../theme/colors.dart';

/// Responsive breakpoint helpers.
class Responsive {
  Responsive._();

  static const double tablet = 768;
  static const double desktop = 1024;
  static const double maxContentWidth = 1180;

  static bool isMobile(BuildContext c) => MediaQuery.sizeOf(c).width < tablet;
  static bool isTablet(BuildContext c) {
    final w = MediaQuery.sizeOf(c).width;
    return w >= tablet && w <= desktop;
  }

  static bool isDesktop(BuildContext c) => MediaQuery.sizeOf(c).width > desktop;

  static double horizontalPadding(BuildContext c) {
    final w = MediaQuery.sizeOf(c).width;
    if (w < tablet) return 20;
    if (w <= desktop) return 40;
    return 64;
  }
}

/// Lays [children] out in rows of [columns], stretching every card in a row
/// to match the tallest card in that row. The last partial row keeps the same
/// column widths via empty placeholders so cards never widen unevenly.
class EqualHeightGrid extends StatelessWidget {
  const EqualHeightGrid({
    super.key,
    required this.columns,
    required this.children,
    this.spacing = 24,
    this.runSpacing = 24,
  });

  final int columns;
  final double spacing;
  final double runSpacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final cols = columns < 1 ? 1 : columns;
    final rows = <Widget>[];

    for (var start = 0; start < children.length; start += cols) {
      final rowCells = <Widget>[];
      for (var i = 0; i < cols; i++) {
        if (i > 0) rowCells.add(SizedBox(width: spacing));
        final idx = start + i;
        rowCells.add(
          Expanded(child: idx < children.length ? children[idx] : const SizedBox()),
        );
      }
      if (rows.isNotEmpty) rows.add(SizedBox(height: runSpacing));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowCells,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

/// Centered, max-width section container with consistent vertical rhythm.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.background,
    this.verticalPadding = 110,
  });

  final Widget child;
  final Color? background;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.horizontalPadding(context);
    final vPad = Responsive.isMobile(context) ? 72.0 : verticalPadding;
    return Container(
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}

/// Fades + slides its child up the first time it scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 22,
  });

  final Widget child;
  final Duration delay;
  final double offsetY;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _shown = false;
  late final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    // Skip the scroll-reveal animation on mobile/tablet — animating opacity +
    // transform on shadow/gradient-heavy cards janks on WebKit. Show instantly.
    if (!Responsive.isDesktop(context)) return widget.child;

    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (!_shown && info.visibleFraction > 0.12 && mounted) {
          setState(() => _shown = true);
        }
      },
      child: _shown
          ? widget.child
              .animate()
              .fadeIn(duration: 180.ms, delay: widget.delay, curve: Curves.easeOut)
              .slideY(
                begin: widget.offsetY / 100,
                end: 0,
                duration: 200.ms,
                delay: widget.delay,
                curve: Curves.easeOutCubic,
              )
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}

/// Section eyebrow + title block.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.accent,
    this.center = false,
  });

  final String eyebrow;
  final String title;
  final Color accent;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final cross = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: cross,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 34 : 46,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -0.5,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// MouseRegion wrapper that scales + reports hover state for borders/colors.
class Hoverable extends StatefulWidget {
  const Hoverable({
    super.key,
    required this.builder,
    this.scale = 1.0,
    this.duration = const Duration(milliseconds: 180),
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final double scale;
  final Duration duration;

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? widget.scale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.builder(context, _hovered),
      ),
    );
  }
}

/// Small rounded chip used for tags, skills, and language pills.
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    this.color,
    this.filled = false,
  });

  final String label;
  final Color? color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: filled ? c.withValues(alpha: 0.14) : AppColors.bg.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: filled ? c.withValues(alpha: 0.45) : AppColors.border,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: filled ? c : AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// Pill-shaped button, filled or outlined, with a hover lift.
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = true,
    this.color = AppColors.orange,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.04,
      builder: (context, hovered) {
        return Semantics(
          button: true,
          label: label,
          child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            decoration: BoxDecoration(
              color: filled
                  ? color
                  : (hovered ? color.withValues(alpha: 0.12) : Colors.transparent),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: filled ? color : color.withValues(alpha: hovered ? 0.9 : 0.5),
                width: 1.4,
              ),
              boxShadow: filled && hovered
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.45),
                        blurRadius: 26,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon,
                      size: 18,
                      color: filled ? AppColors.bg : AppColors.textPrimary),
                  const SizedBox(width: 9),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: filled ? AppColors.bg : AppColors.textPrimary,
                  ),
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

/// Opens an external URL (mailto/tel/https) in a new tab.
Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    // Fallback for mailto/tel which sometimes need platformDefault.
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}
