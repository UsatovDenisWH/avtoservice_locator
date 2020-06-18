import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/current_user_service.dart';
import 'package:avtoservicelocator/di/screen_builder_service.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class LoginBloc extends BlocBase {
  final CurrentUserService _currentUserService;
  final ScreenBuilderService _screenBuilderService;
  BuildContext context;

  final _log = FimberLog("FLU_CHAT");

  LoginBloc(
      {@required CurrentUserService currentUserService,
      @required ScreenBuilderService screenBuilderService})
      : this._currentUserService = currentUserService,
        this._screenBuilderService = screenBuilderService {
    _log.d("LoginBloc create");
  }

  void loginUser({@required String phoneNumber}) async {
    var newUser = User(phoneNumber: phoneNumber);
    var result = await _currentUserService.setCurrentUser(newUser: newUser);
    if (result) {
      var nextScreen = _screenBuilderService.getRequestScreenBuilder();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => nextScreen()));
    }
  }

  @override
  void dispose() {
    _log.d("LoginBloc dispose");
  }
}
