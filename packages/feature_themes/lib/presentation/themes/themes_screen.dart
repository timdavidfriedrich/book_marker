import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';

class const ThemesScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.l, Spacing.l, Spacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.s.themesTitle, style: context.t.displaySmall),
                        const SizedBox(height: Spacing.xxs),
                        Text(
                          context.s.themesSubtitlePlaceholder,
                          style: context.typography.monoLabel
                              .copyWith(color: context.c.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const ProfileAvatar(),
                ],
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
                  child: Text(
                    context.s.themesPlaceholderMessage,
                    textAlign: TextAlign.center,
                    style: context.typography.readingBody
                        .copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
