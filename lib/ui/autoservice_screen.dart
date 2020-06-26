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
  AutoService _autoService;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
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

    var buttonBack = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    var image = Image.network(
      _autoService.photos[0],
      height: 250,
      fit: BoxFit.cover,
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
      padding: EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 16),
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

    var isClickable = _bloc.isSubscribeButtonClickable;
    var buttonSubscribe = Padding(
      padding: EdgeInsets.all(16.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        color: isClickable ? Colors.lightBlueAccent : Colors.black12,
        minWidth: 350,
        elevation: isClickable ? 2 : 0,
        highlightElevation: isClickable ? 8 : 0,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(_bloc.subscribeButtonText,
                style: TextStyle(fontSize: 16.0, color: Colors.white))),
        onPressed: _bloc.onPressedSubscribeButton,
      ),
    );

    var row4 = Padding(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Описание",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ));

    var row5 = InkWell(
        onTap: _bloc.onTapAutoserviceLocation,
        splashColor: Colors.lightBlueAccent,
        highlightColor: Colors.lightBlueAccent,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.map,
                color: Colors.blue,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: Text(
                _autoService.address,
                style: TextStyle(
                    fontSize: 18.0,
//              fontWeight: FontWeight.bold,
                    color: Colors.black),
                overflow: TextOverflow.ellipsis,
              )),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                Icons.arrow_forward_ios,
//            color: Colors.blue,
              ),
            ],
          ),
        ));

    var row6 = Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(_autoService.description,
            style: TextStyle(
                fontSize: 16.0,
//              fontWeight: FontWeight.bold,
                color: Colors.black)));

    return Scaffold(
        body: Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            image,
            row1,
            row2,
            row3,
            buttonSubscribe,
            row4,
            row5,
            row6
          ],
        ),
        Align(alignment: Alignment(-1.0, -0.92), child: buttonBack)
      ],
    ));
/*        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[image, row1, row2, row3, buttonSubscribe, row4, row5, row6],
        )*/
  }
}
