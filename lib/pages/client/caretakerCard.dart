import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:take_ama/models/UserLogin.dart';
import 'package:take_ama/services/UserAPI.dart';

class CaretakerCardPage extends StatefulWidget {
  const CaretakerCardPage({Key? key}) : super(key: key);

  @override
  State<CaretakerCardPage> createState() => _CaretakerCardPageState();
}

class _CaretakerCardPageState extends State<CaretakerCardPage> {
  var images = [
    'https://img.freepik.com/free-photo/young-asian-woman-with-winning-gestere-isolated-white-wall_231208-1136.jpg?w=740&t=st=1671357890~exp=1671358490~hmac=b0575341ef258910038046cdeb7f8e94d1de83c6633eac48f7a06e58518e9c8b',
    'https://img.freepik.com/free-photo/portrait-young-asia-lady-with-positive-expression-arms-crossed-smile-broadly-dressed-casual-clothing-looking-camera-pink-background_7861-3201.jpg?w=1380&t=st=1671357326~exp=1671357926~hmac=4a67b0b4bf08fb4f1607de8312a97e55649165bdf7ecb89d89b621b7cf822d1f',
    'https://img.freepik.com/free-photo/smiling-asian-man-using-tablet-computer_1262-18324.jpg?w=1380&t=st=1671357214~exp=1671357814~hmac=cb7af27a22f8c061e3123a09bcf8474618addb931e98b61eac3b2f7af3f0ebe1',
    'https://img.freepik.com/free-photo/happy-young-asian-male-feeling-happy-smiling-looking-front-while-relaxing-kitchen-home_7861-2875.jpg?w=1380&t=st=1671357385~exp=1671357985~hmac=bfe8c72e46a990bbe187c7022abaaad9dd8e95683ecaf9b6f69398d1611800c7',
    'https://img.freepik.com/free-photo/smart-attractive-asian-glasses-male-standing-smile-with-freshness-joyful-casual-blue-shirt-portrait-white-background_609648-1226.jpg?w=740&t=st=1671356994~exp=1671357594~hmac=e88ff1c51915d078e9fa1b0b4641e7fbaf35dfad3ea636b6bb84bce3e271d415',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: UserAPI.getAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Profile?>> snapshot) {
            if (snapshot.hasData) {
              List<Profile?> caretakers = snapshot.data!;
              caretakers = caretakers.where((e) => e!.userType == "2").toList();
              var images = generateImg(caretakers.length);
              return Swiper(
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  Profile caretaker = caretakers[index]!;
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${caretaker.firstName} ${caretaker.lastName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                '${DateTime.now().year - int.parse(caretaker.birthDay!)} Year',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _selectCareTaker(caretaker);
                                },
                                child: const Text("Select"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: caretakers.length,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  _selectCareTaker(Profile profile) {
    Navigator.pushNamed(context, "/caretakerDetail", arguments: profile);
  }

  List<String> generateImg(int length) {
    List<String> imgs = [];
    int v = 0;
    for (int i = 0; i < length; i++) {
      imgs.add(images[v]);
      if (i == images.length - 1) v = 0;
      v++;
    }
    return imgs;
  }
}
