import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: context.tr('Built with ', 'Erstellt mit ')),
              const TextSpan(text: '❤️'),
              const TextSpan(text: ' · Abanoub Michael · 2026'),
            ],
            style: AppText.body(14),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
