import 'package:avtoservicelocator/bloc/common/bloc_provider.dart';
import 'package:avtoservicelocator/bloc/profile_bloc.dart';
import 'package:avtoservicelocator/model/user.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _bloc;
  User _user;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.context = context;
    _user = _bloc.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      leading: Icon(
        Icons.account_box,
        size: 28,
        color: Colors.white,
      ),
      title: Text('Профиль'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: _onTapExitButton,
        ),
      ],
    );

    var userCard = InkWell(
        onTap: () => _onTapListTile(item: ProfileListItem.USER_CARD),
        child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/user.png'),
                    backgroundColor: Colors.white38,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _user.name ?? 'Имя не заполнено',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    _user.phoneNumber,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ));

    var line = Container(
      height: 1,
      color: Colors.black38,
    );

    var eMail = InkWell(
        onTap: _showEditEmailDialog,
        child: Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: ListTile(
              leading: Icon(Icons.alternate_email),
              title: Text(
                _user.eMail ?? 'E-mail не заполнен',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            )));

    var country = InkWell(
        onTap: _showEditCountryDialog,
        child: Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text(
                _user.country ?? 'Страна не выбрана',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            )));

    var region = InkWell(
        onTap: _showEditRegionDialog,
        child: Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: ListTile(
              leading: Icon(Icons.memory),
              title: Text(
                _user.region ?? 'Регион не выбран',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            )));

    var city = InkWell(
        onTap: _showEditCityDialog,
        child: Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: ListTile(
              leading: Icon(Icons.location_city),
              title: Text(
                _user.city ?? 'Город не выбран',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            )));

    var cars = InkWell(
        onTap: () => _onTapListTile(item: ProfileListItem.CARS),
        child: Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: ListTile(
              leading: Icon(Icons.local_taxi),
              title: Text(
                _user.getUserCarsDescription() ?? 'Автомобиль не выбран',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            )));

    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[userCard, line, eMail, country, region, city, cars],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

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

  void _onTapExitButton() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Выйти из текущего профиля?'),
//          content: Text('dialogBody'),
          actions: <Widget>[
            FlatButton(
              child: Text('НЕТ'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text('ДА'),
              onPressed: () {
                _bloc.logoutUser();
              },
            ),
          ],
        );
      },
    );
  }

  void _onTapListTile({@required ProfileListItem item}) {}

  void _showEditEmailDialog() {
    final TextEditingController _emailFieldController = TextEditingController();
    _emailFieldController.text = _user.eMail ?? '';

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('E-mail'),
          content: TextFormField(
            controller: _emailFieldController,
            autofocus: true,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'user@mail.ru',
            ),
            autovalidate: true,
            validator: (String value) {
              return _bloc.isValidEmail(email: value)
                  ? null
                  : 'Неверный формат e-mail';
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ОК'),
              onPressed: () {
                var text = _emailFieldController.text.toString();
                if (_bloc.isValidEmail(email: text)) {
                  setState(() {
                    _user.eMail = text == '' ? null : text;
                  });
                  _bloc.updateProfile();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCountryDialog() {
    String oldResult = _user.country;
    String result = _user.country;

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Страна'),
          content: DropdownButtonFormField<String>(
            hint: Text('Выберите страну'),
            value: result,
            elevation: 4,
            items: _bloc.listCountries
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(child: Text(value), value: value);
            }).toList(),
            onChanged: (String value) {
              result = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ОК'),
              onPressed: () {
                if (result != oldResult) {
                  setState(() {
                    _user.country = result == '' ? null : result;
                    _user.region = null;
                    _user.city = null;
                  });
                  _bloc.updateProfile();
                  _bloc.updateReferenceList();
                }
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditRegionDialog() {
    String oldResult = _user.region;
    String result = _user.region;

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Регион'),
          content: DropdownButtonFormField<String>(
            hint: Text('Выберите регион'),
            value: result,
            elevation: 4,
            items:
                _bloc.listRegions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(child: Text(value), value: value);
            }).toList(),
            onChanged: (String value) {
              result = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ОК'),
              onPressed: () {
                if (result != oldResult) {
                  setState(() {
                    _user.region = result == '' ? null : result;
                    _user.city = null;
                  });
                  _bloc.updateProfile();
                  _bloc.updateReferenceList();
                }
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCityDialog() {
    String oldResult = _user.city;
    String result = _user.city;

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Город'),
          content: DropdownButtonFormField<String>(
            hint: Text('Выберите город'),
            value: result,
            elevation: 4,
            items: _bloc.mapCities.keys
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(child: Text(value), value: value);
            }).toList(),
            onChanged: (String value) {
              result = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ОК'),
              onPressed: () {
                if (result != oldResult) {
                  setState(() {
                    _user.city = result == '' ? null : result;
                    _user.location =
                        result == '' ? null : _bloc.mapCities[result];
                  });
                  _bloc.updateProfile();
//                  _bloc.updateReferenceList();
                }
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
