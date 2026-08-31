// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_capture/data/page_detection_repository_impl.dart' as _i921;
import 'package:feature_capture/data/spell_check_data_source.dart' as _i684;
import 'package:feature_capture/data/text_recognition_repository_impl.dart' as _i456;
import 'package:feature_capture/domain/page_detection_repository.dart' as _i432;
import 'package:feature_capture/domain/recognize_captured_page_use_case.dart' as _i610;
import 'package:feature_capture/domain/save_quote_use_case.dart' as _i997;
import 'package:feature_capture/domain/text_recognition_repository.dart' as _i981;
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart' as _i796;
import 'package:feature_capture/presentation/capture/capture_bloc.dart' as _i360;
import 'package:feature_capture/presentation/capture/page_detection_cubit.dart' as _i1072;
import 'package:feature_capture/presentation/crop/crop_bloc.dart' as _i975;
import 'package:feature_capture/presentation/marking/marking_bloc.dart' as _i1073;
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
    gh.lazySingleton<_i684.SpellCheckDataSource>(() => _i684.SpellCheckDataSourceImpl());
    gh.factory<_i432.PageDetectionRepository>(() => const _i921.PageDetectionRepositoryImpl());
    gh.factory<_i796.AddBookBloc>(() => _i796.AddBookBloc(gh<_i748.BookRepository>()));
    gh.factory<_i360.CaptureBloc>(() => _i360.CaptureBloc(gh<_i748.BookRepository>()));
    gh.factory<_i997.SaveQuoteUseCase>(
      () => _i997.SaveQuoteUseCase(
        gh<_i570.QuoteRepository>(),
        gh<_i748.BookRepository>(),
      ),
    );
    gh.factory<_i981.TextRecognitionRepository>(
      () => _i456.TextRecognitionRepositoryImpl(gh<_i684.SpellCheckDataSource>()),
    );
    gh.factoryParam<_i975.CropBloc, _i1040.CropArguments, dynamic>(
      (
        _arguments,
        _,
      ) => _i975.CropBloc(
        gh<_i432.PageDetectionRepository>(),
        _arguments,
      ),
    );
    gh.factory<_i1072.PageDetectionCubit>(
      () => _i1072.PageDetectionCubit(gh<_i432.PageDetectionRepository>()),
    );
    gh.factory<_i610.RecognizeCapturedPageUseCase>(
      () => _i610.RecognizeCapturedPageUseCase(
        gh<_i432.PageDetectionRepository>(),
        gh<_i981.TextRecognitionRepository>(),
      ),
    );
    gh.factoryParam<_i1073.MarkingBloc, _i851.MarkingArguments, dynamic>(
      (
        _arguments,
        _,
      ) => _i1073.MarkingBloc(
        gh<_i610.RecognizeCapturedPageUseCase>(),
        gh<_i997.SaveQuoteUseCase>(),
        gh<_i748.BookRepository>(),
        gh<_i640.ThemeRepository>(),
        _arguments,
      ),
    );
  }
}
