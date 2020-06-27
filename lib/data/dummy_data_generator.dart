import 'dart:math';

import 'package:avtoservicelocator/model/autoservice.dart';
import 'package:avtoservicelocator/model/car.dart';
import 'package:avtoservicelocator/model/proposal.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/user_feedback.dart';

class DummyDataGenerator {
  static List<Car> _cars = [
    Car(
        mark: "Hyundai",
        model: "Accent",
        releaseYear: DateTime.parse("2007-05-15 13:27:00"),
        vinCode: "VINCODE",
        stateNumber: "A123AA",
        odometer: 127000),
    Car(
        mark: "Nissan",
        model: "350Z",
        releaseYear: DateTime.parse("2005-06-16 13:27:00"),
        vinCode: "JN1VINCODE",
        stateNumber: "C061CC",
        odometer: 130000)
  ];

  static List<AutoService> _autoServices = [
    AutoService(
        name: "Щукин Авто",
        address: "Поляковское ш., 49-3, Таганрог",
        location: "47.203856, 38.854382",
        description:
            "Мы производим обслуживание физических и юридических лиц (заключаем договоры, принимаем участие в открытых торгах на электронных площадках). Оплата услуг может быть произведена за наличный, безналичный расчёт.",
        photos: [
          "https://avatars.mds.yandex.net/get-pdb/2797058/4a7a0a61-cafa-4a15-9aa9-3a1f22163bd4/s1200?webp=false",
          "https://avatars.mds.yandex.net/get-altay/1868686/2a0000016b2b835ea5a06a4c7fe9d143dcb1/XXL",
          "https://46biz.ru/uploads/archive/2020/1h94j7j4illn2_1pxtrod.jpeg"
        ],
        userRating: 9.8,
        stars: 3,
        feedbacks: [
          UserFeedback(
              date: DateTime.now(),
              userName: "Владимир",
              text: "Понравилась квалификация специалистов.",
              rating: 10),
          UserFeedback(
              date: DateTime.now(),
              userName: "Михаил",
              text: "Справились быстро и качественно",
              rating: 9.5),
          UserFeedback(
              date: DateTime.now(),
              userName: "Геннадий",
              text: "Быстро, качественно",
              rating: 9.9),
          UserFeedback(
              date: DateTime.now(),
              userName: "Александр",
              text: "Все хорошо!",
              rating: 10),
          UserFeedback(
              date: DateTime.now(),
              userName: "Николай",
              text: "Произвели диагностику на достойном уровне",
              rating: 9.7),
          UserFeedback(
              date: DateTime.now(),
              userName: "Сергей",
              text: "Все устроило. Хорошо сделали, быстро!",
              rating: 10)
        ]),
    AutoService(
        name: "AvtoCool",
        address: "П.Тольятти, 2А, Таганрог",
        location: "47.249299, 38.916446",
        description:
            "Ремонт ходовой части, тормозной системы, рулевого управления, двигателя, трансмиссии. Диагностика узлов и агрегатов. Сход-развал. Шиномонтаж и балансировка колёс",
        photos: [
          "https://a.d-cd.net/ea82408s-960.jpg",
          "https://avtogarant52.ru/images/foto/contacts/8.jpg",
          "https://avatars.mds.yandex.net/get-altay/214458/2a0000016264862562cf11d9f61bfda937f6/XXL"
        ],
        userRating: 9.9,
        stars: 4,
        feedbacks: [

        ]),
    AutoService(
        name: "АССА Авто",
        address: "Химическая, 117-8, Таганрог",
        location: "47.247733, 38.874962",
        description:
            "Сертифицированный сервисный центр. Техническое обслуживание и ремонт автомобиля. Запасные части, шины, диски. Отдел приёмки автомобилей в сервис расположен в автосалоне.",
        photos: [
          "https://avatars.mds.yandex.net/get-altay/176734/2a00000164ff5f82a90529c4c26ed456ab59/XXL",
          "https://p0.zoon.ru/f/0/5943832d3731335fc714bcbc_5def52f554e84.jpg",
          "https://img1.okidoker.com/c/1/3/7/37036/8764099/19096048_2.jpg"
        ],
        userRating: 9.5,
        stars: 2,
        feedbacks: [

        ])
  ];

  static List<Request> generateRequests() {
    var listRequest = List<Request>();

    listRequest.add(Request(
        date: DateTime.now(),
        number: 123001,
        status: RequestStatus.ACTIVE,
        car: _cars[0],
        description: "Замена масла",
        dateRepair: DateTime.now(),
        signYourParts: Random().nextBool(),
        signNeedEvacuation: Random().nextBool(),
//        List<String> photos;
        proposals: [
          Proposal(autoService: _autoServices[0], price: 600),
          Proposal(autoService: _autoServices[1], price: 900),
          Proposal(autoService: _autoServices[2], price: 700)
        ]));
    listRequest.add(Request(
        date: DateTime.now(),
        number: 123002,
        status: RequestStatus.CANCEL,
        car: _cars[0],
        description: "Ремонт автосигнализации",
        dateRepair: DateTime.now(),
        signYourParts: Random().nextBool(),
        signNeedEvacuation: Random().nextBool()
//        List<String> photos;
//        List<Proposal> proposals;
        ));
    listRequest.add(Request(
        date: DateTime.now(),
        number: 123003,
        status: RequestStatus.DONE,
        car: _cars[0],
        description: "Замена фильтров: масла, воздушный, салонный.",
        dateRepair: DateTime.now(),
        signYourParts: Random().nextBool(),
        signNeedEvacuation: Random().nextBool()
//        List<String> photos;
//        List<Proposal> proposals;
        ));
    listRequest.add(Request(
        date: DateTime.now(),
        number: 123004,
        status: RequestStatus.ACTIVE,
        car: _cars[1],
        description: "Замена масла",
        dateRepair: DateTime.now(),
        signYourParts: Random().nextBool(),
        signNeedEvacuation: Random().nextBool(),
//        List<String> photos;
        proposals: [
          Proposal(autoService: _autoServices[2], price: 1000),
          Proposal(autoService: _autoServices[1], price: 1100),
          Proposal(autoService: _autoServices[0], price: 1500)
        ]));
    listRequest.add(Request(
        date: DateTime.now(),
        number: 123005,
        status: RequestStatus.CANCEL,
        car: _cars[1],
        description: "Ремонт автосигнализации",
        dateRepair: DateTime.now(),
        signYourParts: Random().nextBool(),
        signNeedEvacuation: Random().nextBool()
//        List<String> photos;
//        List<Proposal> proposals;
        ));
    listRequest.add(Request(
        date: DateTime.now(),
        number: 123006,
        status: RequestStatus.DONE,
        car: _cars[1],
        description: "Замена фильтров: масла, воздушный, салонный.",
        dateRepair: DateTime.now(),
        signYourParts: Random().nextBool(),
        signNeedEvacuation: Random().nextBool()
//        List<String> photos;
//        List<Proposal> proposals;
        ));

    return listRequest;
  }
}
