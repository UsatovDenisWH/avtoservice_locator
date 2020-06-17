import 'dart:async';

import 'package:avtoservicelocator/data/current_user_service.dart';
import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class Repository {
  IDataSource _dataSource;
  CurrentUserService _currentUserService;
  Future<bool> isInitialized;

  final _log = FimberLog("FLU_CHAT");

  Repository(
      {@required IDataSource dataSource,
      @required CurrentUserService currentUserService}) {
    _dataSource = dataSource;
    _currentUserService = currentUserService;
    isInitialized = initialize();
    _log.d("Repository create");
  }

  @override
  Future<bool> initialize() async {
    _log.d("Repository initRepository() start");

    try {
      _dataSource.isInitialized = await _dataSource.initialize();
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }

    try {
      _currentUserService.isInitialized =
          await _currentUserService.initialize();
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }

    _log.d("Repository initRepository() end");
    return true;
  }

  @override
  void dispose() {
    _log.d("Repository dispose");
  }

  void _handleException(Exception error, StackTrace stackTrace) {
    _log.d("Error in class Repository", ex: error, stacktrace: stackTrace);
  }
}
