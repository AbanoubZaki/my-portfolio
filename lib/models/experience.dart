import '../l10n/l10n.dart';

/// Data model for a single timeline experience entry.
class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.location,
    required this.period,
    required this.bullets,
    this.url,
    this.iconAsset,
    this.iconHeight = 40,
  });

  final String company;
  final L role;
  final L location;
  final L period;
  final List<L> bullets;
  final String? url;
  final String? iconAsset;

  /// Rendered height of [iconAsset]; lets squarish logos match the visual
  /// weight of wide wordmarks.
  final double iconHeight;
}
