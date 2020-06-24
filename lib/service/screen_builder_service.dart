import 'package:avtoservicelocator/bloc/autoservice_bloc.dart';
import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/login_bloc.dart';
import 'package:avtoservicelocator/bloc/proposal_bloc.dart';
import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/bloc/startup_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

typedef BlocProvider<StartupBloc> StartupScreenBuilder();
typedef BlocProvider<LoginBloc> LoginScreenBuilder();
typedef BlocProvider<RequestBloc> RequestScreenBuilder();
typedef BlocProvider<ProposalBloc> ProposalScreenBuilder(String requestId);
typedef BlocProvider<AutoserviceBloc> AutoserviceScreenBuilder(String proposalId);


class ScreenBuilderService {
  final Injector _injector;

  ScreenBuilderService({@required Injector injector})
      : this._injector = injector;

  getLoginScreenBuilder() => _injector.get<LoginScreenBuilder>();

  getRequestScreenBuilder() => _injector.get<RequestScreenBuilder>();

  getProposalScreenBuilder() => _injector.get<ProposalScreenBuilder>();

  getAutoserviceScreenBuilder() => _injector.get<AutoserviceScreenBuilder>();
}
