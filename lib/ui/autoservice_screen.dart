
import 'package:avtoservicelocator/bloc/autoservice_bloc.dart';
import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:flutter/material.dart';

class AutoserviceScreen extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() => _AutoserviceScreenState();
}

class _AutoserviceScreenState extends State<AutoserviceScreen> {
  AutoserviceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
  }

  @override
  Widget build(BuildContext context) {

  }

}