import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/autoservice.dart';
import 'package:avtoservicelocator/model/proposal_item.dart';
import 'package:flutter/foundation.dart';

class Proposal {
  String id;
  AutoService autoService;
  int price;

  Proposal({@required this.autoService, @required this.price})
      : this.id = Utils.getRandomUUID();

  ProposalItem toProposalItem() {
    return ProposalItem(
        id: id,
        name: autoService.name,
        price: price,
        address: autoService.address,
        location: autoService.location,
        rating: autoService.userRating,
        counterFeedbacks: autoService.feedbacks?.length);
  }
}
