import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/current_user_service.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/di/screen_builder_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class StartupBloc extends BlocBase {
  final Repository _repository;
  final CurrentUserService _currentUserService;
  final ScreenBuilderService _screenBuilderService;

//  final LoginScreenBuilder _loginScreen;
//  final RequestScreenBuilder _requestScreen;

  Future<bool> isRepoInit;
  BuildContext context;

  final _log = FimberLog("FLU_CHAT");

  StartupBloc(
      {@required Repository repository,
      @required CurrentUserService currentUserService,
      @required ScreenBuilderService screenBuilderService
//      @required loginScreen,
//      @required requestScreen
      })
      : this._repository = repository,
        this._currentUserService = currentUserService,
        this._screenBuilderService = screenBuilderService
//        this._loginScreen = loginScreen,
//        this._requestScreen = requestScreen
  {
    _log.d("StartupBloc create start");
    isRepoInit = _repository.isInitialized;
    _log.d("StartupBloc create end");
  }

  void gotoNextScreen() {
    var currentUser = _currentUserService.getCurrentUser();
    var nextScreen;

    if (currentUser == null) {
      nextScreen =
          _screenBuilderService.getLoginScreenBuilder(); //_loginScreen;
    } else {
      nextScreen =
          _screenBuilderService.getRequestScreenBuilder(); //_requestScreen;
    }

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => nextScreen()));
  }

  @override
  void dispose() {
    _log.d("StartupBloc dispose");
  }
}
