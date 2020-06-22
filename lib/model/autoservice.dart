import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/user_feedback.dart';

class AutoService {
  String id;
  String name;
  String address;
  String location;
  String description;
  List<String> photos;
  double userRating;
  int stars;
  List<UserFeedback> feedbacks;

  AutoService(
      {String name,
      String address,
      String location,
      String description,
      List<String> photos,
      double userRating,
      int stars,
      List<UserFeedback> feedbacks})
      : this.id = Utils.getRandomUUID(),
        this.name = name,
        this.address = address,
        this.location = location,
        this.description = description,
        this.photos = photos,
        this.userRating = userRating,
        this.stars = stars,
        this.feedbacks = feedbacks;
}
