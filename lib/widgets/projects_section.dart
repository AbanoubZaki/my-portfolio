import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/projects_data.dart';
import '../l10n/l10n.dart';
import '../models/project.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  // Total projects shown before the "See more" button is pressed.
  static const int _initialVisible = 5;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width > Responsive.desktop
        ? 3
        : width >= Responsive.tablet
            ? 2
            : 1;

    final featured = kProjects.first;
    final rest = kProjects.skip(1).toList();

    // On a 3-column layout the featured card spans 2 slots and the next project
    // fills the remaining slot beside it (bento row). Otherwise the featured
    // card is full-width and every other project flows in the grid.
    final bento = columns == 3 && rest.isNotEmpty;
    final companion = bento ? rest.first : null;
    final gridSource = bento ? rest.skip(1).toList() : rest;

    // The featured card (+ bento companion) already count toward the visible
    // total, so the grid fills the remainder up to [_initialVisible].
    final aboveGrid = bento ? 2 : 1;
    final gridInitial =
        (_initialVisible - aboveGrid).clamp(0, gridSource.length);
    final collapsible = gridSource.length > gridInitial;
    final visible = (_expanded || !collapsible)
        ? gridSource
        : gridSource.take(gridInitial).toList();
    final hidden = gridSource.length - gridInitial;

    return SectionContainer(
      background: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: context.tr('Projects', 'Projekte'),
              title: context.tr('Selected work', 'Ausgewählte Arbeiten'),
              accent: AppColors.pink,
            ),
          ),
          const SizedBox(height: 48),
          if (companion != null)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Reveal(child: _FeaturedProjectCard(project: featured)),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Reveal(
                      delay: const Duration(milliseconds: 60),
                      child: ProjectCard(project: companion),
                    ),
                  ),
                ],
              ),
            )
          else
            Reveal(child: _FeaturedProjectCard(project: featured)),
          const SizedBox(height: 24),
          EqualHeightGrid(
            columns: columns,
            children: [
              for (var i = 0; i < visible.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 60 * (i % columns)),
                  child: ProjectCard(project: visible[i]),
                ),
            ],
          ),
          if (collapsible) ...[
            const SizedBox(height: 32),
            Center(
              child: PillButton(
                label: _expanded
                    ? context.tr('Show less', 'Weniger')
                    : context.tr('See more ($hidden)', 'Mehr ansehen ($hidden)'),
                icon: _expanded ? Icons.expand_less : Icons.expand_more,
                filled: false,
                color: AppColors.pink,
                onTap: () => setState(() => _expanded = !_expanded),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  const _FeaturedProjectCard({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    // Narrow screens have no room for the horizontal split — fall back to the
    // standard vertical card. IntrinsicHeight bounds the card's height so its
    // internal Expanded/Spacer resolve (EqualHeightGrid does the same).
    if (Responsive.isMobile(context)) {
      return IntrinsicHeight(child: ProjectCard(project: project));
    }

    final p = project;
    return Hoverable(
      scale: 1.01,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hovered ? p.accent.withValues(alpha: 0.55) : AppColors.border,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: p.accent.withValues(alpha: 0.18),
                    blurRadius: 34,
                    offset: const Offset(0, 14),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top accent line (clipped to the card's rounded corners).
            Container(height: 3, color: p.accent),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 360,
                    child: _FeaturedLogoPanel(project: p),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr('Featured', 'Im Fokus').toUpperCase(),
                            style: AppText.label(11.5).copyWith(
                              color: p.accent,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(p.name, style: AppText.cardTitle(26)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 5),
                                decoration: BoxDecoration(
                                  color: p.accent.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  p.type.of(context),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: p.accent,
                                  ),
                                ),
                              ),
                              Text(p.period.of(context), style: AppText.body(12.5)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(p.description.of(context), style: AppText.body(14.5)),
                          const SizedBox(height: 16),
                          for (final h in p.highlights)
                            _Highlight(text: h.of(context), accent: p.accent),
                          if (p.apps.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              context.tr(
                                '${p.apps.length} apps in the suite',
                                '${p.apps.length} Apps in der Suite',
                              ),
                              style: AppText.label(11.5).copyWith(color: p.accent),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final a in p.apps)
                                  _AppChip(app: a, accent: p.accent),
                              ],
                            ),
                          ],
                          const Spacer(),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [for (final t in p.tags) TagChip(label: t)],
                          ),
                          if (p.stores.isNotEmpty) ...[
                            const SizedBox(height: 18),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (final s in p.stores)
                                  _StoreButton(store: s, accent: p.accent),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;
    return Hoverable(
      scale: 1.02,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hovered ? p.accent.withValues(alpha: 0.55) : AppColors.border,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: p.accent.withValues(alpha: 0.18),
                    blurRadius: 34,
                    offset: const Offset(0, 14),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top accent line (clipped to the card's rounded corners).
            Container(height: 3, color: p.accent),
            SizedBox(height: 160, width: double.infinity, child: _ProjectImage(project: p)),
            Expanded(
              child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: AppText.cardTitle(22)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          color: p.accent.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          p.type.of(context),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: p.accent,
                          ),
                        ),
                      ),
                      Text(p.period.of(context), style: AppText.body(12.5)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(p.description.of(context), style: AppText.body(14)),
                  const SizedBox(height: 16),
                  for (final h in p.highlights)
                    _Highlight(text: h.of(context), accent: p.accent),
                  if (p.apps.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      context.tr(
                        '${p.apps.length} apps in the suite',
                        '${p.apps.length} Apps in der Suite',
                      ),
                      style: AppText.label(11.5).copyWith(color: p.accent),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [for (final a in p.apps) _AppChip(app: a, accent: p.accent)],
                    ),
                    const SizedBox(height: 8),
                  ],
                  const Spacer(),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [for (final t in p.tags) TagChip(label: t)],
                  ),
                  if (p.stores.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [for (final s in p.stores) _StoreButton(store: s, accent: p.accent)],
                    ),
                  ],
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Left panel of the featured card: the project logo centered on a white tile,
/// optionally floating over a backdrop photo (e.g. a city skyline) with a scrim
/// for contrast. Falls back to a plain background when no backdrop is set.
class _FeaturedLogoPanel extends StatelessWidget {
  const _FeaturedLogoPanel({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;

    final Widget logo = p.imageAsset == null
        ? _FeaturedMonogram(project: p)
        : p.isSvg
            ? SvgPicture.asset(
                p.imageAsset!,
                width: 150,
                fit: BoxFit.contain,
                placeholderBuilder: (_) => _FeaturedMonogram(project: p),
              )
            : Image.asset(
                p.imageAsset!,
                width: 150,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => _FeaturedMonogram(project: p),
              );

    // No backdrop: keep the original flat logo-on-background treatment.
    if (p.backdropAsset == null) {
      return ColoredBox(
        color: p.imageBackground ?? Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Center(child: logo),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          p.backdropAsset!,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (_, _, _) =>
              ColoredBox(color: p.imageBackground ?? Colors.white),
        ),
        // Scrim: subtle at the top, deeper at the bottom — gives the floating
        // tile contrast against the airy, light photo.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x14000000), Color(0x59000000)],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: logo,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturedMonogram extends StatelessWidget {
  const _FeaturedMonogram({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Text(
      project.name,
      textAlign: TextAlign.center,
      style: AppText.heroName(26).copyWith(color: project.accent),
    );
  }
}

class _AppChip extends StatelessWidget {
  const _AppChip({required this.app, required this.accent});
  final SubApp app;
  final Color accent;

  static const double _icon = 20;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: _icon,
      height: _icon,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        ),
      ),
    );

    Widget icon = dot;
    if (app.iconAsset != null) {
      final logo = app.isSvgIcon
          ? SvgPicture.asset(app.iconAsset!, width: _icon, height: _icon,
              placeholderBuilder: (_) => dot)
          : Image.asset(app.iconAsset!, width: _icon, height: _icon, fit: BoxFit.cover,
              errorBuilder: (_, _, _) => dot);
      icon = ClipRRect(borderRadius: BorderRadius.circular(6), child: logo);
    }

    return Tooltip(
      message: app.purpose.of(context),
      child: Container(
        padding: const EdgeInsets.only(left: 6, right: 11, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withValues(alpha: 0.20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 7),
            Text(app.name, style: AppText.chip),
            if (app.links.isNotEmpty) ...[
              const SizedBox(width: 8),
              for (final link in app.links)
                _AppLinkButton(link: link, accent: accent),
            ],
          ],
        ),
      ),
    );
  }
}

class _AppLinkButton extends StatelessWidget {
  const _AppLinkButton({required this.link, required this.accent});
  final AppLink link;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final String tip;
    final Widget glyph;
    switch (link.platform) {
      case AppPlatform.android:
        tip = 'Google Play';
        glyph = Image.asset('assets/images/google.png', width: 15, height: 15);
      case AppPlatform.ios:
        tip = 'App Store';
        glyph = Image.asset('assets/images/apple.png', width: 15, height: 15);
      case AppPlatform.web:
        tip = context.tr('Web App', 'Web-App');
        glyph = Icon(Icons.public, size: 15, color: accent);
    }
    return Tooltip(
      message: tip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Semantics(
          button: true,
          label: tip,
          child: GestureDetector(
            onTap: () => openUrl(link.url),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: glyph,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectImage extends StatelessWidget {
  const _ProjectImage({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;

    Widget placeholder() => DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                p.accent.withValues(alpha: 0.55),
                p.accent.withValues(alpha: 0.12),
              ],
            ),
          ),
          child: Center(
            child: Text(
              p.name,
              textAlign: TextAlign.center,
              style: AppText.heroName(20).copyWith(color: Colors.white.withValues(alpha: 0.92)),
            ),
          ),
        );

    if (p.imageMode == ProjectImageMode.placeholder || p.imageAsset == null) {
      return placeholder();
    }

    if (p.isSvg) {
      return Container(
        color: p.imageBackground ?? AppColors.bgCard,
        padding: p.imagePadding ?? const EdgeInsets.all(28),
        child: SvgPicture.asset(
          p.imageAsset!,
          fit: BoxFit.contain,
          placeholderBuilder: (_) => placeholder(),
        ),
      );
    }

    final image = Image.asset(
      p.imageAsset!,
      semanticLabel: p.name,
      fit: p.imageMode == ProjectImageMode.cover ? BoxFit.cover : BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, _, _) => placeholder(),
    );

    if (p.imageMode == ProjectImageMode.contain) {
      return Container(
        color: p.imageBackground ?? Colors.white,
        padding: p.imagePadding ?? const EdgeInsets.all(20),
        child: image,
      );
    }

    // cover
    return Container(color: p.imageBackground ?? AppColors.bg, child: image);
  }
}

class _StoreIcon extends StatelessWidget {
  const _StoreIcon({required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    const fallback = Icon(Icons.open_in_new, size: 16, color: AppColors.textPrimary);
    if (asset.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        width: 18,
        height: 18,
        placeholderBuilder: (_) => fallback,
      );
    }
    return Image.asset(
      asset,
      width: 18,
      height: 18,
      errorBuilder: (_, _, _) => fallback,
    );
  }
}

class _Highlight extends StatelessWidget {
  const _Highlight({required this.text, required this.accent});
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 10),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
          ),
          Expanded(child: Text(text, style: AppText.body(13.5))),
        ],
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  const _StoreButton({required this.store, required this.accent});
  final StoreLink store;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.04,
      builder: (context, hovered) => Semantics(
        button: true,
        label: store.label,
        child: GestureDetector(
        onTap: () => openUrl(store.url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.bg.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: hovered ? accent.withValues(alpha: 0.6) : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StoreIcon(asset: store.iconAsset),
              const SizedBox(width: 9),
              Text(store.label, style: AppText.chip),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
