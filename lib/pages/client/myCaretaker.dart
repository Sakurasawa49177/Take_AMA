import 'package:flutter/material.dart';

import '../../components/MyCardTaker.dart';
import '../../models/Order.dart';
import '../../services/OrderAPI.dart';
import '../../utils/storageLocal.dart';

class MyCareTaker extends StatefulWidget {
  const MyCareTaker({Key? key}) : super(key: key);

  @override
  State<MyCareTaker> createState() => _MyCareTakerState();
}

class _MyCareTakerState extends State<MyCareTaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: OrderAPI.getById(id: globalProfile!.id!, userType: '1'),
      builder: (BuildContext context, AsyncSnapshot<OrderDetail?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('No data'));
        }
        OrderDetail orderDetail = snapshot.data!;
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text('${orderDetail.careTaker!} ${orderDetail.hours} ชั่วโมง'),
          subtitle: Text('${orderDetail.price} บาท'),
          trailing: Text(orderDetail.orderStatus!),
          onTap: () {
            Navigator.pushNamed(context, '/myOrderDetail',
                    arguments: orderDetail)
                .then((value) {
              setState(() {});
            });
          },
        );
      },
    ));
  }
}
