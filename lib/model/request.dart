import 'package:avtoservicelocator/model/car.dart';

class Request {
  DateTime date;
  int number;
  String status;
  Car car;
  String description;
  List<String> photos;
  DateTime dateRepair;
  bool signYourParts;
  bool signNeedEvacuation;
}
