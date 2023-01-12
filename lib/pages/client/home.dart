import 'package:flutter/material.dart';
import 'package:take_ama/models/UserLogin.dart';
import 'package:take_ama/pages/client/caretakerCard.dart';
import 'package:take_ama/pages/client/myCaretaker.dart';
import 'package:take_ama/pages/shared/newsFeed.dart';
import 'package:take_ama/utils/storageLocal.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../components/UserCountCard.dart';
import '../../services/RatingAPI.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  String fullName = "John Doe";
  int pageIndex = 0;
  double starrating = 0;
  List<dynamic> pages = [
    const NewsFeed(),
    const CaretakerCardPage(),
    const MyCareTaker(),
  ];

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

  Future pushtoChatBot() async {
    await Navigator.pushNamed(context, "/mychatbot");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take AMA'),
        actions: <Widget>[
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
      body: pages[pageIndex],
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person_outline,
                      size: 50,
                    ),
                  ),
                  FutureBuilder(
                    future: StorageLocal.getUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Profile?> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      Profile profile = snapshot.data!;
                      return Text(
                        '${profile.firstName} ${profile.lastName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: RatingBar.builder(
                ignoreGestures: true,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Rating App ${starrating}'),
            ),
            SizedBox(
              height: 20,
            ),
            const UserCountCard(),
            ListTile(
              onTap: () {
                _selectChange(0);
              },
              selected: pageIndex == 0,
              leading: Icon(Icons.newspaper),
              title: Text('News'),
            ),
            ListTile(
              onTap: () {
                _selectChange(1);
              },
              selected: pageIndex == 1,
              leading: Icon(Icons.search),
              title: Text('Find Caretaker'),
            ),
            ListTile(
              onTap: () {
                _selectChange(2);
              },
              selected: pageIndex == 2,
              leading: Icon(Icons.my_library_books),
              title: Text('My Caretaker'),
            ),
            ListTile(
              onTap: () {
                pushtoChatBot();
              },
              leading: Icon(Icons.chat),
              title: Text('Chat bot'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _logout,
            )
          ],
        ),
      ),
    );
  }

  _selectChange(int index) {
    setState(() {
      pageIndex = index;
      Navigator.pop(context);
    });
  }

  _logout() {
    StorageLocal.clearUser();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
