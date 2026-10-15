import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_motion.dart';
import '../../../../../config/constant/app_shadows.dart';
import '../../../../../config/constant/app_spacing.dart';
import '../../../../../config/constant/app_typography.dart';
import '../../atoms/common/md_primary_button.dart';
import '../../atoms/common/md_soft_backdrop.dart';
import '../../organisms/common/md_app_scaffold.dart';

class _IntroPage {
  const _IntroPage({
    required this.animation,
    required this.title,
    required this.body,
    required this.tilt,
  });

  final String animation;
  final String title;
  final String body;
  final double tilt;
}

const _pages = [
  _IntroPage(
    animation: 'assets/animations/quest.lottie',
    title: 'Pick a quest',
    body:
        'Choose something fun to do in real life, with a friend, your '
        'family, or just you.',
    tilt: -0.06,
  ),
  _IntroPage(
    animation: 'assets/animations/selfie.lottie',
    title: 'Strike the pose',
    body:
        'The photobooth walks you through each shot with a countdown, so '
        'you can enjoy the moment.',
    tilt: 0.05,
  ),
  _IntroPage(
    animation: 'assets/animations/camera.lottie',
    title: 'Keep the memory',
    body:
        'Your photos become a private memory, shared only with the people '
        'who were there.',
    tilt: -0.04,
  ),
];

/// Three swipeable get-started pages shown once, before the welcome screen.
/// [onFinished] runs on "Get started" and on "Skip".
class IntroTemplate extends StatefulWidget {
  const IntroTemplate({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<IntroTemplate> createState() => _IntroTemplateState();
}

class _IntroTemplateState extends State<IntroTemplate> {
  final _controller = PageController();
  int _page = 0;

  bool get _isLast => _page == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MdAppScaffold(
      backgroundColor: AppColors.background,
      overlayStyle: SystemUiOverlayStyle.dark,
      body: Stack(
        children: [
          const Positioned.fill(child: MdSoftBackdrop()),
          Column(
            children: [
              // Kept in place on the last page so nothing jumps.
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.gutter,
                    AppSpacing.sm,
                    AppSpacing.sm,
                    0,
                  ),
                  child: AnimatedOpacity(
                    duration: AppMotion.of(context, AppMotion.short),
                    opacity: _isLast ? 0 : 1,
                    child: IgnorePointer(
                      ignoring: _isLast,
                      child: TextButton(
                        onPressed: widget.onFinished,
                        child: const Text('Skip'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (page) => setState(() => _page = page),
                  itemBuilder: (context, index) =>
                      _IntroPageView(page: _pages[index]),
                ),
              ),
              _PageDots(count: _pages.length, current: _page),
              // Fixed-height slot, kept empty until the last page shows the
              // "Get started" button, so nothing jumps.
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  AppSpacing.lg,
                  AppSpacing.gutter,
                  AppSpacing.xl,
                ),
                child: SizedBox(
                  height: 56,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: AppMotion.of(context, AppMotion.short),
                        opacity: _isLast ? 1 : 0,
                        child: IgnorePointer(
                          ignoring: !_isLast,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 260),
                            child: SizedBox(
                              width: double.infinity,
                              child: MdPrimaryButton(
                                label: 'Get started',
                                flat: true,
                                foregroundColor: Colors.white,
                                onPressed: widget.onFinished,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IntroPageView extends StatelessWidget {
  const _IntroPageView({required this.page});

  final _IntroPage page;

  @override
  Widget build(BuildContext context) {
    // Centred when there is room, scrolls on short screens or big text.
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExcludeSemantics(
                child: Transform.rotate(
                  angle: page.tilt,
                  child: Container(
                    width: 240,
                    height: 260,
                    decoration: BoxDecoration(
                      color: AppColors.softPeach,
                      borderRadius: BorderRadius.circular(AppRadius.base),
                      // A coral frame and a deeper shadow lift the card off
                      // the pink backdrop.
                      border: Border.all(color: AppColors.warmCoral, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.warmCoral.withValues(alpha: 0.35),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                        ...AppShadows.print,
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Lottie.asset(
                        page.animation,
                        fit: BoxFit.contain,
                        animate: !AppMotion.reduced(context),
                        errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Semantics(
                header: true,
                child: Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: AppTypography.heading1,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                page.body,
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.of(context, AppMotion.short);
    return Semantics(
      label: 'Page ${current + 1} of $count',
      excludeSemantics: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: duration,
              curve: AppMotion.standard,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              width: i == current ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == current
                    ? AppColors.warmCoral
                    : AppColors.warmCoral.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
        ],
      ),
    );
  }
}
