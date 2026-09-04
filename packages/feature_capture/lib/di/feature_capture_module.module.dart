// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_capture/data/data_sources/camera_data_source.dart'
    as _i160;
import 'package:feature_capture/data/data_sources/gallery_data_source.dart'
    as _i13;
import 'package:feature_capture/data/data_sources/jpeg_encoder_data_source.dart'
    as _i483;
import 'package:feature_capture/data/data_sources/page_image_cropper.dart'
    as _i556;
import 'package:feature_capture/data/data_sources/spell_check_data_source.dart'
    as _i972;
import 'package:feature_capture/data/repositories/camera_repository_impl.dart'
    as _i629;
import 'package:feature_capture/data/repositories/page_detection_repository_impl.dart'
    as _i490;
import 'package:feature_capture/data/repositories/text_recognition_repository_impl.dart'
    as _i23;
import 'package:feature_capture/domain/repositories/camera_repository.dart'
    as _i946;
import 'package:feature_capture/domain/repositories/page_detection_repository.dart'
    as _i567;
import 'package:feature_capture/domain/repositories/text_recognition_repository.dart'
    as _i653;
import 'package:feature_capture/domain/use_cases/recognize_captured_page_use_case.dart'
    as _i204;
import 'package:feature_capture/domain/use_cases/recognize_captured_spread_use_case.dart'
    as _i431;
import 'package:feature_capture/domain/use_cases/save_quote_use_case.dart'
    as _i396;
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart'
    as _i796;
import 'package:feature_capture/presentation/capture/camera_cubit.dart'
    as _i741;
import 'package:feature_capture/presentation/capture/page_detection_cubit.dart'
    as _i1072;
import 'package:feature_capture/presentation/crop/crop_bloc.dart' as _i975;
import 'package:feature_capture/presentation/marking/marking_bloc.dart'
    as _i1073;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/quote_repository.dart' as _i570;
import 'package:shared/domain/repositories/theme_repository.dart' as _i640;
import 'package:shared/presentation/navigation/crop_arguments.dart' as _i1040;
import 'package:shared/presentation/navigation/marking_arguments.dart' as _i851;

class FeatureCapturePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i160.CameraDataSource>(() => const _i160.CameraDataSource());
    gh.factory<_i13.GalleryDataSource>(() => const _i13.GalleryDataSource());
    gh.factory<_i483.JpegEncoderDataSource>(
        () => const _i483.JpegEncoderDataSource());
    gh.factory<_i556.PageImageCropper>(
        () => _i556.PageImageCropper(gh<_i483.JpegEncoderDataSource>()));
    gh.factory<_i567.PageDetectionRepository>(
        () => _i490.PageDetectionRepositoryImpl(gh<_i556.PageImageCropper>()));
    gh.factory<_i946.CameraRepository>(() => _i629.CameraRepositoryImpl(
          gh<_i160.CameraDataSource>(),
          gh<_i13.GalleryDataSource>(),
        ));
    gh.lazySingleton<_i972.SpellCheckDataSource>(
        () => _i972.SpellCheckDataSourceImpl());
    gh.factoryParam<_i975.CropBloc, _i1040.CropArguments, dynamic>((
      _arguments,
      _,
    ) =>
        _i975.CropBloc(
          gh<_i567.PageDetectionRepository>(),
          _arguments,
        ));
    gh.factory<_i796.AddBookBloc>(
        () => _i796.AddBookBloc(gh<_i748.BookRepository>()));
    gh.factory<_i396.SaveQuoteUseCase>(() => _i396.SaveQuoteUseCase(
          gh<_i570.QuoteRepository>(),
          gh<_i748.BookRepository>(),
        ));
    gh.factory<_i1072.PageDetectionCubit>(
        () => _i1072.PageDetectionCubit(gh<_i567.PageDetectionRepository>()));
    gh.factory<_i653.TextRecognitionRepository>(() =>
        _i23.TextRecognitionRepositoryImpl(gh<_i972.SpellCheckDataSource>()));
    gh.factory<_i741.CameraCubit>(
        () => _i741.CameraCubit(gh<_i946.CameraRepository>()));
    gh.factory<_i204.RecognizeCapturedPageUseCase>(
        () => _i204.RecognizeCapturedPageUseCase(
              gh<_i567.PageDetectionRepository>(),
              gh<_i653.TextRecognitionRepository>(),
            ));
    gh.factory<_i431.RecognizeCapturedSpreadUseCase>(() =>
        _i431.RecognizeCapturedSpreadUseCase(
            gh<_i204.RecognizeCapturedPageUseCase>()));
    gh.factoryParam<_i1073.MarkingBloc, _i851.MarkingArguments, dynamic>((
      _arguments,
      _,
    ) =>
        _i1073.MarkingBloc(
          gh<_i431.RecognizeCapturedSpreadUseCase>(),
          gh<_i396.SaveQuoteUseCase>(),
          gh<_i748.BookRepository>(),
          gh<_i640.ThemeRepository>(),
          _arguments,
        ));
  }
}
