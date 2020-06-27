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
  final Request request;
  bool isSubscribeButtonClickable;
  String subscribeButtonText;
  BuildContext context;

  final _log = FimberLog("AvtoService Locator");

  AutoserviceBloc(
      {@required String proposalId,
      @required ScreenBuilderService screenBuilderService,
      @required Repository repository})
      : this._screenBuilderService = screenBuilderService,
        this._repository = repository,
        this.proposal = repository.getProposalById(proposalId: proposalId),
        this.request = repository.getRequestById(proposalId: proposalId) {
    _initSubscribeButton();
    _log.d("AutoserviceBlock create");
  }

  void onPressedSubscribeButton() {
    if (request.status == RequestStatus.ACTIVE) {
      _repository.updateRequest(
          requestId: request.id, newStatus: RequestStatus.WORK);
      var nextScreen = _screenBuilderService.getRequestScreenBuilder();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => nextScreen()),
          (Route<dynamic> route) => false);
    }
  }

  void onTapAutoserviceLocation() {
    var nextScreen = _screenBuilderService.getLocationScreenBuilder();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => nextScreen(proposal)));
  }

  void onTapButtonBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _log.d("AutoserviceBlock dispose");
  }

  void _initSubscribeButton() {
    isSubscribeButtonClickable = request.status == RequestStatus.ACTIVE;

    if (request.status == RequestStatus.ACTIVE) {
      subscribeButtonText =
          "Записаться на ремонт за ${proposal.price} \u{20BD}";
    } else if (request.status == RequestStatus.WORK) {
      subscribeButtonText = "Заявка в работе";
    } else if (request.status == RequestStatus.DONE) {
      subscribeButtonText = "Заявка завершена";
    } else if (request.status == RequestStatus.CANCEL) {
      subscribeButtonText = "Заявка отменена";
    }
  }
}
