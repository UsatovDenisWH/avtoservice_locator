import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserService {
  User _currentUser;
  IDataSource _dataSource;
  bool isInitialized;

  final _log = FimberLog("AvtoService Locator");
  final _CURRENT_USER_PHONE = "CURRENT_USER_PHONE";

  CurrentUserService({@required IDataSource dataSource})
      : this._dataSource = dataSource;

  Future<bool> initialize() async {
    _log.d("CurrentUserService initialize() start");
    var phoneNumber = await _loadUserPhoneFromSPrefs();
    if (phoneNumber != null) {
      _currentUser = await _dataSource.getUserByPhone(phoneNumber: phoneNumber);
      if (_currentUser == null) {
        _currentUser = User(phoneNumber: phoneNumber);
        await _dataSource.updateUser(user: _currentUser);
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

    var oldCurrentUser = _currentUser;

    // first login OR change user
    if (_currentUser == null ||
        _currentUser.phoneNumber != newUser.phoneNumber) {
      _currentUser =
          await _dataSource.getUserByPhone(phoneNumber: newUser.phoneNumber);
      if (_currentUser == null) {
        // new user not found in DataSource
        _currentUser = newUser;
      }
      // save new user to SPrefs
      await _saveUserPhoneToSPrefs(phoneNumber: _currentUser.phoneNumber);
    } else {
      // update current user
      _currentUser = newUser;
    }

    // save new currentUser to DataSource
    var result = await _dataSource.updateUser(user: _currentUser);
    if (!result) {
      // rollback currentUser
      _currentUser = oldCurrentUser;
      await _saveUserPhoneToSPrefs(phoneNumber: _currentUser.phoneNumber);
    }
    return result;
  }

  Future<String> _loadUserPhoneFromSPrefs() async {
    _log.d("CurrentUserService _loadUserPhoneFromSPrefs() start");
    SharedPreferences prefs;
    String phoneNumber;
    try {
      prefs = await SharedPreferences.getInstance();
      phoneNumber = prefs.getString(_CURRENT_USER_PHONE);
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
    _log.d("CurrentUserService _loadUserPhoneFromSPrefs() end");
    return phoneNumber;
  }

  Future<bool> _saveUserPhoneToSPrefs({@required String phoneNumber}) async {
    _log.d("CurrentUserService _saveUserPhoneToSPrefs() start");
    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
      prefs.setString(_CURRENT_USER_PHONE, phoneNumber);
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
    _log.d("CurrentUserService _saveUserPhoneToSPrefs() end");
    return true;
  }

  void _handleException(Exception error, StackTrace stackTrace) {
    _log.d("Error in class CurrentUserService",
        ex: error, stacktrace: stackTrace);
  }
}
