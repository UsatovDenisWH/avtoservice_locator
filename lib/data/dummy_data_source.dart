import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class DummyDataSource implements IDataSource {
  bool isInitialized;

  final _log = FimberLog("FLU_CHAT");

  @override
  Future<User> getUserByPhone({@required String phoneNumber}) {
    try {} on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
  }

  @override
  Future<bool> updateUser({@required User user}) async {
    try {} on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
    return true;
  }

  @override
  Future<bool> initialize() async {
    _log.d("DummyDataSource initialize() start");
    await Future.delayed(Duration(seconds: 2));
    _log.d("DummyDataSource initialize() end");
    return true;
  }

  void _handleException(Exception error, StackTrace stackTrace) {
    _log.d("Error in class CurrentUserService",
        ex: error, stacktrace: stackTrace);
  }
}
