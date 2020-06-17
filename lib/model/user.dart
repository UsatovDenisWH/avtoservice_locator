import 'dart:core';

import 'package:avtoservicelocator/model/car.dart';
import 'package:avtoservicelocator/model/message.dart';
import 'package:avtoservicelocator/model/request.dart';

class User {
  String phoneNumber;
  String eMail;
  String country;
  String region;
  String city;
  List<Car> cars;
  List<Request> requests;
  List<Message> messages;
}
