import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/autoservice.dart';
import 'package:avtoservicelocator/model/proposal_item.dart';
import 'package:flutter/foundation.dart';

class Proposal {
  String id;
  AutoService autoService;
  int price;

  Proposal({@required AutoService autoService, @required int price})
      : this.id = Utils.getRandomUUID(),
        this.autoService = autoService,
        this.price = price;

  toProposalItem() {
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
