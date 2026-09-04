import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/repositories/page_detection_repository.dart';
import 'package:feature_capture/presentation/crop/crop_event.dart';
import 'package:feature_capture/presentation/crop/crop_state.dart';
import 'package:feature_capture/presentation/extensions/page_quad_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/crop_page.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/presentation/navigation/crop_arguments.dart';

const _defaultInset = 0.08;
const _defaultQuad = PageQuad(
  topLeft: PagePoint(x: _defaultInset, y: _defaultInset),
  topRight: PagePoint(x: 1 - _defaultInset, y: _defaultInset),
  bottomRight: PagePoint(x: 1 - _defaultInset, y: 1 - _defaultInset),
  bottomLeft: PagePoint(x: _defaultInset, y: 1 - _defaultInset),
);

@injectable
class CropBloc extends Bloc<CropEvent, CropState> {
  CropBloc(
    this._pageDetectionRepository,
    @factoryParam this._arguments,
  ) : super(const CropLoading()) {
    on<CropStarted>(_onStarted);
    on<CropPagesAdded>(_onPagesAdded);
    on<CropPageSelected>(_onPageSelected);
    on<CropPageRemoved>(_onPageRemoved);
    on<CropPageRotated>(_onPageRotated);
    on<CropPageMoved>(_onPageMoved);
    on<CropCornerMoved>(_onCornerMoved);
  }

  final PageDetectionRepository _pageDetectionRepository;
  final CropArguments _arguments;
  List<CropPage> _pages = const [];
  int _selectedIndex = 0;
  bool _hasAdjusted = false;

  Future<void> _onStarted(CropStarted event, Emitter<CropState> emit) async {
    emit(const CropLoading());
    if (_arguments.imagePaths.isEmpty) {
      emit(const CropFailure(error: UnexpectedError()));
      return;
    }
    switch (await _detect(_unknownPaths(_arguments.imagePaths))) {
      case Failure(:final error):
        emit(CropFailure(error: error));
      case Success(:final data):
        _pages = data;
        _selectedIndex = 0;
        emit(_ready());
    }
  }

  Future<void> _onPagesAdded(CropPagesAdded event, Emitter<CropState> emit) async {
    if (state is! CropReady) return;
    final imagePaths = _unknownPaths(event.imagePaths);
    if (imagePaths.isEmpty) return;
    emit(_ready(isAdding: true));
    switch (await _detect(imagePaths)) {
      case Failure(:final error):
        emit(_ready(addError: error));
      case Success(:final data):
        _pages = [..._pages, ...data];
        _selectedIndex = _pages.length - 1;
        emit(_ready());
    }
  }

  void _onPageSelected(CropPageSelected event, Emitter<CropState> emit) {
    if (event.index < 0 || event.index >= _pages.length) return;
    _selectedIndex = event.index;
    if (state is CropReady) emit(_ready());
  }

  void _onPageRemoved(CropPageRemoved event, Emitter<CropState> emit) {
    if (_pages.length <= 1) return;
    if (event.index < 0 || event.index >= _pages.length) return;
    _pages = [..._pages]..removeAt(event.index);
    _selectedIndex = _selectedIndex.clamp(0, _pages.length - 1);
    if (state is CropReady) emit(_ready());
  }

  void _onPageRotated(CropPageRotated event, Emitter<CropState> emit) {
    if (state is! CropReady) return;
    _pages = [..._pages]..[_selectedIndex] = _pages[_selectedIndex].turnedClockwise();
    emit(_ready());
  }

  void _onPageMoved(CropPageMoved event, Emitter<CropState> emit) {
    if (event.fromIndex < 0 || event.fromIndex >= _pages.length) return;
    if (event.toIndex < 0 || event.toIndex >= _pages.length) return;
    if (event.fromIndex == event.toIndex) return;
    final selected = _pages[_selectedIndex];
    final pages = [..._pages];
    pages.insert(event.toIndex, pages.removeAt(event.fromIndex));
    _pages = pages;
    _selectedIndex = pages.indexOf(selected);
    if (state is CropReady) emit(_ready());
  }

  void _onCornerMoved(CropCornerMoved event, Emitter<CropState> emit) {
    if (state is! CropReady) return;
    final point = PagePoint(
      x: event.position.x.clamp(0.0, 1.0),
      y: event.position.y.clamp(0.0, 1.0),
    );
    final page = _pages[_selectedIndex];
    _pages = [..._pages]
      ..[_selectedIndex] = page.adjustedTo(page.quad.withPointAt(event.corner, point));
    _hasAdjusted = true;
    emit(_ready());
  }

  List<String> _unknownPaths(List<String> imagePaths) {
    return [
      for (final imagePath in imagePaths.toSet())
        if (_pages.every((page) => page.imagePath != imagePath)) imagePath,
    ];
  }

  Future<AppResult<List<CropPage>>> _detect(List<String> imagePaths) async {
    final pages = <CropPage>[];
    for (final imagePath in imagePaths) {
      switch (await _pageDetectionRepository.detectInImage(imagePath)) {
        case Failure(:final error):
          return Failure(error);
        case Success(:final data):
          pages.add(
            CropPage(
              imagePath: imagePath,
              aspectRatio: data.aspectRatio,
              quad: data.quad ?? _defaultQuad,
              confidence: data.confidence,
              isAdjusted: false,
              quarterTurns: 0,
            ),
          );
      }
    }
    return Success(pages);
  }

  CropReady _ready({bool isAdding = false, AppError? addError}) {
    return CropReady(
      pages: _pages,
      selectedIndex: _selectedIndex,
      hasAdjusted: _hasAdjusted,
      isAdding: isAdding,
      addError: addError,
    );
  }
}
