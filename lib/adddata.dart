import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/cowdata_model.dart';
import 'package:flutter_application_2/utility/my_constant.dart';
import 'package:flutter_application_2/utility/my_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Adddata extends StatefulWidget {
  const Adddata({Key? key}) : super(key: key);

  @override
  _AdddataState createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
  String? type;

  String? gendle;
  String? dateChooseStr;
  String? dateChooseLtr;
  String? dateMix;
  String? dateAge;
  String? ageString;

  final formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  File? file;
  final ImagePicker picker = ImagePicker();
  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await picker.getImage(
          source: imageSource, maxHeight: 600.0, maxWidth: 600.0);

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูล'),
        actions: [
          IconButton(
              onPressed: () => processSaveDate(), icon: Icon(Icons.upload))
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //text
                  buildtitle('รหัส'),
                  formIdCode(),
                  buildtitle('ประเภท'),
                  buildType(),
                  (type == null)
                      ? SizedBox()
                      : type == 'แม่พันธุ์'
                          ? buildMix()
                          : SizedBox(),
                  buildtitle('เพศ'),
                  buildgendle(),
                  buildtitle('เกิดวันที่'),
                  builddateAge(),
                  //formAge(),
                  buildtitle('วันที่ฉีดวัคซีนโรคมือปากเท้าเปื่อย'),
                  builddate(),
                  buildtitle('วันที่ฉีดวัคซีนโรคลัมปีสกิน'),
                  builddateNew(),
                  buildPhoto(),
                  buildSave(constraints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMix() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildtitle('วันที่ผสมพันธุ์'),
            ListTile(
              onTap: () => chooseDateMix(),
              leading: Icon(Icons.date_range),
              title: Text(dateMix == null ? 'dd-MM-yyyy' : dateMix!),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> chooseDateMix() async {
    DateTime dateTime = DateTime.now();
    String showDateTime = dateTime.toString();

    DateTime? chooseDateTime = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(dateTime.year - 10),
        lastDate: DateTime(dateTime.year + 10));

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      dateMix = dateFormat.format(chooseDateTime!);
    });

    print('chooseDateTime == $dateMix');
  }

  Container buildSave(BoxConstraints constraints) => Container(
        width: constraints.maxHeight,
        child: ElevatedButton(
          onPressed: () => processSaveDate(),
          child: Text('บันทึกข้อมูล'),
        ),
      );

  Row buildPhoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          child: file == null
              ? Image.asset('assets/images/addata.png')
              : Image.file(file!),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Container formAge() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      height: 50,
      child: TextFormField(
        controller: ageController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก อายุ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container formIdCode() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      height: 50,
      child: TextFormField(
        controller: idController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก รหัส';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildtitle(String title) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(top: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ));
  }

  Container builddateAge() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      child: ListTile(
        leading: Icon(Icons.date_range),
        title: Text(dateAge == null ? 'dd-MM-YYYY' : dateAge!),
        subtitle: Text(ageString == null ? '' : ageString!),
        onTap: () => chooseDateAge(),
      ),
    );
  }

  Future<Null> chooseDateAge() async {
    DateTime dateTime = DateTime.now();
    String showDateTime = dateTime.toString();

    DateTime? chooseDateTime = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(dateTime.year - 10),
        lastDate: DateTime(dateTime.year + 10));

    print('### chooseDateTime for AGE ==>> $chooseDateTime');

    var diff = dateTime.difference(chooseDateTime!).inDays;

    print('### diff ==> $diff');

    double year = 0;
    double month = 0;
    double day = 0;

    if (diff >= 365) {
      var secDay = diff % 365;
      int dd = diff - secDay;
      year = dd / 365;

      if (secDay >= 30) {
        var secDay2 = secDay % 30;
        int dd2 = secDay - secDay2;
        month = dd2 / 30;
        day = secDay2.toDouble();
      } else {
        day = secDay.toDouble();
      }

      // print('## year = $year , month = $month, day = $day');
      createStringFromDouble(year, month, day);
    } else if (diff >= 30) {
      // ไม่ถึงปี แต่เกินเดือน
      var secDay = diff % 30;
      int dd = diff - secDay;
      month = dd / 30;
      day = secDay.toDouble();
      // print('month ==>$month ,day ==> $day');
      createStringFromDouble(year, month, day);
    } else {
      // ไม่ถึงเดือน
      day = diff.toDouble();
      // print('## year = $year , month = $month, day = $day');
      createStringFromDouble(year, month, day);
    }

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      dateAge = dateFormat.format(chooseDateTime);
    });
  }

  void createStringFromDouble(double year, double mounth, double day) {
    print('### year -> $year, month ->$mounth, day = $day');
    List<String> strings = [];
    if (year != 0) {
      int yearInt = year.toInt();
      strings.add('$yearInt ปี');
    }

    if (mounth != 0) {
      int mounthInt = mounth.toInt();
      strings.add('$mounthInt เดือน');
    }

    if (day != 0) {
      int dayInt = day.toInt();
      strings.add('$dayInt วัน');
    }

    print('##### strings ===>> $strings');
    String string = strings.toString();
    setState(() {
      ageString = string.substring(1, string.length - 1);
    });
    print('#### ageString ==>> $ageString');
  }

  Container builddate() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      child: ListTile(
        leading: Icon(Icons.date_range),
        title: Text(dateChooseStr == null ? 'dd-MM-YYYY' : dateChooseStr!),
        onTap: () => chooseDate(),
      ),
    );
  }

  Future<Null> chooseDate() async {
    DateTime dateTime = DateTime.now();
    String showDateTime = dateTime.toString();

    DateTime? chooseDateTime = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(dateTime.year - 10),
        lastDate: DateTime(dateTime.year + 10));

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      dateChooseStr = dateFormat.format(chooseDateTime!);
    });

    print('chooseDateTime == $dateChooseStr');
  }

   Container builddateNew() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      child: ListTile(
        leading: Icon(Icons.date_range),
        title: Text(dateChooseLtr == null ? 'dd-MM-YYYY' : dateChooseLtr!),
        onTap: () => chooseDateNew(),
      ),
    );
  }

  Future<Null> chooseDateNew() async {
    DateTime dateTime = DateTime.now();
    String showDateTime = dateTime.toString();

    DateTime? chooseDateTime = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(dateTime.year - 10),
        lastDate: DateTime(dateTime.year + 10));

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      dateChooseLtr = dateFormat.format(chooseDateTime!);
    });

    print('chooseDateTime == $dateChooseLtr');
  }


  Container buildgendle() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      height: 50,
      child: type == null ? SizedBox() : Text(gendle!),
    );
  }

  Container buildType() {
    List<String> titles = MyConstant.titles;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      height: 50,
      child: DropdownButton(
        onChanged: (value) {
          setState(() {
            type = value as String?;
            if (type == titles[1]) {
              gendle = 'เพศเมีย';
            } else {
              gendle = 'เพศผู้';
            }
          });
        },
        hint: Text('กรุณาเลือก ประเภท'),
        value: type,
        items: titles
            .map(
              (e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<Null> processSaveDate() async {
    if (formKey.currentState!.validate()) {
      if (type == null) {
        MyDialog().nomalDialog(
            context, 'ยังไม่ได้เลือก ประเภท', 'โปรดเลือก ประเภทด้วยครับ');
      } else if (dateChooseStr == null) {
        MyDialog().nomalDialog(
            context, 'ยังไม่ได้ เลือกวันที่ฉีด', 'กรุณาเลือก วันที่ฉีด');
      } else if (file == null) {
        MyDialog().nomalDialog(context, 'ยังไม่มีภาพ ?',
            'กรุณาถ่ายภาพ หรือ เลือกจาก Gallery ด้วย');
      } else {
        String idCode = idController.text;
        String age = ageController.text;

        await Firebase.initializeApp().then((value) async {
          await FirebaseAuth.instance.authStateChanges().listen((event) async {
            String uid = event!.uid;

            int i = Random().nextInt(1000000);
            String nameFile = 'cow$i.jpg';

            FirebaseStorage storage = FirebaseStorage.instance;
            var refer = storage.ref().child('cowpic/$nameFile');
            UploadTask task = refer.putFile(file!);
            await task.whenComplete(() async {
              await refer.getDownloadURL().then((value) async {
                String pathImage = value;

                CowDataModel model = CowDataModel(
                    ageString: ageString!,
                    dateChoose: dateChooseStr!,
                    gendle: gendle!,
                    idCode: idCode,
                    pathImage: pathImage,
                    type: type!,
                    uidRecord: uid, 
                    dateChooseNew: dateChooseLtr!, 
                    
                    );

                Map<String, dynamic> map = model.toMap();
                await FirebaseFirestore.instance
                    .collection('cowdata')
                    .doc(idCode)
                    .set(map)
                    .then((value) async {
                  if (dateMix != null) {
                    Map<String, dynamic> data = {};
                    data['dateMix'] = dateMix;
                    await FirebaseFirestore.instance
                        .collection('cowdata')
                        .doc(idCode)
                        .collection('mix')
                        .doc()
                        .set(data)
                        .then((value) => Navigator.pop(context));
                  } else {
                    Navigator.pop(context);
                  }
                });

                // print('## idCode = $idCode, type = $type , gendle = $gendle');
                //  print(
                //     '## age = $age, datechoose = $dateChooseStr , uid = $uid, pathImage = $pathImage');
              });
            });
          });
        });
      }
    }
  }
}
