import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/foundation.dart';

abstract class IDataSource {
  bool isInitialized;

  Future<User> getUserByPhone({@required String phoneNumber});

  Future<bool> updateUser({@required User user});

  Future<bool> initialize();
}
