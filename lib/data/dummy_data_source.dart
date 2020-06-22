import 'package:avtoservicelocator/data/dummy_data_generator.dart';
import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class DummyDataSource implements IDataSource {
  bool isInitialized;
  List<Request> _requests;

  final _log = FimberLog("AvtoService Locator");

  @override
  Future<bool> initialize() async {
    _log.d("DummyDataSource initialize() start");
    await Future.delayed(Duration(seconds: 2));
    _requests = DummyDataGenerator.generateRequests(); // List<Request>();
    _log.d("DummyDataSource initialize() end");
    return true;
  }

  @override
  Future<User> getUserByPhone({@required String phoneNumber}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return null;
  }

  @override
  Future<bool> updateUser({@required User user}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  @override
  Future<List<Request>> loadRequests({@required User user}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _requests;
  }

  void _handleException(Exception error, StackTrace stackTrace) {
    _log.d("Error in class CurrentUserService",
        ex: error, stacktrace: stackTrace);
  }
}
