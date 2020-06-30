import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/request_item.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:avtoservicelocator/service/stream_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:page_transition/page_transition.dart';

class RequestBloc extends BlocBase {
  RequestBloc(
      {@required ScreenBuilderService screenBuilderService,
      @required StreamService streamService,
      @required Repository repository})
      : _screenBuilderService = screenBuilderService,
        _streamService = streamService,
        _repository = repository {
    outRequestItems = _streamService.listRequestItems.stream;
    _log.d('RequestBloc create');
  }

  final ScreenBuilderService _screenBuilderService;
  final StreamService _streamService;
  final Repository _repository;
  Stream<List<RequestItem>> outRequestItems;
  BuildContext context;
  final int bottomNavigationBarIndex = 0;
  final FimberLog _log = FimberLog('AvtoService Locator');

  void onTapRequestItem({RequestItem item}) {
    _log.d(
        'onTapRequestItem() item.descProposals = ${item.descProposals?.length}');
    if (_isItemCanTapped(item)) {
      _streamService.filterRequestId = item.id;
      _streamService.refreshData.add(RefreshDataEvent.LIST_REQUEST);

      var nextScreen = _screenBuilderService.getProposalScreenBuilder();
      Navigator.push<Widget>(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) => nextScreen(item.id)));
    }
  }

  void onSelectedItemMenu(RequestItem requestItem, SelectedItemMenu menuItem) {
    if (menuItem == SelectedItemMenu.CANCEL) {
      _repository.updateRequest(
          requestId: requestItem.id, newStatus: RequestStatus.CANCEL);
    }
  }

  void onTapBottomNavigationBar(int index) {
    Widget Function() nextScreen;
    if (index == 1) {
      nextScreen = _screenBuilderService.getSearchScreenBuilder();
    } else if (index == 2) {
      nextScreen = _screenBuilderService.getProfileScreenBuilder();
    } else {
      return;
    }
    Navigator.pushReplacement(
        context,
        PageTransition<Widget>(
            type: PageTransitionType.fade, child: nextScreen()));

/*    Navigator.push<Widget>(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) => nextScreen()));*/
  }

  @override
  void dispose() {
    _streamService.filterRequestId = '';
    _log.d('RequestBloc dispose');
  }

  bool _isItemCanTapped(RequestItem item) {
    if (/*(item.status == RequestStatus.ACTIVE ||
            item.status == RequestStatus.WORK) &&*/
        item.descProposals?.length == 2) {
      return true;
    } else {
      return false;
    }
  }
}

enum SelectedItemMenu { CANCEL }
