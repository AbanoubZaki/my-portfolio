import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';
import 'contact_section.dart' show kResumeUrl;

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  final VoidCallback onViewWork;
  final VoidCallback onContact;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  );

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    // The animated, blur-heavy hero visual tanks mobile Safari/WebKit. Run the
    // continuous spin loop only on desktop; mobile/tablet get a static visual.
    if (isDesktop) {
      if (!_spin.isAnimating) _spin.repeat();
    } else if (_spin.isAnimating) {
      _spin.stop();
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        gradient: RadialGradient(
          center: Alignment(0.9, -0.9),
          radius: 1.2,
          colors: [Color(0x267B4FFF), Colors.transparent],
          stops: [0, 0.5],
        ),
      ),
      child: Stack(
        children: [
          // Bottom-left orange glow + bottom-right teal glow.
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.95, 0.95),
                  radius: 1.0,
                  colors: [Color(0x1FFF5C35), Colors.transparent],
                  stops: [0, 0.45],
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.95, 0.95),
                  radius: 1.0,
                  colors: [Color(0x1A00D4AA), Colors.transparent],
                  stops: [0, 0.4],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.horizontalPadding(context),
              isMobile ? 120 : 140,
              Responsive.horizontalPadding(context),
              isMobile ? 80 : 120,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: Responsive.maxContentWidth),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6, child: _HeroText(widget: widget)),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: HeroVisual(
                                  controller: _spin, size: 400, lite: false),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: HeroVisual(
                                controller: _spin, size: 260, lite: true),
                          ),
                          const SizedBox(height: 44),
                          _HeroText(widget: widget),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.widget});
  final HeroSection widget;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final nameSize = isMobile ? 52.0 : 76.0;

    Widget anim(Widget child, int ms) => child
        .animate()
        .fadeIn(duration: 600.ms, delay: ms.ms)
        .slideY(begin: 0.25, end: 0, duration: 700.ms, delay: ms.ms, curve: Curves.easeOutCubic);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        anim(const _AvailabilityPill(), 0),
        const SizedBox(height: 28),
        anim(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text('Abanoub', style: AppText.heroName(nameSize)),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Michael',
                  style: AppText.heroName(nameSize).copyWith(color: AppColors.orange),
                ),
              ),
            ],
          ),
          120,
        ),
        const SizedBox(height: 20),
        anim(
          Text('Software Development Engineer', style: AppText.subtitle(isMobile ? 18 : 22)),
          240,
        ),
        const SizedBox(height: 24),
        anim(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              context.tr(
                '5+ years building scalable Flutter & iOS apps. Expert in clean '
                    'architecture, cross-functional team leadership, and delivering '
                    'high-impact mobile solutions across 30+ production apps.',
                'Seit über 5 Jahren entwickle ich skalierbare Flutter- und iOS-Apps. '
                    'Experte für Clean Architecture, interdisziplinäre Teamführung und '
                    'wirkungsvolle mobile Lösungen in über 30 produktiven Apps.',
              ),
              style: AppText.body(16),
            ),
          ),
          340,
        ),
        const SizedBox(height: 36),
        anim(
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              PillButton(
                label: context.tr('View My Work', 'Meine Arbeiten ansehen'),
                icon: Icons.arrow_forward,
                onTap: widget.onViewWork,
              ),
              PillButton(
                label: context.tr('Get in Touch', 'Kontakt aufnehmen'),
                filled: false,
                onTap: widget.onContact,
              ),
              PillButton(
                label: context.tr('Download CV', 'Lebenslauf'),
                icon: Icons.download,
                filled: false,
                onTap: () => openUrl(kResumeUrl),
              ),
            ],
          ),
          440,
        ),
        const SizedBox(height: 52),
        anim(const _StatsRow(), 560),
      ],
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fadeIn(duration: 900.ms)
              .scaleXY(begin: 0.7, end: 1.25, duration: 900.ms, curve: Curves.easeInOut),
          const SizedBox(width: 10),
          Text(
            context.tr('Available for opportunities', 'Offen für neue Möglichkeiten'),
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 24,
      children: [
        _Stat(value: '5+', label: context.tr('Years Experience', 'Jahre Erfahrung')),
        _Stat(value: '30+', label: context.tr('Production Apps', 'Produktive Apps')),
        _Stat(value: '10+', label: context.tr('Team Members Led', 'Geführte Teammitglieder')),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.orange, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppText.cardTitle(30).copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppText.body(13.5)),
        ],
      ),
    );
  }
}

