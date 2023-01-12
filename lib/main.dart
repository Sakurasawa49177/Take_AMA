import 'package:flutter/material.dart';
import 'package:take_ama/models/UserLogin.dart';
import 'package:take_ama/pages/admin/addNews.dart';
import 'package:take_ama/pages/admin/editDetail.dart';
import 'package:take_ama/pages/admin/editNews.dart';
import 'package:take_ama/pages/admin/news.dart';
import 'package:take_ama/pages/admin/user.dart';
import 'package:take_ama/pages/admin/menu.dart';
import 'package:take_ama/pages/careTaker/home.dart';
import 'package:take_ama/pages/careTaker/myOrderDetail.dart';
import 'package:take_ama/pages/client/caretakerCard.dart';
import 'package:take_ama/pages/client/caretakerDetail.dart';
import 'package:take_ama/pages/client/clientChatbot.dart';
import 'package:take_ama/pages/client/home.dart';
import 'package:take_ama/pages/client/selectLocation.dart';
import 'package:take_ama/pages/login.dart';
import 'package:take_ama/pages/ratingHome.dart';
import 'package:take_ama/pages/register.dart';
import 'package:take_ama/utils/storageLocal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/register": (context) => const RegisterPage(),
        "/caretaker": (context) => const CaretakerCardPage(),
        "/caretakerDetail": (context) => const CaretakerDetailPage(),
        "/client-home": (context) => const ClientHome(),
        "/caretaker-home": (context) => const CareTakerHome(),
        "/login": (context) => const LoginPage(),
        "/user-admin": (context) => const UserPage(),
        "/detail": (context) => const EditDetailPage(),
        "/menu-admin": (context) => const MenuPage(),
        "/news-admin": (context) => const NewsPage(),
        "/add-news": (context) => const AddNews(),
        "/edit-news": (context) => const EditNews(),
        "/ratingHome": (context) =>const RatingHome(),
        "/selectlocation": (context) => const SelectLocation(),
        "/myOrderDetail": (context) => const MyOrderDetail(),
        "/mychatbot": (context) => clientChatbot(),
      },
      home: FutureBuilder(
        future: StorageLocal.getUser(),
        builder: (context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.hasData) {
            Profile user = snapshot.data!;
            if (user.userType == "1") {
              return ClientHome();
            } else if (user.userType == "2") {
              return CareTakerHome();
            } else {
              return LoginPage();
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
