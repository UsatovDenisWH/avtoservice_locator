import 'package:avtoservicelocator/bloc/autoservice_bloc.dart';
import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/data/utils.dart';
import 'package:avtoservicelocator/model/autoservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AutoserviceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AutoserviceScreenState();
}

class _AutoserviceScreenState extends State<AutoserviceScreen> {
  AutoserviceBloc _bloc;
  int _price;
  AutoService _autoService;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
    _price = _bloc.proposal.price;
    _autoService = _bloc.proposal.autoService;
  }

  @override
  Widget build(BuildContext context) {
    var bDazzledBlueColor = Color.fromARGB(0xFF, 0x2E, 0x58, 0x94);

    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ));
        },
      ),
    );

    var image = Image.network(
      _autoService.photos[0],
      fit: BoxFit.fitHeight,
      errorBuilder:
          (BuildContext context, Object error, StackTrace stackTrace) =>
              Text(error.toString()),
    );

    var row1 = Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              "${_autoService.name}",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              overflow: TextOverflow.ellipsis,
            )),
            Container(
              decoration: BoxDecoration(
                  color: bDazzledBlueColor,
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.all(4.0),
              child: Text(
                _autoService.userRating.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ));

    var row2 = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.star,
                    color: Colors.black38,
                  ))),
          Text(
            Utils.counterFeedbacksToText(count: _autoService.feedbacks.length),
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    var row3 = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.credit_card,
            color: Colors.orangeAccent,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "10% кэшбек",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    var button = Padding(
      padding: EdgeInsets.all(16.0),
      child: MaterialButton(
        color: Colors.lightBlueAccent,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Записаться на ремонт за ${_price} \u{20BD}",
                style: TextStyle(fontSize: 16.0, color: Colors.white))),
        onPressed: _bloc.onPressedSubscribeButton,
      ),
    );

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar,
        body: Column(
          children: <Widget>[image, row1, row2, row3, button],
        ));
  }
}
