import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/request_item.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:avtoservicelocator/service/stream_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class RequestBloc extends BlocBase {
  final ScreenBuilderService _screenBuilderService;
  final StreamService _streamService;
  final Repository _repository;

  Stream<List<RequestItem>> outRequestItems;
  BuildContext context;

  final _log = FimberLog("AvtoService Locator");

  RequestBloc(
      {@required ScreenBuilderService screenBuilderService,
      @required StreamService streamService,
      @required Repository repository})
      : this._screenBuilderService = screenBuilderService,
        this._streamService = streamService,
        this._repository = repository {
    outRequestItems = _streamService.listRequestItems.stream;
    _log.d("RequestBloc create");
  }

  void onSelectedItemMenu(SelectedItemMenu result) {}

  void onTapRequestItem({RequestItem item}) {
    _log.d(
        "onTapRequestItem() item.descProposals = ${item.descProposals?.length}");
    if (_isItemCanTapped(item)) {
      _streamService.filterRequestId = item.id;
      _streamService.refreshData.add(RefreshDataEvent.LIST_REQUEST);

      var nextScreen = _screenBuilderService.getProposalScreenBuilder();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => nextScreen(item.id)));
    }
  }

  @override
  void dispose() {
    _streamService.filterRequestId = "";
    _log.d("RequestBloc dispose");
  }

  bool _isItemCanTapped(RequestItem item) {
    if ((item.status == RequestStatus.ACTIVE ||
            item.status == RequestStatus.WORK) &&
        item.descProposals?.length == 2) {
      return true;
    } else {
      return false;
    }
  }
}

enum SelectedItemMenu { CANCEL }
