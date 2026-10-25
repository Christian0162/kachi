import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../domain/people/enum/mood.dart';

/// The icon that goes with each [Mood]. Kept out of the domain layer so it
/// stays free of Flutter UI. See CLAUDE.md §61.
extension MoodIcon on Mood {
  IconData get icon => switch (this) {
    Mood.happy => LucideIcons.smile,
    Mood.inLove => LucideIcons.heart,
    Mood.excited => LucideIcons.partyPopper,
    Mood.calm => LucideIcons.flower,
    Mood.tired => LucideIcons.moon,
    Mood.sad => LucideIcons.frown,
  };
}
