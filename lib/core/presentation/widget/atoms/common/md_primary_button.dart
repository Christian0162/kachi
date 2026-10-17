import 'package:flutter/material.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_spacing.dart';
import '../../../../utils/app_haptics.dart';
import 'md_pressable_scale.dart';

/// The app's primary call-to-action. Large, warm, one per screen. Presses
/// with a haptic tap and shows an inline spinner (and ignores taps) while
/// [loading].
class MdPrimaryButton extends StatelessWidget {
  const MdPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;
  final bool expand;

  /// Overrides the label colour (white on coral by default).
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !loading;

    final button = FilledButton(
      style: foregroundColor == null
          ? null
          : FilledButton.styleFrom(foregroundColor: foregroundColor),
      onPressed: enabled
          ? () {
              AppHaptics.tap();
              onPressed!();
            }
          : null,
      child: _ButtonContent(
        label: label,
        icon: icon,
        loading: loading,
        spinnerColor: foregroundColor ?? AppColors.onCoral,
      ),
    );

    final pressable = MdPressableScale(enabled: enabled, child: button);

    return expand
        ? SizedBox(width: double.infinity, child: pressable)
        : pressable;
  }
}

/// The quieter companion to [MdPrimaryButton]: Retake, Decline, Back, Cancel.
class MdSecondaryButton extends StatelessWidget {
  const MdSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
    this.onDark = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed == null
          ? null
          : () {
              AppHaptics.selection();
              onPressed!();
            },
      style: onDark
          ? OutlinedButton.styleFrom(
              foregroundColor: AppColors.onCamera,
              backgroundColor: AppColors.cameraScrim,
              side: const BorderSide(color: AppColors.onCameraMuted),
            )
          : OutlinedButton.styleFrom(backgroundColor: AppColors.paper),
      child: _ButtonContent(label: label, icon: icon),
    );

    return MdPressableScale(
      enabled: onPressed != null,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    this.icon,
    this.loading = false,
    this.spinnerColor,
  });

  final String label;
  final IconData? icon;
  final bool loading;
  final Color? spinnerColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: SizedBox.square(
              dimension: AppIconSizes.md,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: spinnerColor,
              ),
            ),
          )
        else if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: Icon(icon, size: AppIconSizes.md),
          ),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
