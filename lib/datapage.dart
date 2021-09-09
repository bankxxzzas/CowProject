import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Setting.dart';
import 'package:flutter_application_2/adddata.dart';
import 'package:flutter_application_2/nof.dart';
import 'package:flutter_application_2/states/show_list_cowdata.dart';
import 'package:flutter_application_2/utility/my_constant.dart';

class Datapage extends StatefulWidget {
  const Datapage({Key? key}) : super(key: key);

  @override
  _DatapageState createState() => _DatapageState();
}

class _DatapageState extends State<Datapage> {
  List<String>? titles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titles = MyConstant.titles;
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(
                'Cow Management System',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                color: Colors.black,
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await Firebase.initializeApp().then((value) async {
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/authen', (route) => false));
                  });
                },
              )
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green, Colors.blueGrey],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft)),
            ),
            bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: MaterialButton(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.face_retouching_natural_rounded,
                            color: Colors.black,
                          ),
                          Text(
                            'โปรไฟล์',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Adddata()));
                    },
                  ),
                ),
                Tab(
                  icon: MaterialButton(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.notifications_active,
                            color: Colors.black,
                          ),
                          Text(
                            'แจ้งเตือน',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Adddata()));
                    },
                  ),
                ),
                Tab(
                  icon: MaterialButton(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          Text(
                            'ออกระบบ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      await Firebase.initializeApp().then((value) async {
                        await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/authen', (route) => false));
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 56),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cow22.png'),
                      fit: BoxFit.cover)),
              child: Center(
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/addata.png'),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        color: Colors.white,
                                        width: 160,
                                        child:
                                            Center(child: Text('เพิ่มข้อมูล'))),
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Adddata()));
                            },
                          ),
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/men.png'),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        color: Colors.white,
                                        width: 160,
                                        child:
                                            Center(child: Text('พ่อพันธุ์'))),
                                  ],
                                )),
                            onPressed: () {
                              myNavigator(0);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                child: Container(
                                    width: 135,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.white, // set border color
                                          width: 7.0), // set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0)), // set rounded corner radius
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/women.png'),
                                        Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            color: Colors.white,
                                            width: 160,
                                            child: Center(
                                                child: Text('แม่พันธุ์'))),
                                      ],
                                    )),
                                onPressed: () {
                                  myNavigator(1);
                                },
                              ),
                              MaterialButton(
                                child: Container(
                                    width: 135,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.white, // set border color
                                          width: 7.0), // set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0)), // set rounded corner radius
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/wagyu.png'),
                                        Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            color: Colors.white,
                                            width: 160,
                                            child:
                                                Center(child: Text('วัวขุน'))),
                                      ],
                                    )),
                                onPressed: () {
                                  myNavigator(2);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/nof.png'),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        color: Colors.white,
                                        width: 160,
                                        child:
                                            Center(child: Text('แจ้งเตือน'))),
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => nof()));
                            },
                          ),
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/setting.png'),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        color: Colors.white,
                                        width: 160,
                                        child: Center(child: Text('ตั้งค่า'))),
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Setting()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void myNavigator(int index) {
    print('###key ==>> ${titles![index]}');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowListCowData(
            type: titles![index],
          ),
        ));
  }
}
