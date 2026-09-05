import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_bloc.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';

class const QuoteThemeChips({
  required final List<QuoteTheme> _themes,
  required final Set<String> _selected,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: Spacing.xs,
        runSpacing: Spacing.xs,
        children: [
          for (final theme in _themes)
            if (_selected.contains(theme.id))
              SelectableChip(
                label: theme.name,
                selected: true,
                selectedColor: context.c.secondary,
                selectedTextColor: context.c.onSecondary,
                onTap: () => context.read<QuoteDetailBloc>().add(QuoteDetailThemeToggled(theme.id)),
              ),
          SelectableChip(
            label: context.s.quoteDetailAddThemeChip,
            selected: false,
            outlined: true,
            onTap: () => _showThemePicker(context),
          ),
        ],
      ),
    );
  }
}

Future<void> _showThemePicker(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _ThemePickerSheet()),
  );
}

class const _ThemePickerSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteDetailBloc, QuoteDetailState>(
      builder: (context, state) {
        if (state is! QuoteDetailLoaded) return const SizedBox.shrink();
        return SheetContent(
          children: [
            Text(context.s.quoteDetailThemePickerTitle, style: context.t.titleMedium),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: Spacing.xs,
                  runSpacing: Spacing.xs,
                  children: [
                    for (final theme in state.themes)
                      SelectableChip(
                        label: theme.name,
                        selected: state.selectedThemeIds.contains(theme.id),
                        selectedColor: context.c.secondary,
                        selectedTextColor: context.c.onSecondary,
                        onTap: () => context.read<QuoteDetailBloc>().add(
                          QuoteDetailThemeToggled(theme.id),
                        ),
                      ),
                    SelectableChip(
                      label: context.s.markingNewThemeChip,
                      selected: false,
                      outlined: true,
                      onTap: () => _promptNewTheme(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> _promptNewTheme(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  final name = await showNameInputDialog(
    context,
    title: context.s.themesNewThemeTitle,
    hint: context.s.themesNewThemeHint,
    confirmLabel: context.s.themesNewThemeButton,
  );
  if (name != null && name.trim().isNotEmpty) {
    bloc.add(QuoteDetailThemeCreateRequested(name));
  }
}
