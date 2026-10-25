import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The Kachi mark: two friends in cute animal hats, cheek to cheek in a
/// photobooth print — the same artwork as the app icon
/// (`assets/icon/app_icon.png`) and the launch screens.
///
/// This is the still version. [open], [develop] and [twinkle] are the
/// animatable moments (see `MdAnimatedKachiLogo`): the print tilts and pops
/// ([open]), settles in ([develop]) and gives a small happy pulse ([twinkle]).
/// The defaults are the finished, resting logo.
///
/// [size] is the canvas; the print itself fills [artFraction] of it, which
/// leaves room for the tilt and keeps the logo sized like it always was. Meant
/// for the coral brand surface.
class MdKachiLogo extends StatelessWidget {
  const MdKachiLogo({
    super.key,
    this.size = 240,
    this.open = 0,
    this.develop = 1,
    this.twinkle = 0,
    this.semanticLabel = 'Kachi',
  });

  final double size;

  final double open;

  final double develop;

  final double twinkle;

  final String? semanticLabel;

  /// How much of the canvas the print fills.
  static const artFraction = 0.72;

  static const _asset = 'assets/images/branding/kachi_logo.png';
  static const _tilt = 6 * math.pi / 180;

  @override
  Widget build(BuildContext context) {
    final art = SizedBox.square(
      dimension: size,
      child: Center(
        child: Transform.rotate(
          angle: _tilt * open,
          child: Transform.scale(
            scale: (0.94 + 0.06 * develop) * (1 + 0.06 * open + 0.04 * twinkle),
            child: Image.asset(
              _asset,
              width: size * artFraction,
              height: size * artFraction,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              // Decorative: the label below describes it once.
              excludeFromSemantics: true,
            ),
          ),
        ),
      ),
    );

    if (semanticLabel == null) return ExcludeSemantics(child: art);
    return Semantics(label: semanticLabel, image: true, child: art);
  }
}
