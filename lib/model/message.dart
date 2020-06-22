

import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/message_item.dart';

class Message {
  String id;

  Message() : this.id = Utils.getRandomUUID();

  MessageItem toMessageItem() {}
}