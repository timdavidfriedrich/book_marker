// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_capture/data/text_recognition_repository_impl.dart'
    as _i456;
import 'package:feature_capture/domain/save_bookmark_use_case.dart' as _i493;
import 'package:feature_capture/domain/text_recognition_repository.dart'
    as _i981;
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart'
    as _i796;
import 'package:feature_capture/presentation/capture/capture_bloc.dart'
    as _i360;
import 'package:feature_capture/presentation/marking/marking_bloc.dart'
    as _i1072;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/bookmark_repository.dart' as _i245;
import 'package:shared/presentation/navigation/marking_arguments.dart' as _i851;

class FeatureCapturePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i981.TextRecognitionRepository>(
        () => const _i456.TextRecognitionRepositoryImpl());
    gh.factory<_i796.AddBookBloc>(
        () => _i796.AddBookBloc(gh<_i748.BookRepository>()));
    gh.factory<_i360.CaptureBloc>(
        () => _i360.CaptureBloc(gh<_i748.BookRepository>()));
    gh.factory<_i493.SaveBookmarkUseCase>(() => _i493.SaveBookmarkUseCase(
          gh<_i245.BookmarkRepository>(),
          gh<_i748.BookRepository>(),
        ));
    gh.factoryParam<_i1072.MarkingBloc, _i851.MarkingArguments, dynamic>((
      _arguments,
      _,
    ) =>
        _i1072.MarkingBloc(
          gh<_i981.TextRecognitionRepository>(),
          gh<_i493.SaveBookmarkUseCase>(),
          _arguments,
        ));
  }
}
