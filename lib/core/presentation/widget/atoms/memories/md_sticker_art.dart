import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_typography.dart';
import '../../../../domain/memories/enum/sticker_type.dart';

/// How a sticker looks: icon stickers are die-cut with a white border and a
/// soft shadow, stamps are handwritten on a little paper tag. Drawn from
/// the app's icon set and fonts — never emoji — so every sticker looks the
/// same on every phone. [size] is the sticker's width.
class MdStickerArt extends StatelessWidget {
  const MdStickerArt({super.key, required this.type, required this.size});

  final StickerType type;
  final double size;

  static (IconData, Color) _iconSticker(StickerType type) => switch (type) {
    StickerType.heart => (LucideIcons.heart, AppColors.warmCoral),
    StickerType.star => (LucideIcons.star, AppColors.filmYellow),
    StickerType.sparkle => (LucideIcons.sparkles, AppColors.filmYellow),
    StickerType.sun => (LucideIcons.sun, AppColors.filmYellow),
    StickerType.flower => (LucideIcons.flower2, AppColors.warmCoral),
    StickerType.camera => (LucideIcons.camera, AppColors.warmCharcoal),
    StickerType.party => (LucideIcons.partyPopper, AppColors.warmCoral),
    StickerType.crown => (LucideIcons.award, AppColors.filmYellow),
    StickerType.paw => (LucideIcons.pawPrint, AppColors.inkBrown),
    StickerType.music => (LucideIcons.music, AppColors.softGreen),
    _ => (LucideIcons.heart, AppColors.warmCoral),
  };

  @override
  Widget build(BuildContext context) {
    final stamp = type.stamp;
    if (stamp != null) {
      return Container(
        width: size * 1.6,
        padding: EdgeInsets.symmetric(
          horizontal: size * 0.12,
          vertical: size * 0.06,
        ),
        decoration: BoxDecoration(
          color: AppColors.paper,
          borderRadius: BorderRadius.circular(size * 0.08),
          border: Border.all(color: AppColors.warmCoral, width: size * 0.03),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
        ),
        child: FittedBox(
          child: Text(
            stamp,
            style: AppTypography.script.copyWith(
              color: AppColors.coralInk,
              fontSize: size * 0.4,
              height: 1.1,
            ),
          ),
        ),
      );
    }

    final (icon, color) = _iconSticker(type);
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.paper,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: size * 0.66, color: color),
    );
  }
}
