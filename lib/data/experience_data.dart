import '../l10n/l10n.dart';
import '../models/experience.dart';

const List<Experience> kExperiences = [
  Experience(
    company: 'GLI Global Lean Industry 4.0',
    role: L(
      'Software Development Team Leader (Flutter)',
      'Teamleiter Softwareentwicklung (Flutter)',
    ),
    location: L('Dubai, UAE', 'Dubai, VAE'),
    period: L('Jan 2022 – Present', 'Jan. 2022 – heute'),
    url: 'https://grwangroup.com/',
    iconAsset: 'assets/images/gli_dark.png',
    iconHeight: 56,
    bullets: [
      L(
        'Led a team of 10+ developers across concurrent Flutter projects, ensuring on-time, high-quality delivery.',
        'Leitung eines Teams von über 10 Entwicklern in parallelen Flutter-Projekten mit termingerechter Lieferung in hoher Qualität.',
      ),
      L(
        'Refactored legacy codebases of LeanGo Dashboard and LeanGo CIL applications.',
        'Refactoring der Legacy-Codebasis der Anwendungen LeanGo Dashboard und LeanGo CIL.',
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
    company: 'Blink22',
    role: L(
      'Full-time Software Development Engineer (Flutter & Native iOS)',
      'Software Development Engineer in Vollzeit (Flutter & natives iOS)',
    ),
    location: L('Dubai, UAE', 'Dubai, VAE'),
    period: L('Aug 2021 – Mar 2026', 'Aug. 2021 – März 2026'),
    url: 'https://www.blink22.com/',
    iconAsset: 'assets/images/blink22_dark.png',
    bullets: [
      L(
        'Developed mobile applications using Flutter with Provider and Bloc state management.',
        'Entwicklung mobiler Anwendungen mit Flutter und State-Management über Provider und Bloc.',
      ),
      L(
        'Applied Clean Architecture for scalable, maintainable app structure.',
        'Einsatz von Clean Architecture für eine skalierbare und wartbare App-Struktur.',
      ),
      L(
        'Optimized performance across multiple Flutter & iOS projects.',
        'Performance-Optimierung über mehrere Flutter- und iOS-Projekte hinweg.',
      ),
      L(
        'Collaborated with cross-functional teams to achieve project goals.',
        'Zusammenarbeit mit interdisziplinären Teams zur Erreichung der Projektziele.',
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
    period: L('Jul 2025 – Sep 2025', 'Juli 2025 – Sep. 2025'),
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
        'Developed an ARKit image tracking application for product recognition.',
        'Entwicklung einer ARKit-Bilderkennungs-App zur Produkterkennung.',
      ),
      L(
        'Contributed to iOS apps using Swift and VIPER Architecture.',
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
        'Converted an online pharmacy app from native Android to Flutter cross-platform.',
        'Migration einer Online-Apotheken-App von nativem Android zu plattformübergreifendem Flutter.',
      ),
      L(
        'Worked on a Flutter online market application for home ordering.',
        'Mitarbeit an einer Flutter-Marktplatz-App für Bestellungen von zu Hause aus.',
      ),
    ],
  ),
];
