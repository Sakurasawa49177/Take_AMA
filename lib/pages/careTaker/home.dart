import 'package:flutter/material.dart';
import 'package:take_ama/components/UserCountCard.dart';
import 'package:take_ama/pages/careTaker/setting.dart';
import '../../services/RatingAPI.dart';
import 'package:take_ama/pages/shared/newsFeed.dart';
import '../../utils/storageLocal.dart';
import 'myOrder.dart';

class CareTakerHome extends StatefulWidget {
  const CareTakerHome({super.key});
  @override
  State<CareTakerHome> createState() => _CareTakerHomeState();
}

class _CareTakerHomeState extends State<CareTakerHome> {
  int _selectedIndex = 0;
  double starrating = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    NewsFeed(),
    MyOrder(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    StorageLocal.getUser();
    getStartRating();
    super.initState();
  }

  Future getStartRating() async {
    starrating = await RatingAPI.getRating();
    setState(() {});
  }

  Future setRating() async {
    await Navigator.pushNamed(context, "/ratingHome");
    await getStartRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareTaker'),
        actions: <Widget>[
          UserCountCard(),
          IconButton(
            icon: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onPressed: () {
              setRating();
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
