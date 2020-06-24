import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/request_item.dart';
import 'package:flutter/material.dart';

class RequestScreenItem extends StatelessWidget {
  final RequestItem _requestItem;
  final RequestBloc _bloc;

  RequestScreenItem(this._requestItem, this._bloc);

  @override
  Widget build(BuildContext context) {
    var bDazzledBlueColor = Color.fromARGB(0xFF, 0x2E, 0x58, 0x94);

    var statusText;
    if (_requestItem.status == RequestStatus.ACTIVE) {
      statusText = "Активная заявка";
    } else if (_requestItem.status == RequestStatus.DONE) {
      statusText = "Завершённая заявка";
    } else if (_requestItem.status == RequestStatus.CANCEL) {
      statusText = "Отменённая заявка";
    }

    var row1 = Text(
      "#${_requestItem.number}. $statusText",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: bDazzledBlueColor),
      overflow: TextOverflow.ellipsis,
    );

    var row2 = Text(
      "${_requestItem.descCar}",
      style: TextStyle(fontSize: 20.0),
      overflow: TextOverflow.ellipsis,
    );

    var row3 = Text("${_requestItem.descRequest}",
        style: TextStyle(fontSize: 20.0, color: Colors.black54));

    var isProposals = _requestItem.descProposals.length == 2;
    var row4 = Padding(
        padding: EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.message,
              color: Colors.black54,
              size: 16.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "${_requestItem.descProposals[0]}",
              style: TextStyle(fontSize: 16.0),
            ),
            isProposals
                ? Row(
                    children: <Widget>[
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(
                        Icons.monetization_on,
                        color: Colors.black,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "${_requestItem.descProposals[1]}",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ));

    return InkWell(
        onTap: () {
          _bloc.onTapRequestItem(item: _requestItem);
        },
        highlightColor: Colors.blue,
        splashColor: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        row1,
                        SizedBox(
                          height: 4.0,
                        ),
                        row2,
                        SizedBox(
                          height: 4.0,
                        ),
                        row3,
                        SizedBox(
                          height: 4.0,
                        ),
                        row4,
                      ],
                    ))),
            PopupMenuButton<SelectedItemMenu>(
              onSelected: (SelectedItemMenu result) {
                _bloc.onSelectedItemMenu(result);
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SelectedItemMenu>>[
                PopupMenuItem<SelectedItemMenu>(
                    value: SelectedItemMenu.CANCEL,
                    child: Text("Отменить заявку"),
                    enabled: _requestItem.status == "Активная заявка")
              ],
            )
          ],
        ));
  }
}
