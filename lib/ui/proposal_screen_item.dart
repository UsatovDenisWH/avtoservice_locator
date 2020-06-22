import 'package:avtoservicelocator/bloc/proposal_bloc.dart';
import 'package:avtoservicelocator/model/proposal_item.dart';
import 'package:flutter/material.dart';

class ProposalScreenItem extends StatelessWidget {
  final ProposalItem _proposalItem;
  final ProposalBloc _bloc;

  ProposalScreenItem(this._proposalItem, this._bloc);

  @override
  Widget build(BuildContext context) {
    var bDazzledBlueColor = Color.fromARGB(0xFF, 0x2E, 0x58, 0x94);

    var row1 = Text(
      "#${_proposalItem.name}. ${_proposalItem.price}",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: bDazzledBlueColor),
      overflow: TextOverflow.ellipsis,
    );

    var row2 = Text(
      "#${_proposalItem.name}. ${_proposalItem.price}",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: bDazzledBlueColor),
      overflow: TextOverflow.ellipsis,
    );

    var row3 = Text(
      "#${_proposalItem.name}. ${_proposalItem.price}",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: bDazzledBlueColor),
      overflow: TextOverflow.ellipsis,
    );

    var row4 = Text(
      "#${_proposalItem.name}. ${_proposalItem.price}",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: bDazzledBlueColor),
      overflow: TextOverflow.ellipsis,
    );

    var row5 = Text(
      "#${_proposalItem.name}. ${_proposalItem.price}",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: bDazzledBlueColor),
      overflow: TextOverflow.ellipsis,
    );


    return InkWell(
      onTap: () {
        _bloc.onTapProposalItem(item: _proposalItem);
      },
      highlightColor: Colors.blue,
      splashColor: Colors.blue,
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              row1,
              row2,
              row3,
              row4,
              row5,
            ],
          )),
    );
  }
}
