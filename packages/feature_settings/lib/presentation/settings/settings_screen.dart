import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings/settings_bloc.dart';
import 'package:feature_settings/presentation/settings/settings_event.dart';
import 'package:feature_settings/presentation/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';
import 'package:shared/presentation/widgets/section_label.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';

const _avatarSize = 64.0;

class const SettingsScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => switch (state) {
            SettingsLoading() => const Center(child: CircularProgressIndicator()),
            SettingsLoaded() => _Content(state: state),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final SettingsLoaded _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _state.displayName ?? "");
    final version = useFuture(useMemoized(_loadVersion));
    return ListView(
      padding: const EdgeInsets.all(Spacing.l),
      children: [
        Row(
          children: [
            CircleIconButton(
              icon: Icons.arrow_back,
              tooltip: context.s.back,
              onPressed: context.closeScreen,
            ),
            const SizedBox(width: Spacing.s),
            Text(context.s.settingsTitle, style: context.t.displaySmall),
          ],
        ),
        const SizedBox(height: Spacing.l),
        PaperCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileAvatar(size: _avatarSize),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      textCapitalization: TextCapitalization.words,
                      style: context.t.titleLarge,
                      onChanged: (value) =>
                          context.read<SettingsBloc>().add(SettingsNameChanged(value)),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: context.s.settingsProfileNameHint,
                      ),
                    ),
                    const SizedBox(height: Spacing.xxs),
                    Text(
                      context.s.settingsStats(_state.bookCount, _state.quoteCount, _state.themeCount),
                      style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.xl),
        SectionLabel(text: context.s.settingsLanguageLabel, dotColor: context.palette.teal.solid),
        const SizedBox(height: Spacing.s),
        Wrap(
          spacing: Spacing.xs,
          runSpacing: Spacing.xs,
          children: [
            for (final preference in LocalePreference.values)
              SelectableChip(
                label: _localeLabel(context, preference),
                selected: _state.localePreference == preference,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context.read<SettingsBloc>().add(SettingsLocaleChanged(preference)),
              ),
          ],
        ),
        const SizedBox(height: Spacing.xl),
        SectionLabel(text: context.s.settingsAboutLabel, dotColor: context.palette.coral.solid),
        const SizedBox(height: Spacing.s),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
          child: Text(
            context.s.settingsVersionLabel(version.data ?? ""),
            style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: Spacing.xs),
        InkTapBox(
          radius: Spacing.radiusM,
          padding: const EdgeInsets.all(Spacing.m),
          onTap: () => showLicensePage(
            context: context,
            applicationName: context.s.appTitle,
            applicationVersion: version.data ?? "",
          ),
          child: Row(
            children: [
              Icon(Icons.description_outlined, size: Spacing.iconM, color: context.c.onSurface),
              const SizedBox(width: Spacing.s),
              Text(context.s.settingsLicensesLabel, style: context.t.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}

Future<String> _loadVersion() async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
}

String _localeLabel(BuildContext context, LocalePreference preference) => switch (preference) {
  LocalePreference.system => context.s.settingsLanguageSystem,
  LocalePreference.english => context.s.settingsLanguageEnglish,
  LocalePreference.german => context.s.settingsLanguageGerman,
};
