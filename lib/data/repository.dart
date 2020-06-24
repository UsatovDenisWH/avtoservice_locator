import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/model/proposal.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/service/current_user_service.dart';
import 'package:avtoservicelocator/service/stream_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class Repository {
  IDataSource _dataSource;
  CurrentUserService _currentUserService;
  Future<bool> isInitialized;

  List<Request> _requests;
  Sink<List<Request>> _inListRequests;

  final _log = FimberLog("AvtoService Locator");

  Repository(
      {@required IDataSource dataSource,
      @required CurrentUserService currentUserService,
      @required StreamService streamService}) {
    _dataSource = dataSource;
    _currentUserService = currentUserService;
    isInitialized = initialize();
    streamService.changeInDataSource.listen(onChangeInDataSource);
    streamService.refreshData.listen(onRefreshData);
    _inListRequests = streamService.listRequests.sink;
    _log.d("Repository create");
  }

  Future<bool> initialize() async {
    _log.d("Repository initRepository() start");
    try {
      _dataSource.isInitialized = await _dataSource.initialize();
      _log.d(
          "Repository initRepository() _dataSource.isInitialized = ${_dataSource.isInitialized}");
      _currentUserService.isInitialized =
          await _currentUserService.initialize();
      _log.d(
          "Repository initRepository() _currentUserService.isInitialized = ${_currentUserService.isInitialized}");
      _log.d(
          "Repository initRepository() _currentUserService.getCurrentUser().phoneNumber = ${_currentUserService.getCurrentUser()?.phoneNumber}");
    } on Exception catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
//    onChangeInDataSource(DataSourceEvent.ALL_REFRESH);
    _requests = await _dataSource.loadRequests(
        user: _currentUserService.getCurrentUser());
    _inListRequests.add(_requests);
    _log.d(
        "Repository initRepository() _requests.length = ${_requests.length}");
    _log.d("Repository initRepository() end");
    return true;
  }

  void onChangeInDataSource(DataSourceEvent event) async {
    if (event == DataSourceEvent.REQUESTS_REFRESH) {
      _requests = await _dataSource.loadRequests(
          user: _currentUserService.getCurrentUser());
      _inListRequests.add(_requests);
      _log.d("Repository onChangeInDataSource REQUESTS_REFRESH");
    } else if (event == DataSourceEvent.MESSAGES_REFRESH) {
      _log.d("Repository onChangeInDataSource MESSAGES_REFRESH");
    } else if (event == DataSourceEvent.ALL_REFRESH) {
      onChangeInDataSource(DataSourceEvent.REQUESTS_REFRESH);
      onChangeInDataSource(DataSourceEvent.MESSAGES_REFRESH);
      _log.d("Repository onChangeInDataSource ALL_REFRESH");
    }
  }

  void onRefreshData(RefreshDataEvent event) {
    if (event == RefreshDataEvent.LIST_REQUEST) {
      _inListRequests.add(_requests);
    }
  }

  Proposal getProposalById({@required String proposalId}) {
    Proposal result;
    for (var request in _requests) {
      result = request.proposals?.firstWhere(
          (element) => element.id == proposalId,
          orElse: () => null);
      if (result != null) break;
    }
    return result;
  }

  void updateRequest(
      {String requestId, String proposalId, RequestStatus newStatus}) {
    assert(requestId != null || proposalId != null, "There are no props!");
    assert(newStatus != null, "Nothing to change!");
    // Finding request
    Request request;
    if (requestId != null) {
      request = _requests.firstWhere((element) => element.id == requestId);
    } else if (proposalId != null) {
      var proposal;
      for (var req in _requests) {
        request = req;
        proposal = request.proposals?.firstWhere(
            (element) => element.id == proposalId,
            orElse: () => null);
        if (proposal != null) break;
      }
    }
    // Modifying request
    if (newStatus != null) {
      request.status = newStatus;
    }
    _dataSource.updateRequest(request: request);
    onRefreshData(RefreshDataEvent.LIST_REQUEST);
  }

  void dispose() {
    _log.d("Repository dispose");
  }

  void _handleException(Exception error, StackTrace stackTrace) {
    _log.d("Error in class Repository", ex: error, stacktrace: stackTrace);
  }
}
