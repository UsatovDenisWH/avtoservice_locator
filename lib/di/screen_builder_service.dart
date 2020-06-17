import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/login_bloc.dart';
import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/bloc/startup_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

typedef BlocProvider<StartupBloc> StartupScreenBuilder();
typedef BlocProvider<LoginBloc> LoginScreenBuilder();
typedef BlocProvider<RequestBloc> RequestScreenBuilder();

class ScreenBuilderService {
  final Injector _injector;

  ScreenBuilderService({@required Injector injector})
      : this._injector = injector;

  getLoginScreenBuilder() => _injector.get<LoginScreenBuilder>();

  getRequestScreenBuilder() => _injector.get<RequestScreenBuilder>();
}
