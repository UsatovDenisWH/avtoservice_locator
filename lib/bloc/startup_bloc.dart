import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/service/current_user_service.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class StartupBloc extends BlocBase {
  final Repository _repository;
  final CurrentUserService _currentUserService;
  final ScreenBuilderService _screenBuilderService;
  Future<bool> isRepoInit;
  BuildContext context;
  final _log = FimberLog("AvtoService Locator");

  StartupBloc(
      {@required Repository repository,
      @required CurrentUserService currentUserService,
      @required ScreenBuilderService screenBuilderService})
      : this._repository = repository,
        this._currentUserService = currentUserService,
        this._screenBuilderService = screenBuilderService {
    _log.d("StartupBloc create start");
    isRepoInit = _repository.isInitialized;
    _log.d("StartupBloc create end");
  }

  void gotoNextScreen() {
    Widget Function() nextScreen;
    var currentUser = _currentUserService.getCurrentUser();
    if (currentUser == null) {
      nextScreen = _screenBuilderService.getLoginScreenBuilder();
    } else {
      nextScreen = _screenBuilderService.getRequestScreenBuilder();
    }
    Navigator.pushReplacement<Widget, Widget>(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) => nextScreen()));
  }

  @override
  void dispose() {
    _log.d("StartupBloc dispose");
  }
}
