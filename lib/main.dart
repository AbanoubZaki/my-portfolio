import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';
import 'theme/colors.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/nav_bar.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'Abanoub Michael — Software Development Engineer',
          debugShowCheckedModeBanner: false,
          scrollBehavior: const _AppScrollBehavior(),
          locale: locale,
          supportedLocales: kSupportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.bg,
            colorScheme: const ColorScheme.dark(
              surface: AppColors.bg,
              primary: AppColors.orange,
            ),
          ),
          home: const PortfolioPage(),
        );
      },
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scroll = ScrollController();

  final Map<String, GlobalKey> _keys = {
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollTo(String id) {
    if (id == 'top') {
      _scroll.animateTo(0,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOutCubic);
      return;
    }
    final ctx = _keys[id]?.currentContext;
    if (ctx == null) return;
    // ensureVisible derives the target from layout (works for off-screen,
    // never-painted children, unlike localToGlobal). The section's own top
    // padding clears the fixed nav bar.
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(onNavTap: _scrollTo),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              children: [
                HeroSection(
                  onViewWork: () => _scrollTo('projects'),
                  onContact: () => _scrollTo('contact'),
                ),
                KeyedSubtree(key: _keys['about'], child: const AboutSection()),
                KeyedSubtree(key: _keys['skills'], child: const SkillsSection()),
                KeyedSubtree(key: _keys['experience'], child: const ExperienceSection()),
                KeyedSubtree(key: _keys['projects'], child: const ProjectsSection()),
                KeyedSubtree(key: _keys['contact'], child: const ContactSection()),
                const Footer(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              controller: _scroll,
              onNavTap: _scrollTo,
              onMenu: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Enables mouse + touch dragging for the web scroll view.
class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
