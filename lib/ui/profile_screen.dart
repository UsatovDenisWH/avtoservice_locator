import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
//      body: StreamBuilder(
//        stream: _bloc.outRequestItems,
//        builder:
//            (BuildContext context, AsyncSnapshot<List<RequestItem>> snapshot) {
//          if (snapshot.data == null || snapshot.data.isEmpty) {
//            return Center(child: CircularProgressIndicator());
//          } else {
//            return ListView.separated(
//                padding: EdgeInsets.all(0),
//                itemCount: snapshot.data.length,
//                itemBuilder: (BuildContext context, int index) =>
//                    RequestScreenItem(snapshot.data[index], _bloc),
//                separatorBuilder: (BuildContext context, int index) =>
//                    const Divider(
//                      thickness: 5,
//                      color: Colors.black12,
//                    ));
//          }
//        },
//      ),
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
