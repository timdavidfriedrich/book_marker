import 'package:core/config/build_config.dart';
import 'package:core/theme/corner_radii.dart';
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
import 'package:shared/presentation/widgets/segmented_toggle.dart';

const _avatarSize = 56.0;
const _groupRadius = Spacing.radiusXl;
const _groupGap = Spacing.xxxs;
const _actionButtonWidth = 72.0;
const _languageMenuWidth = 220.0;
const _tilePadding = EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.m);

class const SettingsScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => _Content(
            state: switch (state) {
              SettingsLoading() => null,
              SettingsLoaded() => state,
            },
          ),
        ),
      ),
    );
  }
}

class const _Content({
  required final SettingsLoaded? _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = _state;
    final controller = useTextEditingController(text: state?.displayName ?? "");
    // * the field is built before the name is loaded, so it adopts the value once it arrives
    useEffect(() {
      final name = state?.displayName ?? "";
      if (state != null && controller.text != name) controller.text = name;
      return null;
    }, [state?.displayName]);
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
    final appearance = <Widget>[
      _ProfileCard(state: state, controller: controller),
      const SizedBox(height: Spacing.xl),
      _SectionLabel(text: context.s.settingsAppearanceLabel),
      const SizedBox(height: Spacing.s),
      _ToggleTile<ThemePreference>(
        label: context.s.settingsColorSchemeLabel,
        selected: state?.themePreference,
        values: ThemePreference.values,
        labelOf: _colorSchemeLabel,
        isFirst: true,
        isLast: false,
        onSelected: (preference) =>
            context.read<SettingsBloc>().add(SettingsThemeChanged(preference)),
      ),
      const SizedBox(height: _groupGap),
      _ToggleTile<ContrastPreference>(
        label: context.s.settingsContrastLabel,
        selected: state?.contrastPreference,
        values: ContrastPreference.values,
        labelOf: _contrastLabel,
        isFirst: false,
        isLast: false,
        onSelected: (preference) =>
            context.read<SettingsBloc>().add(SettingsContrastChanged(preference)),
      ),
      const SizedBox(height: _groupGap),
      _LanguageTile(selected: state?.localePreference),
    ];
    final about = <Widget>[
      _SectionLabel(text: context.s.settingsAboutLabel),
      const SizedBox(height: Spacing.s),
      _LinkTile(
        label: context.s.settingsLicensesLabel,
        isFirst: true,
        isLast: false,
        onTap: () => showLicensePage(
          context: context,
          applicationName: context.s.appTitle,
          applicationVersion: version.data ?? "",
        ),
      ),
      const SizedBox(height: _groupGap),
      _ValueTile(
        label: context.s.settingsVersionLabel,
        value: version.data ?? "",
        isFirst: false,
        isLast: true,
      ),
      if (isInDebugMode) ...[
        const SizedBox(height: Spacing.xl),
        _SectionLabel(text: context.s.settingsDebugLabel),
        const SizedBox(height: Spacing.s),
        _SampleDataRow(hasSampleData: state?.hasSampleData ?? true),
      ],
    ];
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
                      children: appearance,
                    ),
                  ),
                  const SizedBox(width: Spacing.xl),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: Spacing.xl),
                      children: about,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.contentMaxWidth),
        child: ListView(
          padding: EdgeInsets.all(margin),
          children: [
            header,
            const SizedBox(height: Spacing.l),
            ...appearance,
            const SizedBox(height: Spacing.xl),
            ...about,
          ],
        ),
      ),
    );
  }
}

class const _SectionLabel({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(_text, style: context.t.headlineSmall);
  }
}

class const _GroupTile({
  required final Widget _child,
  required final bool _isFirst,
  required final bool _isLast,
  final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: context.c.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: CornerRadii.grouped(
          outer: _groupRadius,
          isFirst: _isFirst,
          isLast: _isLast,
        ),
      ),
      padding: _tilePadding,
      child: _child,
    );
  }
}

class const _ProfileCard({
  required final SettingsLoaded? _state,
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainer,
        borderRadius: BorderRadius.circular(_groupRadius),
      ),
      child: Row(
        children: [
          Container(
            width: _avatarSize,
            height: _avatarSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: Spacing.iconL,
              color: context.c.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  enabled: _state != null,
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
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: context.s.settingsProfileNameHint,
                    hintStyle: context.t.titleLarge?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  switch (_state) {
                    null => "",
                    final state => context.s.settingsStats(
                      state.bookCount,
                      state.quoteCount,
                      state.themeCount,
                    ),
                  },
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _ToggleTile<T>({
  required final String _label,
  required final T? _selected,
  required final List<T> _values,
  required final String Function(BuildContext context, T value) _labelOf,
  required final ValueChanged<T> _onSelected,
  required final bool _isFirst,
  required final bool _isLast,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _GroupTile(
      isFirst: _isFirst,
      isLast: _isLast,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_label, style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant)),
          const SizedBox(height: Spacing.xs),
          SegmentedToggle(
            labels: [for (final value in _values) _labelOf(context, value)],
            selectedIndex: _selected == null ? -1 : _values.indexOf(_selected),
            onChanged: (index) {
              if (_selected == null) return;
              _onSelected(_values[index]);
            },
          ),
        ],
      ),
    );
  }
}

