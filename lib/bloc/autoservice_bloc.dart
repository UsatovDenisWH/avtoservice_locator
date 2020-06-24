import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/model/proposal.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class AutoserviceBloc extends BlocBase {
  final ScreenBuilderService _screenBuilderService;
  final Repository _repository;
  final Proposal proposal;
  BuildContext context;

  final _log = FimberLog("AvtoService Locator");

  AutoserviceBloc(
      {@required Proposal proposal,
      @required ScreenBuilderService screenBuilderService,
      @required Repository repository})
      : this.proposal = proposal,
        this._screenBuilderService = screenBuilderService,
        this._repository = repository {
    _log.d("AutoserviceBlock create");
  }

  void onPressedSubscribeButton() {
    _repository.updateRequest(
        proposalId: proposal.id, newStatus: RequestStatus.DONE);
    var nextScreen = _screenBuilderService.getRequestScreenBuilder();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => nextScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _log.d("AutoserviceBlock dispose");
  }
}
