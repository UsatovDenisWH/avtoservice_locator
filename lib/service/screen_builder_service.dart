import 'package:avtoservicelocator/bloc/autoservice_bloc.dart';
import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/location_bloc.dart';
import 'package:avtoservicelocator/bloc/login_bloc.dart';
import 'package:avtoservicelocator/bloc/proposal_bloc.dart';
import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/bloc/startup_bloc.dart';
import 'package:avtoservicelocator/model/proposal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

typedef BlocProvider<StartupBloc> StartupScreenBuilder();
typedef BlocProvider<LoginBloc> LoginScreenBuilder();
typedef BlocProvider<RequestBloc> RequestScreenBuilder();
typedef BlocProvider<ProposalBloc> ProposalScreenBuilder(String requestId);
typedef BlocProvider<AutoserviceBloc> AutoserviceScreenBuilder(
    String proposalId);
typedef BlocProvider<LocationBloc> LocationScreenBuilder(Proposal proposal);

class ScreenBuilderService {
  ScreenBuilderService({@required Injector injector})
      : this._injector = injector;

  final Injector _injector;

  Widget Function() getLoginScreenBuilder() =>
      _injector.get<LoginScreenBuilder>();

  Widget Function() getRequestScreenBuilder() =>
      _injector.get<RequestScreenBuilder>();

  Widget Function(String) getProposalScreenBuilder() =>
      _injector.get<ProposalScreenBuilder>();

  Widget Function(String) getAutoserviceScreenBuilder() =>
      _injector.get<AutoserviceScreenBuilder>();

  Widget Function(Proposal) getLocationScreenBuilder() =>
      _injector.get<LocationScreenBuilder>();
}
