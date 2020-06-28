import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/message_item.dart';

class Message {
  Message() : id = Utils.getRandomUUID();

  String id;

  MessageItem toMessageItem() {
    return MessageItem();
  }
}
