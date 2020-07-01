import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/model/autoservice_item.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:avtoservicelocator/service/stream_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:page_transition/page_transition.dart';

class SearchBloc extends BlocBase {
  SearchBloc(
      {@required ScreenBuilderService screenBuilderService,
      @required StreamService streamService})
      : _screenBuilderService = screenBuilderService,
        outAutoServiceItems = streamService.listAutoServiceItems.stream {
    _log.d('SearchBloc create');
  }

  final ScreenBuilderService _screenBuilderService;
  Stream<List<AutoServiceItem>> outAutoServiceItems;
  BuildContext context;
  final int bottomNavigationBarIndex = 1;
  final FimberLog _log = FimberLog('AvtoService Locator');

  @override
  void dispose() {
    _log.d('SearchBloc dispose');
  }

  void onTapBottomNavigationBar(int index) {
    Widget Function() nextScreen;
    if (index == 0) {
      nextScreen = _screenBuilderService.getRequestScreenBuilder();
    } else if (index == 2) {
      nextScreen = _screenBuilderService.getProfileScreenBuilder();
    } else {
      return;
    }
    Navigator.pushReplacement(
        context,
        PageTransition<Widget>(
            type: PageTransitionType.fade, child: nextScreen()));
  }

  void onTapAutoServiceItem({AutoServiceItem item}) {
    var nextScreen = _screenBuilderService.getAutoserviceScreenBuilder();
    Navigator.push<Widget>(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) =>
                nextScreen(null, item.id, null)));
  }
}
