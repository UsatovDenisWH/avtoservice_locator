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
      String descCar,
      String descRequest,
      List<String> descProposals})
      : this.id = id,
        this.number = number,
        this.status = status,
        this.descCar = descCar,
        this.descRequest = descRequest,
        this.descProposals = descProposals;
}
