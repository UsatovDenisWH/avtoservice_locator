import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserService {
  User _currentUser;
  IDataSource _dataSource;
  bool isInitialized;

  final _log = FimberLog("FLU_CHAT");
  final _CURRENT_USER_PHONE = "CURRENT_USER_PHONE";

  CurrentUserService({@required IDataSource dataSource})
      : this._dataSource = dataSource;

  Future<bool> initialize() async {
    _log.d("CurrentUserService initialize() start");

    var phoneNumber;
    try {
      phoneNumber = await _loadUserPhoneFromSPrefs();
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }

    if (phoneNumber != null) {
      try {
        _currentUser =
            await _dataSource.getUserByPhone(phoneNumber: phoneNumber);
      } on Exception catch (error, stackTrace) {
        _handleException(error, stackTrace);
      }
    }

    _log.d("CurrentUserService initialize() end");
    return true;
  }

  User getCurrentUser() {
    _log.d("CurrentUserService getCurrentUser()");
    return _currentUser;
  }

  Future<bool> setCurrentUser({@required User newUser}) async {
    assert(newUser.phoneNumber != null);
    _log.d("CurrentUserService setCurrentUser()");

    _currentUser = newUser;

    var result = false;
    try {
      result = await _dataSource.updateUser(user: newUser);
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }

    if (newUser.phoneNumber != _currentUser.phoneNumber) {
      try {
        result = await _saveUserPhoneToSPrefs(phoneNumber: newUser.phoneNumber);
      } on Exception catch (error, stackTrace) {
        _handleException(error, stackTrace);
      }
    }

    return result;
  }

  Future<String> _loadUserPhoneFromSPrefs() async {
    _log.d("CurrentUserService _loadUserPhoneFromSPrefs() start");
    final prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString(_CURRENT_USER_PHONE);
    _log.d("CurrentUserService _loadUserPhoneFromSPrefs() end");
    return phoneNumber;
  }

  Future<bool> _saveUserPhoneToSPrefs({@required String phoneNumber}) async {
    _log.d("CurrentUserService _saveUserPhoneToSPrefs() start");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_CURRENT_USER_PHONE, phoneNumber);
    _log.d("CurrentUserService _saveUserPhoneToSPrefs() end");
    return true;
  }

  void _handleException(Exception error, StackTrace stackTrace) {
    _log.d("Error in class CurrentUserService",
        ex: error, stacktrace: stackTrace);
  }
}
