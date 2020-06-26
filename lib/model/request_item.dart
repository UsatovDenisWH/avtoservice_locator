import 'package:avtoservicelocator/model/request.dart';

class RequestItem {
  String id;
  int number;
  RequestStatus status;
  String descCar;
  String descRequest;
  List<String> descProposals;

  RequestItem(
      {String id,
      int number,
      RequestStatus status,
      String statusText,
      String descCar,
      String descRequest,
      List<String> descProposals})
      : this.id = id,
        this.number = number,
        this.status = status,
        this.descCar = descCar,
        this.descRequest = descRequest,
        this.descProposals = descProposals;

  String get statusText {
    var result = "";
    if (status == RequestStatus.ACTIVE) {
      result = "Ожидание предложений";
    } else if (status == RequestStatus.WORK) {
      result = "Заявка в работе";
    } else if (status == RequestStatus.DONE) {
      result = "Заявка завершена";
    } else if (status == RequestStatus.CANCEL) {
      result = "Заявка отменена";
    }
    return result;
  }
}
