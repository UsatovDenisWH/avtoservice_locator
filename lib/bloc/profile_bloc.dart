import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:avtoservicelocator/service/current_user_service.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:page_transition/page_transition.dart';

class ProfileBloc extends BlocBase {
  ProfileBloc(
      {@required CurrentUserService currentUserService,
      @required ScreenBuilderService screenBuilderService,
      @required Repository repository})
      : _currentUserService = currentUserService,
        _screenBuilderService = screenBuilderService,
        _repository = repository,
        currentUser = currentUserService.getCurrentUser() {
    updateReferenceList();
    _log.d('ProfileBloc create');
  }

  final CurrentUserService _currentUserService;
  final ScreenBuilderService _screenBuilderService;
  final Repository _repository;
  final User currentUser;
  List<String> listCountries;
  List<String> listRegions;
  Map<String, String> mapCities;
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

  void logoutUser() {
    _currentUserService.logoutCurrentUser();
    var nextScreen = _screenBuilderService.getLoginScreenBuilder();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition<Widget>(
            type: PageTransitionType.fade, child: nextScreen()),
        (route) => false);
  }

  void updateProfile() {
    _currentUserService.setCurrentUser(newUser: currentUser);
  }

  void updateReferenceList() {
    listCountries = _repository.getAddressElements();
    listRegions =
        _repository.getAddressElements(country: currentUser.country ?? '');
    mapCities = _repository.getCityAddress(
        country: currentUser.country ?? '', region: currentUser.region ?? '');
  }

  bool isValidEmail({String email}) {
    var result = true;

    if (email != null && email.isNotEmpty) {
      var indexMonkey = email.indexOf('@');
      if (indexMonkey == -1 ||
          indexMonkey == 0 ||
          indexMonkey == email.length - 1) {
        result = false;
      } else {
        var secondPart = email.substring(indexMonkey + 1);
        var indexDot = secondPart.indexOf('.');
        if (indexDot == -1 || indexDot == 0 || indexDot == secondPart.length - 1) {
          result = false;
        }
      }
    }
    return result;
  }
}

enum ProfileListItem { USER_CARD, EMAIL, COUNTRY, REGION, CITY, CARS }
