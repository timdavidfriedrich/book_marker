import 'package:core/config/build_config.dart';
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
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';
import 'package:shared/presentation/widgets/segmented_toggle.dart';

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
    final layout = context.layout;
    final margin = layout.pageMargin;
    final header = Row(
      children: [
        CircleIconButton(
          icon: Icons.arrow_back,
          tooltip: context.s.back,
          onPressed: context.closeScreen,
        ),
        const SizedBox(width: Spacing.s),
        Text(context.s.settingsTitle, style: context.t.displaySmall),
      ],
    );
    final profileAndAppearance = <Widget>[
      _ProfileCard(state: _state, controller: controller),
      const SizedBox(height: Spacing.xl),
      Text(context.s.settingsAppearanceLabel, style: context.t.headlineSmall),
      const SizedBox(height: Spacing.m),
      _PreferenceToggle<ThemePreference>(
        label: context.s.settingsColorSchemeLabel,
        selected: _state.themePreference,
        values: ThemePreference.values,
        labelOf: _colorSchemeLabel,
        onSelected: (preference) =>
            context.read<SettingsBloc>().add(SettingsThemeChanged(preference)),
      ),
      const SizedBox(height: Spacing.m),
      _PreferenceToggle<ContrastPreference>(
        label: context.s.settingsContrastLabel,
        selected: _state.contrastPreference,
        values: ContrastPreference.values,
        labelOf: _contrastLabel,
        onSelected: (preference) =>
            context.read<SettingsBloc>().add(SettingsContrastChanged(preference)),
      ),
    ];
    final languageAndAbout = <Widget>[
      Text(context.s.settingsLanguageLabel, style: context.t.headlineSmall),
      const SizedBox(height: Spacing.m),
      _PreferenceMenu<LocalePreference>(
        selected: _state.localePreference,
        values: LocalePreference.values,
        labelOf: _localeLabel,
        onSelected: (preference) =>
            context.read<SettingsBloc>().add(SettingsLocaleChanged(preference)),
      ),
      const SizedBox(height: Spacing.xl),
      Text(context.s.settingsAboutLabel, style: context.t.headlineSmall),
      const SizedBox(height: Spacing.m),
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
      if (isInDebugMode) ...[
        const SizedBox(height: Spacing.xl),
        Text(context.s.settingsDebugLabel, style: context.t.headlineSmall),
        const SizedBox(height: Spacing.m),
        FilledButton(
          onPressed: _state.hasSampleData
              ? null
              : () => context.read<SettingsBloc>().add(const SettingsSampleDataRequested()),
          child: Text(context.s.settingsSeedSampleDataButton),
        ),
      ],
    ];
    // * a landscape viewport is too short for one settings column, so the groups sit side by side
    if (layout.isLandscape) {
      return Padding(
        padding: EdgeInsets.fromLTRB(margin, margin, margin, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            const SizedBox(height: Spacing.l),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: Spacing.xl),
                      children: profileAndAppearance,
                    ),
                  ),
                  const SizedBox(width: Spacing.xl),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: Spacing.xl),
                      children: languageAndAbout,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    // * a settings list reads badly at full tablet width, so it keeps a centred measure
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.contentMaxWidth),
        child: ListView(
          padding: EdgeInsets.all(margin),
          children: [
            header,
            const SizedBox(height: Spacing.l),
            ...profileAndAppearance,
            const SizedBox(height: Spacing.xl),
            ...languageAndAbout,
          ],
        ),
      ),
    );
  }
}

class const _ProfileCard({
  required final SettingsLoaded _state,
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    controller: _controller,
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
    );
  }
}

class const _PreferenceToggle<T>({
  required final String _label,
  required final T _selected,
  required final List<T> _values,
  required final String Function(BuildContext context, T value) _labelOf,
  required final ValueChanged<T> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
          child: Text(
            _label,
            style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: Spacing.xs),
        SegmentedToggle(
          labels: [for (final value in _values) _labelOf(context, value)],
          selectedIndex: _values.indexOf(_selected),
          onChanged: (index) => _onSelected(_values[index]),
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
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: _selected,
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

String _colorSchemeLabel(BuildContext context, ThemePreference preference) => switch (preference) {
  ThemePreference.system => context.s.settingsColorSchemeSystem,
  ThemePreference.light => context.s.settingsColorSchemeLight,
  ThemePreference.dark => context.s.settingsColorSchemeDark,
};

String _contrastLabel(BuildContext context, ContrastPreference preference) => switch (preference) {
  ContrastPreference.system => context.s.settingsContrastSystem,
  ContrastPreference.standard => context.s.settingsContrastStandard,
  ContrastPreference.high => context.s.settingsContrastHigh,
};
