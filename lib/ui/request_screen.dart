import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/request_bloc.dart';
import 'package:avtoservicelocator/model/request_item.dart';
import 'package:avtoservicelocator/ui/request_screen_item.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  RequestBloc _bloc;
  AppBar _appBar;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
//    _appBar = _defaultAppBar();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Заявки'),
      ),
      body: StreamBuilder(
        stream: _bloc.outRequestItems,
        builder:
            (BuildContext context, AsyncSnapshot<List<RequestItem>> snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
                padding: EdgeInsets.all(0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    RequestScreenItem(snapshot.data[index], _bloc),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      thickness: 5,
                      color: Colors.black12,
                    ));
          }
        },
      ),
      bottomNavigationBar: _bottomNavigationBar());

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        currentIndex: _bloc.bottomNavigationBarIndex,
        onTap: (int index) => _bloc.onTapBottomNavigationBar(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        selectedIconTheme: IconThemeData(size: 28),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Заявки'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Поиск СТО'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Профиль'),
          ),
        ],
      );

/*  AppBar _defaultAppBar() =>
      AppBar(
        leading: Builder(
          builder: (BuildContext context) =>
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _setAppBar(action: AppBarAction.MENU);
                  _bloc.onTapMenuButton();
                },
              ),
        ),
        title: Text(_currentUser.getFullName()),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _setAppBar(action: AppBarAction.SEARCH);
            },
          ),
        ],
      );

  AppBar _searchAppBar() =>
      AppBar(
        leading: Builder(
          builder: (BuildContext context) =>
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _clearSearchQuery();
                  _setAppBar(action: AppBarAction.NONE);
                },
              ),
        ),
        title: TextField(
          controller: _searchQueryController,
          autofocus: true,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70, fontSize: 20.0),
          ),
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearSearchQuery,
          ),
        ],
      );

  void _setAppBar({@required AppBarAction action}) {
    setState(() {
      if (action == AppBarAction.SEARCH) {
        _appBar = _searchAppBar();
      } else {
        _appBar = _defaultAppBar();
      }
    });
  }*/

}
