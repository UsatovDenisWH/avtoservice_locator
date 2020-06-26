import 'package:avtoservicelocator/data/i_data_source.dart';
import 'package:avtoservicelocator/model/message.dart';
import 'package:avtoservicelocator/model/message_item.dart';
import 'package:avtoservicelocator/model/proposal_item.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/request_item.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

class StreamService {
  final changeInDataSource = PublishSubject<DataSourceEvent>();
  final refreshData = PublishSubject<RefreshDataEvent>();

  final listRequests = BehaviorSubject<List<Request>>();
  final listRequestItems = BehaviorSubject<List<RequestItem>>();

  final listProposalItems = BehaviorSubject<List<ProposalItem>>();

  final listMessages = BehaviorSubject<List<Message>>();
  final listMessageItems = BehaviorSubject<List<MessageItem>>();

  String filterRequestItems;
  String filterMessageItems;
  String filterRequestId;

  final _log = FimberLog("AvtoService Locator");

  StreamService() {
    filterRequestItems = "";
    filterMessageItems = "";
    filterRequestId = "";

    listRequests.listen(_convertRequestsToRequestItems);
    listRequests.listen(_convertRequestsToProposalItems);

//    listRequests
//        .map(_convertRequestsToRequestItems)
//        .map(_filterRequestItems)
//        .listen(listRequestItems.add);

//    listRequests
//        .map(_convertRequestsToProposalItems)
//        .listen(listProposalItems.add);

//    listMessages
//        .map(_convertMessagesToMessageItems)
//        .map(_filterMessageItems)
//        .listen(listMessageItems.add);

    _log.d("StreamsService create");
  }

  List<RequestItem> _filterRequestItems(List<RequestItem> inRequestItems) {
    _log.d("StreamService _filterRequestItems() start");
    List<RequestItem> outRequestItems;

    if (filterRequestItems.isEmpty) {
      outRequestItems = inRequestItems;
    } else {
      outRequestItems = [];
      inRequestItems.forEach((item) {
        if (item.descRequest
            .toLowerCase()
            .contains(filterRequestItems.toLowerCase())) {
          outRequestItems.add(item);
        }
      });
    }
    _log.d("StreamService _filterRequestItems(${outRequestItems.length})");
    return outRequestItems;
  }

//  List<MessageItem> _filterMessageItems(List<MessageItem> inMessageItems) {
//    List<MessageItem> outMessageItems;
//
//    if (filterMessageItems.isEmpty) {
//      outMessageItems = inMessageItems;
//    } else {
//      outMessageItems = [];
//      inMessageItems.forEach((item) {
//        if (item.text
//            .toLowerCase()
//            .contains(filterMessageItems.toLowerCase())) {
//          outMessageItems.add(item);
//        }
//      });
//    }
//    return outMessageItems;
//  }

  void /*List<RequestItem>*/ _convertRequestsToRequestItems(
      List<Request> requests) {
    _log.d(
        "StreamService _convertRequestsToRequestItems() start");
    var requestItems = List<RequestItem>();
    RequestItem item;

    requests.forEach((request) {
      item = request.toRequestItem();
      requestItems.add(item);
    });
    _log.d(
        "StreamService _convertRequestsToRequestItems(${requestItems.length})");
//    return requestItems;
    listRequestItems.add(_filterRequestItems(requestItems));
  }

  void /*List<ProposalItem>*/ _convertRequestsToProposalItems(
      List<Request> requests) {
    _log.d("StreamService _convertRequestsToProposalItems() start");
    var proposalItems = List<ProposalItem>();
    ProposalItem item;

    var requestIndex =
        requests.indexWhere((element) => element.id == filterRequestId);
    var proposals;
    if (requestIndex != -1) {
      proposals = requests[requestIndex].proposals;
    }
    if (proposals != null && proposals.length > 0) {
      proposals.forEach((proposal) {
        item = proposal.toProposalItem();
        proposalItems.add(item);
      });
      listProposalItems.add(proposalItems);
    }
//    return proposalItems;
    _log.d(
        "StreamService _convertRequestsToProposalItems(${proposalItems.length}) end.");
  }

  List<MessageItem> _convertMessagesToMessageItems(List<Message> messages) {
    _log.d("StreamService _convertMessagesToMessageItems()");
    var messageItems = List<MessageItem>();
    MessageItem item;

    messages.forEach((message) {
      item = message.toMessageItem();
      messageItems.add(item);
    });
    return messageItems;
  }

  @override
  void dispose() {
    changeInDataSource.close();
    refreshData.close();
    listRequests.close();
    listMessages.close();
    listRequestItems.close();
    listProposalItems.close();
    listMessageItems.close();
    _log.d("StreamService dispose");
  }
}

enum RefreshDataEvent {
  LIST_REQUEST
}