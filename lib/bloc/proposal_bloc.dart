import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/model/proposal_item.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:avtoservicelocator/service/stream_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class ProposalBloc extends BlocBase {
  final ScreenBuilderService _screenBuilderService;
  final StreamService _streamService;

  Stream<List<ProposalItem>> outProposalItems;
  BuildContext context;

  final _log = FimberLog("AvtoService Locator");

  ProposalBloc(
      {@required String requestId,
      @required ScreenBuilderService screenBuilderService,
      @required StreamService streamService})
      : this._screenBuilderService = screenBuilderService,
        this._streamService = streamService {
    _streamService.filterRequestId = requestId;
    outProposalItems = _streamService.listProposalItems.stream;
    _log.d("ProposalBloc create");
  }

  void onTapProposalItem({ProposalItem item}) {
    _log.d("onTapProposalItem() item.id= ${item.id}");
    var nextScreen = _screenBuilderService.getAutoserviceScreenBuilder();
    Navigator.push<Widget>(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) => nextScreen(item.id)));
  }

  @override
  void dispose() {
    _streamService.filterRequestId = "";
    _log.d("ProposalBloc dispose");
  }
}
