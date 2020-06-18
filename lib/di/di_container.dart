import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/login_bloc.dart';
import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/bloc/startup_bloc.dart';
import 'package:avtoservicelocator/data/current_user_service.dart';
import 'package:avtoservicelocator/data/dummy_data_source.dart';
import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/data/repository.dart';
import 'package:avtoservicelocator/di/screen_builder_service.dart';
import 'package:avtoservicelocator/ui/login_screen.dart';
import 'package:avtoservicelocator/ui/request_screen.dart';
import 'package:avtoservicelocator/ui/startup_screen.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class DiContainer {
  static Injector _injector;

  static void initialize() {
    _injector = Injector.getInjector();
    _registerServices();
    _registerScreenBuilders();
  }

//  static Injector getInjector() => _injector;

  static getStartupScreen() {
    return (_injector.get<StartupScreenBuilder>())();
  }

  static void _registerServices() {
    _injector.map<IDataSource>((i) => DummyDataSource(), isSingleton: true);

    _injector.map<CurrentUserService>(
        (i) => CurrentUserService(dataSource: i.get<IDataSource>()),
        isSingleton: true);

    _injector.map<Repository>(
        (i) => Repository(
            dataSource: i.get<IDataSource>(),
            currentUserService: i.get<CurrentUserService>()),
        isSingleton: true);

    _injector.map<ScreenBuilderService>(
        (i) => ScreenBuilderService(injector: i),
        isSingleton: true);
  }

  static void _registerScreenBuilders() {
    // Startup screen
    _injector.map<StartupScreenBuilder>(
        (i) => () => BlocProvider<StartupBloc>(
            child: StartupScreen(),
            bloc: StartupBloc(
              repository: i.get<Repository>(),
              currentUserService: i.get<CurrentUserService>(),
              screenBuilderService: i.get<ScreenBuilderService>(),
            )),
        isSingleton: true);

    // Login screen
    _injector.map<LoginScreenBuilder>(
        (i) => () => BlocProvider<LoginBloc>(
              child: LoginScreen(),
              bloc: LoginBloc(
                  currentUserService: i.get<CurrentUserService>(),
                  screenBuilderService: i.get<ScreenBuilderService>()),
            ),
        isSingleton: true);

    // Request screen
    _injector.map<RequestScreenBuilder>(
        (i) => () => BlocProvider<RequestBloc>(
              child: RequestScreen(),
              bloc: RequestBloc(),
            ),
        isSingleton: true);
  }
}
