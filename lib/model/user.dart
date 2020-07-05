import 'dart:core';
import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/car.dart';
import 'package:flutter/foundation.dart';

class User {
  User(
      {String id,
      @required this.phoneNumber,
      this.name,
      this.eMail,
      this.country,
      this.region,
      this.city,
      this.location,
      this.cars})
      : id = id ?? Utils.getRandomUUID();

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        phoneNumber = json['phoneNumber'] as String,
        name = json['name'] as String,
        eMail = json['eMail'] as String,
        country = json['country'] as String,
        region = json['region'] as String,
        city = json['city'] as String,
        location = json['location'] as String {
    cars = _carsFromJson(json['cars'] as Map<String, dynamic>);
  }

  String id;
  String phoneNumber;
  String name;
  String eMail;
  String country;
  String region;
  String city;
  String location;
  List<Car> cars;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'phoneNumber': phoneNumber,
        'name': name,
        'eMail': eMail,
        'country': country,
        'region': region,
        'city': city,
        'location': location,
        'cars': _carsToJson()
      };

  Map<String, dynamic> _carsToJson() {
    Map<String, dynamic> result;
    if (cars != null && cars.isNotEmpty) {
      var i = 0;
      cars.forEach((car) {
        result[i.toString()] = car.toJson();
        i++;
      });
    }
    return result;
  }

  List<Car> _carsFromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    } else {
      return Iterable<int>.generate(json.length)
          .toList()
          .map((int index) => Car.fromJson(json[index] as Map<String, dynamic>))
          .toList();
    }
  }

  String getUserCarsDescription() {
    if (cars != null && cars.isNotEmpty) {
      return '${cars[0].getCarDescription()} (всего ${cars.length})';
    } else {
      return null;
    }
  }
}
