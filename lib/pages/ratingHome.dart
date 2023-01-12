import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../services/RatingAPI.dart';
import '../utils/SnackBarHelper.dart';
import '../utils/storageLocal.dart';

class RatingHome extends StatefulWidget {
  const RatingHome({Key? key}) : super(key: key);

  @override
  State<RatingHome> createState() => _RatingHomeState();
}

class _RatingHomeState extends State<RatingHome> {
  double startrating = 0;

  Future onUpdate() async {
    var Profile = await StorageLocal.getUser();
    String message = await RatingAPI.updateRating(
        username: Profile.id!, ratingstart: startrating);
    Alert.show(context: context, msg: message);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating App'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Center(child: Text('Rate this app', style: TextStyle(fontSize: 25),),),
            const SizedBox(height: 20,),
            Center(
              child: RatingBar.builder(
                initialRating: startrating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  startrating = rating;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20,),
            Center(child: Text('${startrating}', style: TextStyle(fontSize: 25),),),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                onUpdate();
              },
              child: const Text("POST"),
            )
          ],
        ),
      ),
    );
  }
}
