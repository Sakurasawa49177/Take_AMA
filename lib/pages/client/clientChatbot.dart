import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/SnackBarHelper.dart';

class clientChatbot extends StatefulWidget {
  @override
  _clientChatbotState createState() => _clientChatbotState();
}

class _clientChatbotState extends State<clientChatbot> {
  // late DialogFlowtter dialogFlowtter;
  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    // DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  @override
  Widget build(BuildContext context) {
    //var themeValue = MediaQuery.of(context).platformBrightness;
    var themeValue = Brightness.dark;
    return Scaffold(
      backgroundColor: themeValue == Brightness.dark
          ? HexColor('#f3f6f4')
          : HexColor('#2196f3'),
      appBar: AppBar(
        backgroundColor: themeValue == Brightness.dark
            ? HexColor('#2196f3')
            : HexColor('#BFBFBF'),
        title: Text(
          'Chat Bot',
          style: TextStyle(
              color:
              themeValue == Brightness.dark ? Colors.white : Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Body(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: TextStyle(
                          color: themeValue == Brightness.dark
                              ? Colors.black
                              : Colors.black,
                          fontFamily: 'Poppins'),
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: themeValue == Brightness.dark
                                    ? Colors.black
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        hintStyle: TextStyle(
                          color: themeValue == Brightness.dark
                              ? Colors.black54
                              : Colors.black54,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        labelStyle: TextStyle(
                            color: themeValue == Brightness.dark
                                ? Colors.black
                                : Colors.black),
                        hintText: 'Send a message',
                      ),
                    ),
                  ),
                  IconButton(
                    color: themeValue == Brightness.dark
                        ? Colors.blue
                        : Colors.blue,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      sendMessage(messageController.text);
                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      addMessage(
        Message(text: DialogText(text: [text])),
        true,
      );
    });
    try {
      //region DetectIntentResponse
      // DetectIntentResponse response = await dialogFlowtter.detectIntent(
      //   queryInput: QueryInput(text: TextInput(text: text)),
      // );
      //
      // if (response.message == null) return;
      // setState(() {
      //   addMessage(response.message!);
      // });
      //endregion

      // await Future.delayed(Duration(seconds: 1));
      // setState(() {
      //    addMessage(Message(text: DialogText(text: ['กรุณารอสักครู่ระบบกำลังประมวณผล'])),
      //        false);
      // });
      await Future.delayed(Duration(seconds: 2));

      String bot_message = "ขอโทษครับไม่เข้าใจคำถาม กรุณาถามอีกครั้ง";
      if (text == "รพ" || text == "โรงพยาบาล" || text.contains('โรงพยาบาล') || text.contains('รพ')) {
        bot_message = "โรงพยาบาลที่แนะนำ";
        bot_message += "\n1.) โรงพยาบาลกรุงเทพ\n2.) โรงพยาบาลพญาไท 3\n3.) โรงพยาบาลมิตรประชา";
        // bot_message += "\nและนี่ก็คือลิ้งไปยังโรงพยาบาลกรุงเทพโรงพยาบาลกรุงเทพนะครับ\n02 310 3000 \n https://goo.gl/maps/1q3Voae9Uh9zWydK7";
      }
      else if (text == "สถานที่ท่องเที่ยว" || text == "ท่องเที่ยว" || text.contains('เที่ยว')) {
        bot_message = "สถานที่ท่องเที่ยวแนะนำ";
        bot_message += "\n1.) ตลาดนัดสวนจตุจักร\n2.) ถนนข้าวสาร\n3.) เยาวราช";
      }
      else if (text == "วัด" || text == "วัด" || text.contains('วัด') || text.contains('บุญ')) {
        bot_message = "วัดที่แนะนำ";
        bot_message += "\n1.) วัดนิเวศธรรมประวัติราชวรวิหาร\n2.) วัดพระปฐมเจดีย์ราชวรมหาวิหาร\n3.) วัดศีรษะทอง";
      }
      else if (text == "ห้างสรรพสินค้า" || text == "ห้าง" || text.contains('ซื้อของ') || text.contains('ช็อปปิ้ง') || text.contains('Shopping') || text.contains('ห้าง')) {
        bot_message = "แนะ 5 ห้างสรรพสินค้าดังในกรุงเทพฯ";
        bot_message += "\n1.) MBK Center\n2.) เซ็นทรัลเวิลด์\n3.) สยามพารากอน\n4.) ไอคอน สยาม\n5.) เดอะมอลล์ท่าพระ";
      }
      else if (text == "สวัสดี" || text == "หวัดดี" || text.contains('สวัสดี') || text.contains('Hi') || text.contains('Hello') || text.contains('hi') || text.contains('hello')) {
        bot_message = "สวัสดี\n";
        bot_message += "ยินดีต้อนรับเข้าสู่ Take AMA Application.";
      }
      else if (text == "ปวดขา" || text == "ขา"|| text.contains('ปวดขา') || text.contains('ขา')) {
        bot_message = "เมื่อยขาจัดการได้ง่ายนิดเดียว!";
        bot_message += "\n1.) แช่เท้าในน้ำเกลือยิปซั่ม\n2.) พาดขาบนเก้าอี้หรือหมอน\n3.) ใช้ยานวด นวดบริเวณที่ปวด";
      }
      else if (text == "นอนไม่หลับ" || text == "นอนไม่หลับ"|| text.contains('นอน') || text.contains('หลับ')) {
        bot_message = "วิธีการแก้ปัญหาอาการนอนไม่หลับในผู้สูงอายุ!";
        bot_message += "\n1.) จัดสภาพแวดล้อมของห้องนอน\n2.) หลีกเลี่ยงการดื่มชา กาแฟ ในช่วงเวลาเย็น และไม่ควรดื่มน้ำในช่วงเวลา 4-5 ชั่วโมงก่อนที่จะถึงเวลาเข้านอน\n3.) งดการนอนกลางวัน หรือจำกัดเวลาการนอนกลางวัน ไม่ควรเกินครึ่งชั่วโมงในช่วงบ่าย";
      }
      else if (text == "อาหาร" || text == "เมนู"|| text.contains('อาหาร') || text.contains('เมนู') || text.contains('ข้าว') || text.contains('หิว')) {
        bot_message = "เมนูอาหารแนะนำที่อร่อยสุดๆ";
        bot_message += "\n1.) โจ๊กข้าวโอ๊ต\n2.) ข้าวต้มปลา\n3.) ต้มเลือดหมู\n4.) แกงจืดไข่น้ำหมูสับ\n5.) ต้มจับฉ่ายน่องไก่";
      }
      addMessage(Message(text: DialogText(text: [bot_message])),
          false);

      setState(() {});
    }
    catch (error) {
      Alert.show(context: context, msg: error.toString());
    }
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    }
    );
  }


  @override
  void dispose() {
    // ทำงานหลังปิด
    // dialogFlowtter.dispose();
    super.dispose();
  }
}

class Body extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const Body({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        Message message = obj['message'];
        bool isUserMessage = obj['isUserMessage'] ?? false;
        return Row(
          mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _MessageContainer(
              message: message,
              isUserMessage: isUserMessage,
            ),
          ],
        );
      },
      separatorBuilder: (_, i) => Container(height: 10),
      itemCount: messages.length,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
    );
  }
}


class _MessageContainer extends StatelessWidget {
  final Message message;
  final bool isUserMessage;

  const _MessageContainer({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      constraints: BoxConstraints(maxWidth: 250),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Container(
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue : Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              message.text?.text?[0] ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),

          );
        },
      ),
    );
  }
}