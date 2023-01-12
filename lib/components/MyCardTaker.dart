import 'package:flutter/material.dart';

class MyCardTaker extends StatelessWidget {
  const MyCardTaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("12/12/2022"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("สุพจน์ ใจร่ม"),
              Text("8 ชั่วโมง / 2500บาท"),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('รอการตอบรับ'),
              ElevatedButton(
                onPressed: () {},
                child: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }
}
