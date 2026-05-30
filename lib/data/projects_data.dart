import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/project.dart';
import '../theme/colors.dart';

const String _appleIcon = 'assets/images/apple.png';
const String _googlePlayIcon = 'assets/images/google.png';

const List<Project> kProjects = [
  Project(
    name: 'LeanGo Platform',
    type: L('Flutter · Team Lead', 'Flutter · Teamleitung'),
    period: L('Jan 2022 – Present', 'Jan. 2022 – heute'),
    accent: AppColors.leangoGreen,
    // TODO: restore a proper LeanGo logo asset here once a better one is ready.
    imageMode: ProjectImageMode.contain,
    imageBackground: Colors.white,
    backdropAsset: 'assets/images/dubai.png',
    description: L(
      'A full suite of Industry 4.0 manufacturing apps built from scratch and shipped '
          'to Google Play, the App Store & Web — covering the factory floor end to end, '
          'from real-time analytics to maintenance, traceability, and food safety.',
      'Eine komplette Suite von Industrie-4.0-Fertigungs-Apps, von Grund auf entwickelt '
          'und für Google Play, den App Store und das Web veröffentlicht – sie deckt die '
          'gesamte Produktion ab, von Echtzeit-Analysen über Wartung und Rückverfolgbarkeit '
          'bis zur Lebensmittelsicherheit.',
    ),
    apps: [
      SubApp(
        name: 'LeanGo Dashboard',
        purpose: L(
          'Flutter Web command center for plant KPIs & analytics',
          'Flutter-Web-Kommandozentrale für Werks-KPIs und Analysen',
        ),
        iconAsset: 'assets/images/leango_dashboard.png',
        links: [AppLink(AppPlatform.web, 'https://leango.app/')],
      ),
      SubApp(
        name: 'STM Dashboard',
        purpose: L(
          'Sales Tracking Management board for sales performance & KPIs',
          'Sales-Tracking-Management-Board für Vertriebsleistung und KPIs',
        ),
        iconAsset: 'assets/images/stm.png',
        links: [AppLink(AppPlatform.web, 'https://dev.stm.leango.app/')],
      ),
      SubApp(
        name: 'STM Mobile',
        purpose: L(
          'On-the-go companion for sales tracking in the field',
          'Mobile Begleit-App für das Vertriebs-Tracking unterwegs',
        ),
        iconAsset: 'assets/images/stm.png',
        links: [
          AppLink(AppPlatform.android,
              'https://play.google.com/store/apps/details?id=com.grwan.leango_stm&hl=de'),
          AppLink(AppPlatform.ios,
              'https://apps.apple.com/pa/app/leango-stm/id6768351967?platform=vision'),
        ],
      ),
      SubApp(
        name: 'CIL',
        purpose: L(
          'Cleaning, Inspection & Lubrication maintenance routines',
          'Wartungsroutinen für Reinigung, Inspektion und Schmierung (CIL)',
        ),
        iconAsset: 'assets/images/cil.png',
        links: [
          AppLink(AppPlatform.android,
              'https://play.google.com/store/apps/details?id=com.grwan.leango_cil&hl=gsw'),
          AppLink(AppPlatform.ios,
              'https://apps.apple.com/de/app/leango-cil/id1632797745'),
        ],
      ),
      SubApp(
        name: 'MES',
        purpose: L(
          'Manufacturing Execution — production orders & OEE',
          'Manufacturing Execution – Fertigungsaufträge und OEE',
        ),
        iconAsset: 'assets/images/mes.png',
        links: [
          AppLink(AppPlatform.android,
              'https://play.google.com/store/apps/details?id=com.grwan.leango_mes&hl=en'),
          AppLink(AppPlatform.ios,
              'https://apps.apple.com/de/app/leango-mes/id6448866952'),
        ],
      ),
      SubApp(
        name: 'Trace',
        purpose: L(
          'End-to-end product & batch traceability',
          'Durchgängige Produkt- und Chargenrückverfolgung',
        ),
        iconAsset: 'assets/images/trace.png',
        links: [
          AppLink(AppPlatform.android,
              'https://play.google.com/store/apps/details?id=com.grwan.leango_trace.dev'),
          AppLink(AppPlatform.ios,
              'https://apps.apple.com/ch/app/leango-trace-dev/id6471980417'),
        ],
      ),
      SubApp(
        name: 'HACCP',
        purpose: L(
          'Food-safety hazard analysis & control points',
          'Gefahrenanalyse und kritische Lenkungspunkte für Lebensmittelsicherheit (HACCP)',
        ),
        iconAsset: 'assets/images/haccp.png',
        links: [
          AppLink(AppPlatform.android,
              'https://play.google.com/store/apps/details?id=com.grwan.leango_haccp&hl=en'),
        ],
      ),
      SubApp(
        name: 'ARTEX engage',
        purpose: L(
          'Workforce engagement, suggestions & recognition',
          'Mitarbeiterengagement, Vorschläge und Anerkennung',
        ),
        iconAsset: 'assets/images/engage.png',
        links: [
          AppLink(AppPlatform.android,
              'https://play.google.com/store/apps/details?id=com.grwan.artex.engage&hl=en'),
        ],
      ),
    ],
    highlights: [
      L(
        'Led 10+ apps across Android, iOS & Web from scratch',
        'Über 10 Apps für Android, iOS und Web von Grund auf geleitet',
      ),
      L(
        'Built the LeanGo & STM dashboards with Flutter Web',
        'LeanGo- und STM-Dashboards mit Flutter Web entwickelt',
      ),
      L(
        'Shared architecture, CI/CD, and responsive accessible UI',
        'Gemeinsame Architektur, CI/CD und responsive, barrierefreie UI',
      ),
    ],
    tags: ['Flutter', 'Flutter Web', 'Firebase', 'CI/CD'],
  ),
  Project(
    name: 'Salik',
    type: L('iOS · SwiftUI', 'iOS · SwiftUI'),
    period: L('Feb 2025 – Mar 2026', 'Feb. 2025 – März 2026'),
    accent: AppColors.salikSlate,
    imageAsset: 'assets/images/salik.png',
    imageMode: ProjectImageMode.contain,
    imageBackground: Colors.white,
    imagePadding: EdgeInsets.all(40),
    description: L(
      'UAE Government app built with SwiftUI using MVVM and clean architecture. '
          'Handles Transactions, Vehicles, Services, Settings, and News.',
      'Regierungs-App der VAE, entwickelt mit SwiftUI nach MVVM und Clean Architecture. '
          'Umfasst Transaktionen, Fahrzeuge, Services, Einstellungen und News.',
    ),
    highlights: [
      L(
        'Government-grade quality standards and performance',
        'Qualitätsstandards und Performance auf Behördenniveau',
      ),
      L(
        'Seamless integration across key functional modules',
        'Nahtlose Integration über zentrale Funktionsmodule hinweg',
      ),
      L(
        'Clean architecture with MVVM pattern',
        'Clean Architecture mit MVVM-Muster',
      ),
    ],
    tags: ['SwiftUI', 'MVVM', 'Clean Architecture'],
    stores: [
      StoreLink(
        label: 'App Store',
        url: 'https://apps.apple.com/us/app/smart-salik/id912158362',
        iconAsset: _appleIcon,
      ),
    ],
  ),
  Project(
    name: 'Khatabook',
    type: L('iOS · Swift', 'iOS · Swift'),
    period: L('Jan 2022 – Sep 2022', 'Jan. 2022 – Sep. 2022'),
    accent: AppColors.khatabookRed,
    imageAsset: 'assets/images/khatabook.png',
    imageMode: ProjectImageMode.contain,
    imageBackground: Colors.white,
    description: L(
      'Business management app using VIPER structure and Swift. Real bank '
          'transfers, transaction history, and financial tracking.',
      'App für die Unternehmensverwaltung mit VIPER-Struktur und Swift. Echte '
          'Banküberweisungen, Transaktionsverlauf und Finanzübersicht.',
    ),
    highlights: [
      L(
        'Real and secure bank transfer module',
        'Echtes und sicheres Modul für Banküberweisungen',
      ),
      L(
        'Transaction status & history screens',
        'Bildschirme für Transaktionsstatus und -verlauf',
      ),
    ],
    tags: ['Swift', 'VIPER', 'Banking'],
    stores: [
      StoreLink(
        label: 'App Store',
        url: 'https://apps.apple.com/in/app/khatabook-vyapar-app/id1488204139',
        iconAsset: _appleIcon,
      ),
    ],
  ),
  Project(
    name: 'Wellx',
    type: L('Flutter App', 'Flutter-App'),
    period: L('Jul 2025 – Sep 2025', 'Juli 2025 – Sep. 2025'),
    accent: AppColors.wellxViolet,
    imageAsset: 'assets/images/wellx.png',
    imageMode: ProjectImageMode.contain,
    imageBackground: AppColors.bg,
    imagePadding: EdgeInsets.all(44),
    description: L(
      'An AI-powered health insurance app that turns coverage from reactive to '
          'proactive — using behaviour and well-being data to help people live better lives.',
      'Eine KI-gestützte Krankenversicherungs-App, die Versicherung von reaktiv zu '
          'proaktiv macht – mithilfe von Verhaltens- und Wohlbefindensdaten für ein '
          'gesünderes Leben.',
    ),
    highlights: [
      L(
        'Built the emotion-tracking module',
        'Modul zur Emotionserfassung entwickelt',
      ),
      L(
        'Developed the tracked-emotions statistics screen',
        'Statistik-Bildschirm für erfasste Emotionen entwickelt',
      ),
    ],
    tags: ['Flutter', 'AI', 'Health'],
    stores: [
      StoreLink(
        label: 'Google Play',
        url: 'https://play.google.com/store/apps/details?id=com.wellx&hl=en',
        iconAsset: _googlePlayIcon,
      ),
      StoreLink(
        label: 'App Store',
        url: 'https://apps.apple.com/de/app/wellx-ai/id1640492711?l=en-GB',
        iconAsset: _appleIcon,
      ),
    ],
  ),
  Project(
    name: 'MUAB',
    type: L('Flutter · Education', 'Flutter · Bildung'),
    period: L('Apr 2023 – Dec 2023', 'Apr. 2023 – Dez. 2023'),
    accent: AppColors.muabBlue,
    imageAsset: 'assets/images/muab.svg',
    imageMode: ProjectImageMode.contain,
    imageBackground: Colors.white,
    description: L(
      'An education ecosystem and social learning network built with Flutter, where '
          'creators and institutions publish courses, programs, and digital products, '
          'and learners get a personalized, AI-driven feed with community and progress tracking.',
      'Ein Bildungs-Ökosystem und soziales Lernnetzwerk, entwickelt mit Flutter: '
          'Creator und Institutionen veröffentlichen Kurse, Programme und digitale Produkte, '
          'während Lernende einen personalisierten, KI-gestützten Feed mit Community und '
          'Fortschritts-Tracking erhalten.',
    ),
    highlights: [
      L(
        'Built the login and home content-feed screens',
        'Login- und Home-Content-Feed-Bildschirme entwickelt',
      ),
      L(
        'Explore screen to search users and posts',
        'Explore-Bildschirm zur Suche nach Nutzern und Beiträgen',
      ),
      L(
        'User profile screen and block-users feature',
        'Nutzerprofil-Bildschirm und Funktion zum Blockieren von Nutzern',
      ),
    ],
    tags: ['Flutter', 'Education', 'Social'],
    stores: [
      StoreLink(
        label: 'Google Play',
        url: 'https://play.google.com/store/apps/details?id=com.network.muab&hl=en',
        iconAsset: _googlePlayIcon,
      ),
      StoreLink(
        label: 'App Store',
        url: 'https://apps.apple.com/sa/app/muab/id6444184362',
        iconAsset: _appleIcon,
      ),
    ],
  ),
  Project(
    name: 'LIBRA',
    type: L('iOS · Swift', 'iOS · Swift'),
    period: L('Oct 2022 – May 2023', 'Okt. 2022 – Mai 2023'),
    accent: AppColors.libraBlue,
    imageAsset: 'assets/images/libra.png',
    imageMode: ProjectImageMode.cover,
    description: L(
      'Business management iOS app with VIPER architecture. Features secure bank '
          'transfers and VoIP calling between users.',
      'iOS-App für die Unternehmensverwaltung mit VIPER-Architektur. Mit sicheren '
          'Banküberweisungen und VoIP-Anrufen zwischen Nutzern.',
    ),
    highlights: [
      L(
        'VoIP calls with full edge case handling',
        'VoIP-Anrufe mit vollständiger Behandlung von Sonderfällen',
      ),
      L(
        'Secure money transfer module',
        'Sicheres Modul für Geldüberweisungen',
      ),
      L(
        'Invite via text message or QR code',
        'Einladung per SMS oder QR-Code',
      ),
    ],
    tags: ['Swift', 'VIPER', 'VoIP'],
  ),
  Project(
    name: 'SALT',
    type: L('Flutter · Project Lead', 'Flutter · Projektleitung'),
    period: L('Mar 2022 – Sep 2022', 'März 2022 – Sep. 2022'),
    accent: AppColors.saltTeal,
    imageAsset: 'assets/images/salt.svg',
    imageMode: ProjectImageMode.contain,
    imageBackground: Colors.white,
    description: L(
      'Gold trading and investment app built with Flutter. Led the team from '
          'inception to production with AI-powered chat and mutual funds.',
      'App für Goldhandel und -investment, entwickelt mit Flutter. Leitung des Teams '
          'von der Idee bis zur Produktion, mit KI-gestütztem Chat und Investmentfonds.',
    ),
    highlights: [
      L(
        'Buy & Sell Gold module with secure transactions',
        'Modul zum Kauf und Verkauf von Gold mit sicheren Transaktionen',
      ),
      L(
        'AI-powered expense tracking chat module',
        'KI-gestütztes Chat-Modul zur Ausgabenverfolgung',
      ),
      L(
        'Mutual funds investment integration',
        'Integration von Investmentfonds',
      ),
    ],
    tags: ['Flutter', 'AI Integration', 'Clean Code'],
  ),
  Project(
    name: 'Memo Rush',
    type: L('Flutter · Personal Project', 'Flutter · Privatprojekt'),
    period: L('Nov 2025 – Jan 2026', 'Nov. 2025 – Jan. 2026'),
    accent: AppColors.memoPink,
    imageAsset: 'assets/images/memo_icon_1.png',
    imageMode: ProjectImageMode.cover,
    description: L(
      'A fun memory card-matching game built with Flutter in free time. '
          'Available on the Google Play Store.',
      'Ein unterhaltsames Memory-Kartenspiel, in der Freizeit mit Flutter entwickelt. '
          'Verfügbar im Google Play Store.',
    ),
    highlights: [
      L(
        'Solo end-to-end development and launch',
        'Komplette Entwicklung und Veröffentlichung im Alleingang',
      ),
      L(
        'Published on Google Play Store',
        'Im Google Play Store veröffentlicht',
      ),
      L(
        'Engaging gameplay with emoji card matching',
        'Fesselndes Gameplay mit Emoji-Kartenpaaren',
      ),
    ],
    tags: ['Flutter', 'Game', 'Google Play'],
    stores: [
      StoreLink(
        label: 'Google Play',
        url: 'https://play.google.com/store/apps/details?id=com.abanoub.memo.rush',
        iconAsset: _googlePlayIcon,
      ),
    ],
  ),
  Project(
    name: 'IRIS',
    type: L('Flutter App', 'Flutter-App'),
    period: L('Oct 2023 – Nov 2024', 'Okt. 2023 – Nov. 2024'),
    accent: AppColors.yellow,
    imageMode: ProjectImageMode.placeholder,
    description: L(
      'Loan review application for small businesses and shops, featuring a robust '
          'CI/CD pipeline and multi-environment support.',
      'Anwendung zur Kreditprüfung für kleine Unternehmen und Geschäfte, mit robuster '
          'CI/CD-Pipeline und Unterstützung mehrerer Umgebungen.',
    ),
    highlights: [
      L(
        'Dev/prod environments via Flutter Flavors',
        'Dev-/Prod-Umgebungen über Flutter Flavors',
      ),
      L(
        'Enhanced CI/CD with Codemagic',
        'Verbesserte CI/CD mit Codemagic',
      ),
      L(
        'Full verification process with key features',
        'Vollständiger Verifizierungsprozess mit zentralen Funktionen',
      ),
    ],
    tags: ['Flutter', 'Flutter Flavors', 'Codemagic'],
  ),
  Project(
    name: 'ResQ',
    type: L('Android · MVC', 'Android · MVC'),
    period: L('Feb 2020 – Mar 2020', 'Feb. 2020 – März 2020'),
    accent: AppColors.resqPurple,
    imageAsset: 'assets/images/resq.png',
    imageMode: ProjectImageMode.contain,
    imageBackground: Colors.white,
    description: L(
      'App for helping stray animals — find lost pets or put pets up for adoption. '
          'Top 13 MENA teams in Google DSC Solution Challenge 2020.',
      'App zur Hilfe für Straßentiere – entlaufene Tiere finden oder Tiere zur Adoption '
          'anbieten. Top-13-Team der MENA-Region in der Google DSC Solution Challenge 2020.',
    ),
    highlights: [
      L(
        'Google Sign-In and Firebase integration',
        'Integration von Google Sign-In und Firebase',
      ),
      L(
        'Google DSC Solution Challenge 2020 semi-finalist',
        'Halbfinalist der Google DSC Solution Challenge 2020',
      ),
    ],
    tags: ['Android', 'Firebase', 'Google APIs'],
  ),
];
