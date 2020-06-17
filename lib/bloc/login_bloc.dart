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
  User currentUser;
  BuildContext context;

  final _log = FimberLog("FLU_CHAT");

  LoginBloc(
      {@required CurrentUserService currentUserService,
      @required ScreenBuilderService screenBuilderService})
      : this._currentUserService = currentUserService,
        this._screenBuilderService = screenBuilderService {
    currentUser = _currentUserService.getCurrentUser();
    _log.d("LoginBloc create");
  }

//  bool loginUser(
//      {@required String firstName, String lastName, String password}) {
//    // TODO add check username, password
//    if (_currentUser == null ||
//        _currentUser.firstName != firstName ||
//        _currentUser.lastName != lastName) {
//      _repository.setCurrentUser(
//          user: User(firstName: firstName, lastName: lastName));
//      _currentUser = _repository.getCurrentUser();
//    }
//    return true;
//  }

//  BlocProvider<BlocBase> getNextScreen() {
//    var injector = DiContainer.getInjector();
//
//    BlocProvider<ChatListBloc> chatScreen =
//        (injector.get<ChatListScreenBuilder>())();
//    BlocProvider<LoginBloc> loginScreen =
//        (injector.get<LoginScreenBuilder>())();
//
//    return chatScreen;
//  }

  @override
  void dispose() {
    _log.d("LoginBloc dispose");
  }
}
