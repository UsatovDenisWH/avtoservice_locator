import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/model/request.dart';
import 'package:avtoservicelocator/model/request_item.dart';
import 'package:flutter/material.dart';

class RequestScreenItem extends StatelessWidget {
  final RequestItem _requestItem;
  final RequestBloc _bloc;
  final Color bDazzledBlueColor = Color.fromARGB(0xFF, 0x2E, 0x58, 0x94);

  RequestScreenItem(this._requestItem, this._bloc);

  @override
  Widget build(BuildContext context) {
    var row1 = Padding(
        padding: EdgeInsets.only(top: 4, bottom: 8),
        child: Row(
          children: <Widget>[
            Text(
              "#${_requestItem.number}. ",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor()),
            ),
            Text(
              _requestItem.statusText,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor()),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ));

    var row2 = Text(
      "${_requestItem.descCar}",
      style: TextStyle(fontSize: 20.0),
      overflow: TextOverflow.ellipsis,
    );

    var row3 = Text("${_requestItem.descRequest}",
        style: TextStyle(fontSize: 16.0, color: Colors.black));

    var isProposals = _requestItem.descProposals.length == 2;
    var row4 = Padding(
        padding: EdgeInsets.only(top: 8, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.message,
              color: isProposals ? Colors.black : Colors.black54,
              size: 16.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "${_requestItem.descProposals[0]}",
              style: TextStyle(
                  fontSize: 16.0,
                  color: isProposals ? Colors.black : Colors.black54,
                  fontWeight: FontWeight.bold),
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
                    enabled: (_requestItem.status == RequestStatus.ACTIVE ||
                        _requestItem.status == RequestStatus.WORK))
              ],
            )
          ],
        ));
  }

  Color _getStatusColor() {
    var color = Colors.black;
    if (_requestItem.status == RequestStatus.ACTIVE) {
      color = bDazzledBlueColor;
    } else if (_requestItem.status == RequestStatus.WORK) {
      color = Colors.blue;
    } else if (_requestItem.status == RequestStatus.DONE) {
      color = Colors.green;
    } else if (_requestItem.status == RequestStatus.CANCEL) {
      color = Colors.black38;
    }
    return color;
  }
}
