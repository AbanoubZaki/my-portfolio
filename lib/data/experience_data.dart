import '../l10n/l10n.dart';
import '../models/experience.dart';

/// Full years since the first full-time role (Blink22, Aug 2021).
int get kYearsExperience {
  final now = DateTime.now();
  return now.year - 2021 - (now.month < 8 ? 1 : 0);
}

const List<Experience> kExperiences = [
  Experience(
    company: 'Blink22',
    role: L(
      'Full-time Software Development Engineer (Flutter & Native iOS)',
      'Software Development Engineer in Vollzeit (Flutter & natives iOS)',
    ),
    location: L('Dubai, UAE', 'Dubai, VAE'),
    period: L('Aug 2021 – Nov 2025', 'Aug. 2021 – Nov. 2025'),
    url: 'https://www.blink22.com/',
    iconAsset: 'assets/images/blink22_dark.png',
    bullets: [
      L(
        'Developed Flutter apps with Provider and Bloc, and native iOS features in Swift and SwiftUI using MVVM, VIPER and clean architecture, including a UAE government app.',
        'Entwicklung von Flutter-Apps mit Provider und Bloc sowie nativer iOS-Features in Swift und SwiftUI mit MVVM, VIPER und Clean Architecture, darunter eine App der VAE-Regierung.',
      ),
      L(
        'Optimized performance across multiple Flutter and iOS projects.',
        'Performance-Optimierung über mehrere Flutter- und iOS-Projekte hinweg.',
      ),
    ],
  ),
  Experience(
    company: 'GLI Global Lean Industry 4.0',
    role: L(
      'Part-time Software Development Team Leader (Flutter)',
      'Software-Teamleiter in Teilzeit (Flutter)',
    ),
    location: L('Dubai, UAE', 'Dubai, VAE'),
    period: L('Jan 2022 – Nov 2025', 'Jan. 2022 – Nov. 2025'),
    url: 'https://grwangroup.com/',
    iconAsset: 'assets/images/gli_dark.png',
    iconHeight: 56,
    bullets: [
      L(
        'Led a team of 10+ developers across concurrent Flutter projects.',
        'Leitung eines Teams von über 10 Entwicklern in parallelen Flutter-Projekten.',
      ),
      L(
        'Owned architecture and development workflows for the LeanGo platform: 10+ Industry 4.0 apps on Android, iOS and web.',
        'Verantwortung für Architektur und Entwicklungsprozesse der LeanGo-Plattform: über 10 Industrie-4.0-Apps für Android, iOS und Web.',
      ),
      L(
        'Refactored the legacy LeanGo Dashboard and LeanGo CIL codebases.',
        'Refactoring der Legacy-Codebasis von LeanGo Dashboard und LeanGo CIL.',
      ),
      L(
        'Reduced infrastructure costs by 30% through efficient Firebase resource allocation.',
        'Senkung der Infrastrukturkosten um 30 % durch effiziente Nutzung der Firebase-Ressourcen.',
      ),
      L(
        'Achieved a 75% bug reduction through continuous testing and feedback loops.',
        'Reduzierung der Fehler um 75 % durch kontinuierliches Testen und Feedback-Schleifen.',
      ),
    ],
  ),
  Experience(
    company: 'Wellx AI',
    role: L(
      'Contract Software Development Engineer (Flutter)',
      'Software Development Engineer auf Vertragsbasis (Flutter)',
    ),
    location: L('Dubai, UAE', 'Dubai, VAE'),
    period: L('Jul 2025 – Sep 2025 · Contract', 'Juli 2025 – Sep. 2025 · Vertrag'),
    url: 'https://wellxai.com/',
    iconAsset: 'assets/images/wellx.png',
    bullets: [
      L(
        'Worked on Wellx, an AI-powered health insurance app that turns coverage from reactive to proactive using behaviour and well-being data.',
        'Mitarbeit an Wellx, einer KI-gestützten Krankenversicherungs-App, die Versicherung mithilfe von Verhaltens- und Wohlbefindensdaten von reaktiv zu proaktiv macht.',
      ),
      L(
        'Built the emotion-tracking module.',
        'Modul zur Emotionserfassung entwickelt.',
      ),
      L(
        'Developed the tracked-emotions statistics screen.',
        'Statistik-Bildschirm für erfasste Emotionen entwickelt.',
      ),
    ],
  ),
  Experience(
    company: 'Blink22',
    role: L(
      'Mobile Development Internship (iOS)',
      'Praktikum Mobile-Entwicklung (iOS)',
    ),
    location: L('Alexandria, Egypt', 'Alexandria, Ägypten'),
    period: L('Jul 2020 – Sep 2020', 'Juli 2020 – Sep. 2020'),
    url: 'https://www.blink22.com/',
    iconAsset: 'assets/images/blink22_dark.png',
    bullets: [
      L(
        'Developed an ARKit image tracking app for product recognition.',
        'Entwicklung einer ARKit-Bilderkennungs-App zur Produkterkennung.',
      ),
      L(
        'Contributed to iOS apps using Swift and VIPER.',
        'Mitarbeit an iOS-Apps mit Swift und VIPER-Architektur.',
      ),
    ],
  ),
  Experience(
    company: 'ITSpark',
    role: L(
      'Mobile Development Internship (Flutter)',
      'Praktikum Mobile-Entwicklung (Flutter)',
    ),
    location: L('Alexandria, Egypt', 'Alexandria, Ägypten'),
    period: L('Jul 2019 – Sep 2019', 'Juli 2019 – Sep. 2019'),
    url: 'https://www.itspark-eg.com/',
    iconAsset: 'assets/images/itspark_dark.png',
    bullets: [
      L(
        'Converted an online pharmacy app from native Android to Flutter.',
        'Migration einer Online-Apotheken-App von nativem Android zu Flutter.',
      ),
      L(
        'Worked on a Flutter online market app.',
        'Mitarbeit an einer Flutter-Marktplatz-App.',
      ),
    ],
  ),
];
