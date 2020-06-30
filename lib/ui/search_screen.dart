import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/search_bloc.dart';
import 'package:avtoservicelocator/model/autoservice_item.dart';
import 'package:avtoservicelocator/ui/search_screen_item.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Поиск СТО'),
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.blue,
                  tabs: <Widget>[
                    Tab(text: 'Список'),
                    Tab(text: 'На карте'),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: <Widget>[
                      StreamBuilder(
                        stream: _bloc.outAutoServiceItems,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<AutoServiceItem>> snapshot) {
                          if (snapshot.data == null || snapshot.data.isEmpty) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListView.separated(
                                padding: EdgeInsets.all(0),
                                itemCount: snapshot.data.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        SearchScreenItem(
                                            snapshot.data[index], _bloc),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                          thickness: 5,
                                          color: Colors.black12,
                                        ));
                          }
                        },
                      ),
                      Container(
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
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
}
