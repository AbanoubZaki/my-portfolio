import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

/// How the project image should be presented inside the card image area.
enum ProjectImageMode {
  /// No asset yet — render a colored gradient placeholder.
  placeholder,

  /// Cover the whole image area (full bleed).
  cover,

  /// Contain with padding on the given background color.
  contain,
}

/// Platform a [SubApp] link points to.
enum AppPlatform { android, ios, web }

/// A store / web link for a single [SubApp].
class AppLink {
  const AppLink(this.platform, this.url);
  final AppPlatform platform;
  final String url;
}

/// A single app within a multi-app project suite (e.g. LeanGo Platform).
class SubApp {
  const SubApp({
    required this.name,
    required this.purpose,
    this.iconAsset,
    this.links = const [],
  });
  final String name;
  final L purpose;

  /// Optional square logo/icon (png or svg). Falls back to an accent dot.
  final String? iconAsset;

  /// Store / web links — Android & iOS for mobile apps, Web for dashboards.
  final List<AppLink> links;

  bool get isSvgIcon => iconAsset != null && iconAsset!.toLowerCase().endsWith('.svg');
}

/// A link to an app store with the badge asset to render.
class StoreLink {
  const StoreLink({
    required this.label,
    required this.url,
    required this.iconAsset,
  });

  final String label;
  final String url;
  final String iconAsset; // e.g. assets/images/apple.png
}

/// Data model for a single portfolio project.
class Project {
  const Project({
    required this.name,
    required this.type,
    required this.period,
    required this.accent,
    required this.description,
    required this.highlights,
    required this.tags,
    this.imageAsset,
    this.imageMode = ProjectImageMode.placeholder,
    this.imageBackground,
    this.imagePadding,
    this.backdropAsset,
    this.stores = const [],
    this.apps = const [],
  });

  final String name;
  final L type;
  final L period;
  final Color accent;
  final L description;
  final List<L> highlights;
  final List<String> tags;

  /// Asset path of the cover/logo image (nullable -> placeholder).
  final String? imageAsset;
  final ProjectImageMode imageMode;
  final Color? imageBackground;

  /// Optional override for the inner padding around a contained image/logo.
  final EdgeInsets? imagePadding;

  /// Optional photo rendered behind the logo in the featured card's left panel
  /// (e.g. a city skyline). The logo sits on a floating tile over a scrim.
  final String? backdropAsset;
  final List<StoreLink> stores;

  /// Apps within a suite — rendered as compact chips on the card.
  final List<SubApp> apps;

  bool get isSvg => imageAsset != null && imageAsset!.toLowerCase().endsWith('.svg');
}
