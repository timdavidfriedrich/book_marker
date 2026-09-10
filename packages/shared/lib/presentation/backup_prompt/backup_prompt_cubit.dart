import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/domain/repositories/auth_repository.dart';
import 'package:shared/domain/repositories/quote_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

// * once, at the point where the library is worth protecting. A backup nag that
// * keeps returning is how people learn to dismiss without reading
const backupPromptThreshold = 10;

@lazySingleton
class BackupPromptCubit extends Cubit<bool> {
  BackupPromptCubit(
    this._quoteRepository,
    this._settingsRepository,
    this._authRepository,
  ) : super(false);

  final QuoteRepository _quoteRepository;
  final SettingsRepository _settingsRepository;
  final AuthRepository _authRepository;

  final List<StreamSubscription<Object?>> _subscriptions = [];
  int _quoteCount = 0;
  bool _isSignedOut = true;
  bool _isDismissed = true;

  void start() {
    _cancel();
    _subscriptions
      ..add(
        _quoteRepository.watchQuotes().listen((result) {
          if (result case Success<List<Quote>>(:final data)) {
            _quoteCount = data.length;
            _recompute();
          }
        }),
      )
      ..add(
        _settingsRepository.watchSettings().listen((result) {
          if (result case Success<UserSettings>(:final data)) {
            _isDismissed = data.hasDismissedBackupPrompt;
            _recompute();
          }
        }),
      )
      ..add(
        _authRepository.watchAccount().listen((result) {
          if (result case Success<Account?>(:final data)) {
            _isSignedOut = data == null;
            _recompute();
          }
        }),
      );
  }

  /// Marks the prompt answered whichever button was pressed. "Nicht jetzt"
  /// means never again rather than not this launch.
  Future<void> dismiss() async {
    emit(false);
    await _settingsRepository.dismissBackupPrompt();
  }

  void _recompute() => emit(_quoteCount >= backupPromptThreshold && _isSignedOut && !_isDismissed);

  void _cancel() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  @override
  Future<void> close() async {
    _cancel();
    return super.close();
  }
}
