import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  RequestBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
  }

  @override
  Widget build(BuildContext context) {}
}
