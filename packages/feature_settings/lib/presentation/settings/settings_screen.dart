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
import 'package:shared/presentation/widgets/profile_avatar.dart';

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
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.l),
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
                        context.s.settingsStats(
                          _state.bookCount,
                          _state.quoteCount,
                          _state.themeCount,
                        ),
                        style: context.typography.monoLabel.copyWith(
                          color: context.c.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.xl),
        Text(context.s.settingsAppearanceLabel, style: context.t.headlineSmall),
        const SizedBox(height: Spacing.s),
        _PreferenceMenu<ThemePreference>(
          label: context.s.settingsThemeLabel,
          selected: _state.themePreference,
          values: ThemePreference.values,
          labelOf: _themeLabel,
          onSelected: (preference) =>
              context.read<SettingsBloc>().add(SettingsThemeChanged(preference)),
        ),
        const SizedBox(height: Spacing.s),
        _PreferenceMenu<ContrastPreference>(
          label: context.s.settingsContrastLabel,
          selected: _state.contrastPreference,
          values: ContrastPreference.values,
          labelOf: _contrastLabel,
          onSelected: (preference) =>
              context.read<SettingsBloc>().add(SettingsContrastChanged(preference)),
        ),
        const SizedBox(height: Spacing.xl),
        Text(context.s.settingsLanguageLabel, style: context.t.headlineSmall),
        const SizedBox(height: Spacing.s),
        _PreferenceMenu<LocalePreference>(
          selected: _state.localePreference,
          values: LocalePreference.values,
          labelOf: _localeLabel,
          onSelected: (preference) =>
              context.read<SettingsBloc>().add(SettingsLocaleChanged(preference)),
        ),
        const SizedBox(height: Spacing.xl),
        Text(context.s.settingsAboutLabel, style: context.t.headlineSmall),
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

class const _PreferenceMenu<T>({
  required final T _selected,
  required final List<T> _values,
  required final String Function(BuildContext context, T value) _labelOf,
  required final ValueChanged<T> _onSelected,
  final String? _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: _selected,
      label: _label == null ? null : Text(_label),
      expandedInsets: EdgeInsets.zero,
      requestFocusOnTap: false,
      trailingIcon: Icon(Icons.expand_more, color: context.c.onSurfaceVariant),
      selectedTrailingIcon: Icon(Icons.expand_less, color: context.c.onSurfaceVariant),
      onSelected: (value) {
        if (value == null) return;
        _onSelected(value);
      },
      dropdownMenuEntries: [
        for (final value in _values)
          DropdownMenuEntry(value: value, label: _labelOf(context, value)),
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

String _themeLabel(BuildContext context, ThemePreference preference) => switch (preference) {
  ThemePreference.system => context.s.settingsThemeSystem,
  ThemePreference.light => context.s.settingsThemeLight,
  ThemePreference.dark => context.s.settingsThemeDark,
};

String _contrastLabel(BuildContext context, ContrastPreference preference) => switch (preference) {
  ContrastPreference.system => context.s.settingsContrastSystem,
  ContrastPreference.standard => context.s.settingsContrastStandard,
  ContrastPreference.high => context.s.settingsContrastHigh,
};
