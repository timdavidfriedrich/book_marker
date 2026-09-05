import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/widgets/uncertain_word_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/recognized_spread.dart';
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/page_dots.dart';

const _highlightPadding = 2.0;
const _pageCacheWidth = 1600;
const _highlightFillOpacity = 0.22;
const _selectionOpacity = 0.4;

class const PhotoMarkingView({
  required final List<SpreadPage> _pages,
  required final List<RecognizedWord> _words,
  required final Set<int> _selectedWordIndexes,
  required final ValueChanged<int> _onUncertainWordTap,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    final visiblePage = useState(0);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: _pages.length,
            onPageChanged: (index) => visiblePage.value = index,
            itemBuilder: (context, index) => _PhotoPage(
              page: _pages[index],
              pageIndex: index,
              words: _words,
              selectedWordIndexes: _selectedWordIndexes,
              onUncertainWordTap: _onUncertainWordTap,
            ),
          ),
        ),
        if (_pages.length > 1) ...[
          const SizedBox(height: Spacing.s),
          PageDots(count: _pages.length, index: visiblePage.value),
        ],
      ],
    );
  }
}

class const _PhotoPage({
  required final SpreadPage _page,
  required final int _pageIndex,
  required final List<RecognizedWord> _words,
  required final Set<int> _selectedWordIndexes,
  required final ValueChanged<int> _onUncertainWordTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * hoisted out of the layout builders below, which rerun the closure on every layout pass
    final groups = _words.wordGroups();
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: AspectRatio(
              aspectRatio: _page.aspectRatio,
              child: LayoutBuilder(
                builder: (context, pageConstraints) {
                  final size = pageConstraints.biggest;
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(
                          File(_page.imagePath),
                          cacheWidth: _pageCacheWidth,
                          fit: BoxFit.fill,
                        ),
                      ),
                      for (final group in groups)
                        if (group.number case final int number)
                          for (var member = 0; member < group.indexes.length; member++)
                            if (_words[group.indexes[member]].pageIndex == _pageIndex)
                              _UncertainHighlight(
                                word: _words[group.indexes[member]],
                                number: member == 0 ? number : null,
                                size: size,
                                onTap: () => _onUncertainWordTap(group.indexes.first),
                              ),
                      for (final index in _selectedWordIndexes)
                        if (index < _words.length && _words[index].pageIndex == _pageIndex)
                          _WordBox(word: _words[index], size: size),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _WordBox({
  required final RecognizedWord _word,
  required final Size _size,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _word.left * _size.width,
      top: _word.top * _size.height,
      width: _word.width * _size.width,
      height: _word.height * _size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.c.primary.withValues(alpha: _selectionOpacity)),
      ),
    );
  }
}

class const _UncertainHighlight({
  required final RecognizedWord _word,
  required final int? _number,
  required final Size _size,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.status.uncertain;
    return Positioned(
      left: _word.left * _size.width - _highlightPadding,
      top: _word.top * _size.height - _highlightPadding,
      width: _word.width * _size.width + _highlightPadding * 2,
      height: _word.height * _size.height + _highlightPadding * 2,
      child: Badge(
        isLabelVisible: _number != null,
        label: Text("${_number ?? 0}"),
        alignment: AlignmentDirectional.topEnd,
        offset: const Offset(uncertainBadgeSize / 2, -uncertainBadgeSize / 2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusS),
            border: Border.all(color: swatch.solid, width: Spacing.borderWidthThin),
          ),
          child: InkTapBox(
            onTap: _onTap,
            color: swatch.solid.withValues(alpha: _highlightFillOpacity),
            radius: Spacing.radiusS,
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}
