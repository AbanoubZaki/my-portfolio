import 'dart:ui';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'common.dart';

const List<({String id, String en, String de})> kNavLinks = [
  (id: 'about', en: 'About', de: 'Über mich'),
  (id: 'skills', en: 'Skills', de: 'Fähigkeiten'),
  (id: 'experience', en: 'Experience', de: 'Berufserfahrung'),
  (id: 'projects', en: 'Projects', de: 'Projekte'),
  (id: 'contact', en: 'Contact', de: 'Kontakt'),
];

const String kHireMail = 'mailto:abanoub4055@gmail.com';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.controller,
    required this.onNavTap,
    required this.onMenu,
  });

  final ScrollController controller;
  final void Function(String id) onNavTap;
  final VoidCallback onMenu;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.controller.hasClients && widget.controller.offset > 16;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.horizontalPadding(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: pad),
          decoration: BoxDecoration(
            color: AppColors.bg.withValues(alpha: _scrolled ? 0.78 : 0.45),
            border: Border(
              bottom: BorderSide(
                color: _scrolled ? AppColors.border : Colors.transparent,
              ),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
              child: Row(
                children: [
                  _Logo(onTap: () => widget.onNavTap('top')),
                  const Spacer(),
                  if (!isMobile) ...[
                    for (final link in kNavLinks)
                      _NavLink(
                        label: context.tr(link.en, link.de),
                        onTap: () => widget.onNavTap(link.id),
                      ),
                    const SizedBox(width: 14),
                    const _LangToggle(),
                    const SizedBox(width: 14),
                    PillButton(
                      label: context.tr('Hire Me', 'Anfragen'),
                      onTap: () => openUrl(kHireMail),
                    ),
                  ] else ...[
                    const _LangToggle(),
                    IconButton(
                      onPressed: widget.onMenu,
                      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      scale: 1.06,
      builder: (context, _) => Semantics(
        button: true,
        label: 'Abanoub Michael — back to top',
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('AM', style: AppText.logo),
              Text('.', style: AppText.logo.copyWith(color: AppColors.orange)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Semantics(
        button: true,
        label: widget.label,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              widget.label,
              style: AppText.navLink.copyWith(
                color: _hovered ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Drawer contents for mobile navigation.
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, required this.onNavTap});
  final void Function(String id) onNavTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.bgSection,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Row(
                children: [
                  Text('AM', style: AppText.logo),
                  Text('.', style: AppText.logo.copyWith(color: AppColors.orange)),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            for (final link in kNavLinks)
              ListTile(
                title: Text(context.tr(link.en, link.de), style: AppText.bodyStrong(17)),
                onTap: () {
                  Navigator.of(context).pop();
                  onNavTap(link.id);
                },
              ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: _LangToggle(),
            ),
            const Padding(
              padding: EdgeInsets.all(24),
              child: PillButtonWrapper(),
            ),
          ],
        ),
      ),
    );
  }
}

class PillButtonWrapper extends StatelessWidget {
  const PillButtonWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return PillButton(
      label: context.tr('Hire Me', 'Anfragen'),
      onTap: () => openUrl(kHireMail),
    );
  }
}

/// Compact EN/DE language switch. Flips the app-wide [appLocale].
class _LangToggle extends StatelessWidget {
  const _LangToggle();

  @override
  Widget build(BuildContext context) {
    final isDe = context.isDe;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _seg('EN', !isDe, () => appLocale.value = const Locale('en')),
          _seg('DE', isDe, () => appLocale.value = const Locale('de')),
        ],
      ),
    );
  }

  Widget _seg(String label, bool active, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        selected: active,
        label: 'Switch to $label',
        child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: active ? AppColors.orange : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: active ? AppColors.bg : AppColors.textSecondary,
            ),
          ),
        ),
      ),
      ),
    );
  }
}