/// Glassmorphism "aura" hero visual: a frosted-glass circle with a gradient
/// rim, floating over slowly morphing blurred color blobs — all clipped to a
/// circle. The blobs drift on their own and also follow the cursor; a gentle
/// idle float keeps it alive.
class HeroVisual extends StatefulWidget {
  const HeroVisual({
    super.key,
    required this.controller,
    this.size = 400,
    this.lite = false,
  });

  final AnimationController controller;
  final double size;

  /// When true (mobile/tablet), drop the per-frame blur loop + BackdropFilter
  /// for a static gradient aura — WebKit can't composite the heavy version.
  final bool lite;

  @override
  State<HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<HeroVisual> {
  // Normalized cursor position within the visual (-1..1 on each axis).
  Alignment _pointer = Alignment.center;

  void _onHover(PointerHoverEvent e) {
    final s = widget.size;
    final px = (e.localPosition.dx / s).clamp(0.0, 1.0);
    final py = (e.localPosition.dy / s).clamp(0.0, 1.0);
    setState(() => _pointer = Alignment(px * 2 - 1, py * 2 - 1));
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final glass = size * 0.72;
    final photo = glass * 0.84;
    final blob = size * 0.52;

    if (widget.lite) return _liteVisual(size, glass, photo);

    final visual = MouseRegion(
      onHover: _onHover,
      onExit: (_) => setState(() => _pointer = Alignment.center),
      child: SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: TweenAnimationBuilder<Alignment>(
            tween: Tween(end: _pointer),
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOut,
            builder: (context, p, _) => AnimatedBuilder(
              animation: widget.controller,
              builder: (context, _) {
                final t = widget.controller.value * 2 * math.pi;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned.fill(
                        child: ColoredBox(color: AppColors.bg)),
                    // Drifting blurred blobs that also follow the cursor.
                    _blob(
                      blob,
                      AppColors.purple,
                      Alignment(
                        -0.45 + 0.22 * math.sin(t) + p.x * 0.4,
                        -0.5 + 0.2 * math.cos(t) + p.y * 0.4,
                      ),
                    ),
                    _blob(
                      blob,
                      AppColors.teal,
                      Alignment(
                        0.55 + 0.2 * math.cos(t * 0.8) - p.x * 0.3,
                        0.55 + 0.22 * math.sin(t * 0.8) - p.y * 0.3,
                      ),
                    ),
                    _blob(
                      blob * 0.85,
                      AppColors.orange,
                      Alignment(
                        0.15 + 0.2 * math.sin(t * 1.2 + 1) + p.x * 0.5,
                        0.35 + 0.2 * math.cos(t * 1.2) + p.y * 0.5,
                      ),
                    ),
                    // Frosted glass disc with a gradient rim + the photo.
                    Container(
                      width: glass,
                      height: glass,
                      padding: const EdgeInsets.all(1.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.orange, AppColors.purple],
                        ),
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                          child: Container(
                            color: Colors.white.withValues(alpha: 0.06),
                            alignment: Alignment.center,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile.png',
                                semanticLabel: 'Abanoub Michael',
                                width: photo,
                                height: photo,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (_, _, _) => SizedBox(
                                  width: photo,
                                  height: photo,
                                  child: Center(
                                    child:
                                        Text('AM', style: AppText.monogram(48)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );

    return visual
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: -6, end: 6, duration: 3500.ms, curve: Curves.easeInOut);
  }

  // Static, GPU-cheap hero: radial-gradient aura (no blur, no repaint loop)
  // behind the framed photo. No BackdropFilter — WebKit chokes on it.
  Widget _liteVisual(double size, double glass, double photo) {
    Widget aura(Color color, Alignment center) => DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: center,
              radius: 0.75,
              colors: [color.withValues(alpha: 0.55), Colors.transparent],
            ),
          ),
        );

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned.fill(child: ColoredBox(color: AppColors.bg)),
            Positioned.fill(
                child: aura(AppColors.purple, const Alignment(-0.45, -0.5))),
            Positioned.fill(
                child: aura(AppColors.teal, const Alignment(0.55, 0.55))),
            Positioned.fill(
                child: aura(AppColors.orange, const Alignment(0.15, 0.35))),
            Container(
              width: glass,
              height: glass,
              padding: const EdgeInsets.all(1.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.orange, AppColors.purple],
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  semanticLabel: 'Abanoub Michael',
                  width: photo,
                  height: photo,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (_, _, _) => SizedBox(
                    width: photo,
                    height: photo,
                    child: Center(child: Text('AM', style: AppText.monogram(48))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blob(double d, Color color, Alignment align) => Align(
        alignment: align,
        child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: 34, sigmaY: 34),
          child: Container(
            width: d,
            height: d,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.85),
            ),
          ),
        ),
      );
}
