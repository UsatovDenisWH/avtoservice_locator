import 'package:avtoservicelocator/bloc/common/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class RequestBloc extends BlocBase {

  BuildContext context;

  final _log = FimberLog("FLU_CHAT");

  @override
  void dispose() {
    _log.d("RequestBloc dispose");
  }
}