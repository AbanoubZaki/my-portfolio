# Portfolio — Abanoub Michael

Personal portfolio website for Abanoub Michael, Software Development Engineer.
A single-page, responsive, bilingual (English / German) site built with Flutter web.

## Stack

- **Flutter web** (managed via [FVM](https://fvm.app/))
- [`google_fonts`](https://pub.dev/packages/google_fonts) — Syne / Sora / DM Sans typography
- [`flutter_animate`](https://pub.dev/packages/flutter_animate) — entrance & reveal animations
- [`flutter_svg`](https://pub.dev/packages/flutter_svg) — vector logos
- [`url_launcher`](https://pub.dev/packages/url_launcher) — external / mailto / tel links
- [`visibility_detector`](https://pub.dev/packages/visibility_detector) — scroll-reveal triggers

## Project layout

```
lib/
  main.dart            # App shell, scroll controller, section keys
  l10n/                # Bilingual (EN/DE) string helpers
  theme/               # Colors + text styles
  models/ data/        # Project & experience content
  widgets/             # Hero, About, Skills, Experience, Projects, Contact, NavBar, Footer
```

## Running locally

```bash
fvm flutter pub get
fvm flutter run -d chrome
```

## Build & test

```bash
fvm flutter analyze
fvm flutter test
fvm flutter build web --release
```
