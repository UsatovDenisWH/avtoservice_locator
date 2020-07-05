import 'package:avtoservicelocator/data/utils.dart';

class Car {
  Car(
      {String id,
      this.mark,
      this.model,
      this.releaseYear,
      this.vinCode,
      this.stateNumber,
      this.odometer})
      : id = id ?? Utils.getRandomUUID();

  Car.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        mark = json['mark'] as String,
        model = json['model'] as String,
        releaseYear = json['releaseYear'] as DateTime,
        vinCode = json['vinCode'] as String,
        stateNumber = json['stateNumber'] as String,
        odometer = json['odometer'] as int;

  String id;
  String mark;
  String model;
  DateTime releaseYear;
  String vinCode;
  String stateNumber;
  int odometer;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'mark': mark,
        'model': model,
        'releaseYear': releaseYear,
        'vinCode': vinCode,
        'stateNumber': stateNumber,
        'odometer': odometer
      };

  String getCarDescription() => '$mark $model (${releaseYear.year})';
}
