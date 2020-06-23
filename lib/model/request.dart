import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/car.dart';
import 'package:avtoservicelocator/model/proposal.dart';
import 'package:avtoservicelocator/model/request_item.dart';

class Request {
  String id;
  DateTime date;
  int number;
  RequestStatus status;
  Car car;
  String description;
  List<String> photos;
  DateTime dateRepair;
  bool signYourParts;
  bool signNeedEvacuation;
  List<Proposal> proposals;

  Request(
      {DateTime date,
      int number,
      RequestStatus status,
      Car car,
      String description,
      List<String> photos,
      DateTime dateRepair,
      bool signYourParts,
      bool signNeedEvacuation,
      List<Proposal> proposals})
      : this.id = Utils.getRandomUUID(),
        this.date = date,
        this.number = number,
        this.status = status,
        this.car = car,
        this.description = description,
        this.photos = photos,
        this.dateRepair = dateRepair,
        this.signYourParts = signYourParts,
        this.signNeedEvacuation = signNeedEvacuation,
        this.proposals = proposals;

  RequestItem toRequestItem() {
    var statusText;
    if (status == RequestStatus.ACTIVE) {
      statusText = "Активная заявка";
    } else if (status == RequestStatus.DONE) {
      statusText = "Завершённая заявка";
    } else if (status == RequestStatus.CANCEL) {
      statusText = "Отменённая заявка";
    }
    return RequestItem(
        id: id,
        number: number,
        status: statusText,
        descCar: car.getCarDescription(),
        descRequest: description,
        descProposals: getProposalsDescription());
  }

  List<String> getProposalsDescription() {
    List<String> result = [];
    if (proposals == null || proposals.length == 0) {
      result.add("Ожидание предложений");
    } else {
      result.add("${proposals.length} предложения");
      result.add(
          "от ${proposals.reduce((current, next) => current.price < next.price ? current : next).price} \u{20BD}");
    }
    return result;
  }
}

enum RequestStatus { ACTIVE, DONE, CANCEL }