class const _LanguageTile({
  required final LocalePreference? _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: const Offset(-_languageMenuWidth, _groupGap),
      style: MenuStyle(
        alignment: AlignmentDirectional.bottomEnd,
        backgroundColor: WidgetStatePropertyAll(context.c.surfaceContainerHigh),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(Spacing.elevationM),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(_groupRadius)),
          ),
        ),
      ),
      menuChildren: [
        for (final (index, value) in LocalePreference.values.indexed)
          _LanguageMenuItem(
            value: value,
            isSelected: value == _selected,
            isFirst: index == 0,
            isLast: index == LocalePreference.values.length - 1,
            onPressed: () => context.read<SettingsBloc>().add(SettingsLocaleChanged(value)),
          ),
      ],
      builder: (context, controller, child) => _GroupTile(
        isFirst: false,
        isLast: true,
        onTap: _selected == null
            ? null
            : () => controller.isOpen ? controller.close() : controller.open(),
        child: Row(
          children: [
            Text(
              context.s.settingsLanguageLabel,
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(width: Spacing.s),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  switch (_selected) {
                    null => "",
                    final selected => _localeValue(context, selected),
                  },
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.titleMedium,
                ),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            Icon(Icons.expand_more, size: Spacing.iconM, color: context.c.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class const _LanguageMenuItem({
  required final LocalePreference _value,
  required final bool _isSelected,
  required final bool _isFirst,
  required final bool _isLast,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _languageMenuWidth,
      child: MenuItemButton(
        onPressed: _onPressed,
        style: MenuItemButton.styleFrom(
          backgroundColor: _isSelected ? context.c.surfaceContainerHighest : Colors.transparent,
          foregroundColor: context.c.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.s),
          shape: RoundedRectangleBorder(
            borderRadius: CornerRadii.grouped(
              outer: _groupRadius,
              isFirst: _isFirst,
              isLast: _isLast,
            ),
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            _localeValue(context, _value),
            style: _isSelected ? context.t.titleMedium : context.t.bodyLarge,
          ),
        ),
      ),
    );
  }
}

class const _LinkTile({
  required final String _label,
  required final VoidCallback _onTap,
  required final bool _isFirst,
  required final bool _isLast,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _GroupTile(
      isFirst: _isFirst,
      isLast: _isLast,
      onTap: _onTap,
      child: Row(
        children: [
          Expanded(child: Text(_label, style: context.t.titleMedium)),
          Icon(Icons.chevron_right, size: Spacing.iconM, color: context.c.onSurfaceVariant),
        ],
      ),
    );
  }
}

class const _ValueTile({
  required final String _label,
  required final String _value,
  required final bool _isFirst,
  required final bool _isLast,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _GroupTile(
      isFirst: _isFirst,
      isLast: _isLast,
      child: Row(
        children: [
          Expanded(
            child: Text(
              _label,
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ),
          Text(
            _value,
            style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class const _SampleDataRow({
  required final bool _hasSampleData,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onTap = _hasSampleData
        ? null
        : () => context.read<SettingsBloc>().add(const SettingsSampleDataRequested());
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: InkTapBox(
              onTap: onTap,
              color: context.c.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: CornerRadii.grouped(
                  outer: _groupRadius,
                  isFirst: true,
                  isLast: false,
                  axis: Axis.horizontal,
                ),
              ),
              padding: _tilePadding,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  context.s.settingsSeedSampleDataButton,
                  style: context.t.titleMedium?.copyWith(
                    color: _hasSampleData ? context.c.onSurfaceVariant : context.c.onSurface,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: _groupGap),
          SizedBox(
            width: _actionButtonWidth,
            child: InkTapBox(
              onTap: onTap,
              color: _hasSampleData ? context.c.surfaceContainerHigh : context.c.primary,
              shape: RoundedRectangleBorder(
                borderRadius: CornerRadii.grouped(
                  outer: _groupRadius,
                  isFirst: false,
                  isLast: true,
                  axis: Axis.horizontal,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  size: Spacing.iconM,
                  color: _hasSampleData ? context.c.onSurfaceVariant : context.c.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
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

String _localeValue(BuildContext context, LocalePreference preference) => switch (preference) {
  LocalePreference.system => context.s.settingsLanguageSystemValue(_resolvedLocaleLabel(context)),
  _ => _localeLabel(context, preference),
};

String _resolvedLocaleLabel(BuildContext context) {
  return switch (Localizations.localeOf(context).languageCode) {
    "de" => context.s.settingsLanguageGerman,
    _ => context.s.settingsLanguageEnglish,
  };
}

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
