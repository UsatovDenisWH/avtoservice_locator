
import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class AutoserviceBloc extends BlocBase {

  BuildContext context;

  final _log = FimberLog("AvtoService Locator");

  AutoserviceBloc() {
    _log.d("AutoserviceBlock create");
  }

  @override
  void dispose() {
    _log.d("AutoserviceBlock dispose");
  }

}