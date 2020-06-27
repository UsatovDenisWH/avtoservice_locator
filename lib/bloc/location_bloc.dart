import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/model/proposal.dart';
import 'package:avtoservicelocator/service/screen_builder_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class LocationBloc extends BlocBase {
  final ScreenBuilderService _screenBuilderService;
  final Repository _repository;
  final Proposal proposal;
  BuildContext context;

  final _log = FimberLog("AvtoService Locator");

  LocationBloc(
      {@required Proposal proposal,
      @required ScreenBuilderService screenBuilderService,
      @required Repository repository})
      : this.proposal = proposal,
        this._screenBuilderService = screenBuilderService,
        this._repository = repository {
    _log.d("LocationBlock create");
  }

  @override
  void dispose() {}
}
