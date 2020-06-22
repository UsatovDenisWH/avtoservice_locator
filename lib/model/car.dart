import 'package:avtoservicelocator/data/utils.dart';

class Car {
  String id;
  String mark;
  String model;
  DateTime releaseYear;
  String vinCode;
  String stateNumber;
  int odometer;

  Car(
      {String mark,
      String model,
      DateTime releaseYear,
      String vinCode,
      String stateNumber,
      int odometer})
      : this.id = Utils.getRandomUUID(),
        this.mark = mark,
        this.model = model,
        this.releaseYear = releaseYear,
        this.vinCode = vinCode,
        this.stateNumber = stateNumber,
        this.odometer = odometer;

  String getCarDescription() => "$mark $model, ${releaseYear.year}";
}
