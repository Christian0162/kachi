import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Human-facing labels and icons for stored enum-like values, so screens
/// never show raw values like `close_up` or `family`, and every screen
/// describes the same value the same way.

/// Quest participation models (`quests.type`).
const questTypes = [
  ('solo', 'Just me', LucideIcons.user),
  ('pair', 'The two of us', LucideIcons.heart),
  ('group', 'A group', LucideIcons.users),
];

String questTypeLabel(String type) => _lookup(questTypes, type).$2;
IconData questTypeIcon(String type) => _lookup(questTypes, type).$3;

/// Shot framings (`quest_shots.shot_type`).
const shotTypes = [
  ('group', 'Group', LucideIcons.users),
  ('solo', 'Solo', LucideIcons.user),
  ('candid', 'Candid', LucideIcons.smile),
  ('close_up', 'Close-up', LucideIcons.scan),
  ('wide', 'Wide', LucideIcons.mountain),
];

String shotTypeLabel(String type) => _lookup(shotTypes, type).$2;
IconData shotTypeIcon(String type) => _lookup(shotTypes, type).$3;

/// Relationship types a person can be added with (`people.type`). `self`
/// is created by the app for the device owner, never picked by hand.
const personTypes = [
  ('partner', 'Partner', LucideIcons.heart),
  ('family', 'Family', LucideIcons.users),
  ('friend', 'Friend', LucideIcons.personStanding),
  ('pet', 'Pet', LucideIcons.pawPrint),
  ('other', 'Someone else', LucideIcons.user),
];

String personTypeLabel(String type) =>
    type == 'self' ? 'You' : _lookup(personTypes, type).$2;
IconData personTypeIcon(String type) => _lookup(personTypes, type).$3;

/// Heading for a group of people of one type on the People screen.
String personGroupLabel(String type) => switch (type) {
  'partner' => 'Your person',
  'family' => 'Family',
  'friend' => 'Friends',
  'pet' => 'Pets',
  _ => 'Everyone else',
};

/// What kind of day a memory was — "Anniversary", "Birthday", "Family
/// day" — with a matching icon for its card. Read from the memory's title
/// first (it's the most specific), then its quest's category.
(String, IconData) memoryOccasion(String title, String? category) {
  bool has(String text, List<String> words) =>
      words.any(text.toLowerCase().contains);

  for (final text in [title, category ?? '']) {
    if (has(text, ['anniversary'])) {
      return ('Anniversary', LucideIcons.heart);
    }
    if (has(text, ['birthday', 'bday'])) {
      return ('Birthday', LucideIcons.cakeSlice);
    }
    if (has(text, ['christmas', 'holiday', 'new year'])) {
      return ('Holiday', LucideIcons.treePine);
    }
    if (has(text, ['date'])) return ('Date night', LucideIcons.wine);
    if (has(text, ['wedding'])) return ('Wedding', LucideIcons.gem);
    if (has(text, ['trip', 'weekend', 'lake', 'beach', 'adventure'])) {
      return ('Getaway', LucideIcons.luggage);
    }
    if (has(text, ['dog', 'cat', 'pet', 'park'])) {
      return ('Pet day', LucideIcons.pawPrint);
    }
    if (has(text, ['family'])) {
      return ('Family day', LucideIcons.users);
    }
    if (has(text, ['friend'])) {
      return ('Friends day', LucideIcons.partyPopper);
    }
    if (has(text, ['for us', 'couple', 'love'])) {
      return ('Us day', LucideIcons.heart);
    }
    if (has(text, ['for me', 'just me', 'solo'])) {
      return ('Me time', LucideIcons.flower2);
    }
  }
  return ('Good day', LucideIcons.sun);
}

/// A friendly icon for a quest category ("For Us", "Birthday", ...).
IconData questCategoryIcon(String category) {
  final c = category.toLowerCase();
  if (c.contains('us') || c.contains('date')) return LucideIcons.heart;
  if (c.contains('family')) return LucideIcons.users;
  if (c.contains('friend')) return LucideIcons.partyPopper;
  if (c.contains('memory')) return LucideIcons.sparkles;
  if (c.contains('me')) return LucideIcons.flower2;
  if (c.contains('birthday')) return LucideIcons.cakeSlice;
  if (c.contains('adventure')) return LucideIcons.footprints;
  if (c.contains('funny')) return LucideIcons.smile;
  return LucideIcons.sparkles;
}

(String, String, IconData) _lookup(
  List<(String, String, IconData)> options,
  String value,
) {
  return options.firstWhere((o) => o.$1 == value, orElse: () => options.last);
}

/// The example photo, where to focus it, and a short line for a quest
/// category — so "For Us" or "Birthday" shows what that kind of memory looks
/// like. Built-in categories map directly; custom ones by keyword. Null when
/// nothing fits (callers fall back to illustrated art). Credits:
/// `assets/images/quests/CREDITS.md`.
({String asset, Alignment focus, String tagline})? questCategoryExample(
  String category,
) {
  const dir = 'assets/images/quests';
  final c = category.toLowerCase();
  // Whole words, so "Just" isn't "us" and "Memory" isn't "me".
  final words = c.split(RegExp(r'[^a-z]+')).toSet();
  if (words.contains('us') || c.contains('date') || c.contains('anniversary')) {
    return (
      asset: '$dir/for_us.jpg',
      focus: const Alignment(0, -0.3),
      tagline: 'Just the two of you',
    );
  }
  if (c.contains('family') || c.contains('holiday')) {
    return (
      asset: '$dir/for_family.jpg',
      focus: const Alignment(0, 0.1),
      tagline: 'Everyone, all together',
    );
  }
  if (c.contains('friend') || c.contains('birthday') || c.contains('funny')) {
    return (
      asset: '$dir/for_friends.jpg',
      focus: Alignment.center,
      tagline: 'Your people, being silly',
    );
  }
  if (c.contains('memory') || c.contains('life') || c.contains('adventure')) {
    return (
      asset: '$dir/for_life.jpg',
      focus: const Alignment(0, 0.35),
      tagline: 'The ordinary days, too',
    );
  }
  if (words.contains('me') || c.contains('solo')) {
    return (
      asset: '$dir/for_me.jpg',
      focus: const Alignment(0, -0.5),
      tagline: 'A little time for you',
    );
  }
  return null;
}
