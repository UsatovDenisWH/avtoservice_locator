import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/service/current_user_service.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:page_transition/page_transition.dart';

class ProfileBloc extends BlocBase {
  ProfileBloc(
      {@required CurrentUserService currentUserService,
      @required ScreenBuilderService screenBuilderService})
      : _currentUserService = currentUserService,
        _screenBuilderService = screenBuilderService {
    _log.d('ProfileBloc create');
  }

  final CurrentUserService _currentUserService;
  final ScreenBuilderService _screenBuilderService;
  BuildContext context;
  final int bottomNavigationBarIndex = 2;
  final FimberLog _log = FimberLog('AvtoService Locator');

  @override
  void dispose() {
    _log.d('ProfileBloc dispose');
  }

  void onTapBottomNavigationBar(int index) {
    Widget Function() nextScreen;
    if (index == 0) {
      nextScreen = _screenBuilderService.getRequestScreenBuilder();
    } else if (index == 1) {
      nextScreen = _screenBuilderService.getSearchScreenBuilder();
    } else {
      return;
    }
    Navigator.pushReplacement(
        context,
        PageTransition<Widget>(
            type: PageTransitionType.fade, child: nextScreen()));
  }
}
