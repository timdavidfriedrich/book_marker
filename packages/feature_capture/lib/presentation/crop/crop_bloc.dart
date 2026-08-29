import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/page_detection_repository.dart';
import 'package:feature_capture/presentation/crop/crop_event.dart';
import 'package:feature_capture/presentation/crop/crop_state.dart';
import 'package:feature_capture/presentation/extensions/page_quad_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
    on<CropCornerMoved>(_onCornerMoved);
  }

  final PageDetectionRepository _pageDetectionRepository;
  final CropArguments _arguments;

  Future<void> _onStarted(CropStarted event, Emitter<CropState> emit) async {
    emit(const CropLoading());
    emit(switch (await _pageDetectionRepository.detectInImage(_arguments.imagePath)) {
      Success(:final data) => CropReady(
        imagePath: _arguments.imagePath,
        bookId: _arguments.bookId,
        aspectRatio: data.aspectRatio,
        quad: data.quad ?? _defaultQuad,
      ),
      Failure(:final error) => CropFailure(error: error),
    });
  }

  void _onCornerMoved(CropCornerMoved event, Emitter<CropState> emit) {
    if (state case final CropReady current) {
      final point = PagePoint(
        x: event.position.x.clamp(0.0, 1.0),
        y: event.position.y.clamp(0.0, 1.0),
      );
      emit(
        CropReady(
          imagePath: current.imagePath,
          bookId: current.bookId,
          aspectRatio: current.aspectRatio,
          quad: current.quad.withPointAt(event.corner, point),
        ),
      );
    }
  }
}
