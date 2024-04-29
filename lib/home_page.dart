

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:mentoring/login.dart';
import 'package:mentoring/profilenew.dart';
import 'package:mentoring/sa.dart';
import 'package:mentoring/user_adddiary.dart';
import 'package:mentoring/user_chngepwd.dart';
import 'package:mentoring/user_mentoringclass.dart';
import 'package:mentoring/user_sendcmplt.dart';
import 'package:mentoring/user_sendreview.dart';
import 'package:mentoring/user_viewdiary.dart';
import 'package:mentoring/user_viewprofile.dart';
import 'package:mentoring/user_viewreply.dart';
import 'package:mentoring/user_viewtips.dart';
import 'package:mentoring/viewcontacts.dart';
import 'package:readmore/readmore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_new.dart';
void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const HomeNewPage(title: 'Home'),
    );
  }
}

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({super.key, required this.title});

  final String title;

  @override
  State<HomeNewPage> createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {


  // _HomeNewPageState() {
  //   view_notification();
  // }

  String name_="";
  String email_="";
  String phone_="";
  String dob_="";
  String gender_="";
  String place_="";


  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['name'];
          String dob=jsonDecode(response.body)['dob'];
          String gender=jsonDecode(response.body)['gender'];
          String email=jsonDecode(response.body)['email'];
          String phone=jsonDecode(response.body)['phonenumber'].toString();
          String place=jsonDecode(response.body)['place'];


          setState(() {

            name_= name;
            dob_= dob;
            gender_= gender;
            email_= email;
            phone_= phone;
            place_= place;

          });





        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  // List<String> id_ = <String>[];
  // List<String> date_= <String>[];
  // List<String> tips_= <String>[];
  //
  //
  //
  // Future<void> viewreply() async {
  //   List<String> id = <String>[];
  //   List<String> date = <String>[];
  //   List<String> tips = <String>[];
  //
  //
  //
  //
  //   try {
  //     SharedPreferences sh = await SharedPreferences.getInstance();
  //     String urls = sh.getString('url').toString();
  //     String lid = sh.getString('lid').toString();
  //     String url = '$urls/myapp/user_viewtips/';
  //
  //     var data = await http.post(Uri.parse(url), body: {
  //
  //       'lid':lid
  //
  //     });
  //     var jsondata = json.decode(data.body);
  //     String statuss = jsondata['status'];
  //
  //     var arr = jsondata["data"];
  //
  //     print(arr.length);
  //
  //     for (int i = 0; i < arr.length; i++) {
  //       id.add(arr[i]['id'].toString());
  //       date.add(arr[i]['date'].toString());
  //       tips.add(arr[i]['tips'].toString());
  //
  //
  //     }
  //
  //     setState(() {
  //       id_ = id;
  //       date_ = date;
  //       tips_ = tips;
  //     });
  //
  //     print(statuss);
  //   } catch (e) {
  //     print("Error ------------------- " + e.toString());
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }

  _HomeNewPageState()
  {
    a();
    // viewreply();
    _send_data();
  }
  a()
  async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name=sh.getString('name').toString();
    setState(() {
      name_=name;
    });
  }




  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 174, 120, 230),

          title: Text(widget.title),
        ),
        backgroundColor: Colors.white,

        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // alignment: MainAxisAlignment.center,
                width: 160, // Adjust the width as needed
                height: 80, // Adjust the height as needed
                child:
                Card(
                  child: ListTile(
                    leading: Icon(Icons.lightbulb_outline),
                    title: Text('Tips'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewTips(title: "Tips",),));

                    },
                  ),
                ),
              ),
              SizedBox(height: 40,),


              Container(
                // alignment: MainAxisAlignment.center,
                width: 160, // Adjust the width as needed
                height: 80, // Adjust the height as needed
                child:
                Card(
                  child: ListTile(
                    leading: Icon(Icons.contact_phone),
                    title: Text('Contacts'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => viewcontacts(title: "Mentors Contacts"),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Container(
                // alignment: MainAxisAlignment.center,
                width: 160, // Adjust the width as needed
                height: 80, // Adjust the height as needed
                child:
                Card(
                  child: ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Mentoring class'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserViewMentoringClass(title: "Mentoring Class"),
                        ),
                      );

                      // Add onTap functionality
                    },
                  ),
                ),
              ),
              // Card(
              //   child: ListTile(
              //     leading: Icon(Icons.contact_phone),
              //     title: Text('Contacts'),
              //     onTap: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => viewcontacts(title: "Mentors Contacts",),));
              //
              //       // Add onTap functionality
              //     },
              //   ),
              // ),
            ],
          ),
        ),

        // ListView.builder(
        //   physics: BouncingScrollPhysics(),
        //   // padding: EdgeInsets.all(5.0),
        //   // shrinkWrap: true,
        //   itemCount: id_.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       onLongPress: () {
        //         print("long press" + index.toString());
        //       },
        //       title: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child:
        //           Card(
        //             child:
        //             Column(
        //               children: [
        //                 Padding(
        //                   padding: EdgeInsets.all(5),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //
        //                     children: [
        //                       Text('Date    :'),
        //                       Text(date_[index]),
        //                     ],
        //                   ),
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     // Text('Tips:'),
        //                     Expanded(
        //                       child: ReadMoreText(
        //                         "Tips : ${tips_[index]}",
        //                       ),
        //                     ),
        //                   ],
        //                 )
        //                 // Row(
        //                 //   mainAxisAlignment: MainAxisAlignment.start,
        //                 //   children: [
        //                 //     Text('Tips:'),
        //                 //     Expanded(
        //                 //       child: Row(
        //                 //         mainAxisAlignment: MainAxisAlignment.end,
        //                 //         children: [
        //                 //           Text(
        //                 //             tips_[index],
        //                 //             overflow: TextOverflow.ellipsis,
        //                 //           ),
        //                 //           SizedBox(width: 8), // Adding some space between text and button
        //                 //           ElevatedButton(
        //                 //             onPressed: () {
        //                 //               // Handle "Read More" button tap
        //                 //             },
        //                 //             child: Text('Read More'),
        //                 //           ),
        //                 //         ],
        //                 //       ),
        //                 //     ),
        //                 //   ],
        //                 // )
        //                 // Row(
        //                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 //   children: [
        //                 //     Text('Tips:'),
        //                 //     GestureDetector(
        //                 //       onTap: () {
        //                 //         // Handle the read more action here
        //                 //       },
        //                 //       child: Text(
        //                 //         tips_[index],
        //                 //         overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
        //                 //       ),
        //                 //     ),
        //                 //   ],
        //                 // )
        //                 // Row(
        //                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 //   children: [
        //                 //     Text('Tips     :'),
        //                 //     Text(tips_[index]),
        //                 //   ],
        //                 // ),
        //               ],
        //             ),
        //
        //             elevation: 8,
        //             margin: EdgeInsets.all(10),
        //           )),
        //     );
        //   },
        // ),

        // SafeArea(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       // CircleAvatar(
        //       //   radius: 50.0,
        //       //   backgroundImage: AssetImage('images/fadcrepin.jpg'),
        //       // ),
        //       Text(
        //         name_,                style: TextStyle(
        //         fontSize: 30.0,
        //         fontFamily: 'Pacifico',
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white,
        //       ),
        //       ),
        //       Text(
        //         email_.toLowerCase(),
        //         style: TextStyle(
        //           fontSize: 20.0,
        //           fontFamily: 'SourceSansPro',
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           letterSpacing: 2.5,
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20.0,
        //         width: 150,
        //         child: Divider(
        //           color: Colors.deepPurple,
        //         ),
        //       ),
        //       InkWell(
        //           child: Card(
        //             margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        //             child: ListTile(
        //               leading: Icon(
        //                 Icons.phone,
        //                 color: Colors.deepPurple,
        //               ),
        //               title: Text(
        //                 phone_,
        //                 style: TextStyle(
        //                     fontFamily: 'SourceSansPro',
        //                     fontSize: 20,
        //                     color: Colors.teal.shade900),
        //               ),
        //             ),
        //
        //           ),
        //           // onTap: (){
        //           //   _launchURL('tel:+229 96119149');
        //           // }
        //       ),
        //       InkWell(
        //         child: Card(
        //           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        //           child: ListTile(
        //             leading: Icon(
        //               Icons.transgender_sharp,
        //               color: Colors.deepPurple,
        //             ),
        //             title:Text(
        //               gender_,
        //               style: TextStyle(
        //                   fontFamily: 'SourceSansPro',
        //                   fontSize: 20,
        //                   color: Colors.teal.shade900),
        //             ),
        //           ),
        //         ),
        //         // onTap: (){
        //         //   _launchURL('mailto:fadcrepin@gmail.com?subject=Need Flutter developer&body=Please contact me');
        //         // },
        //       ),
        //       InkWell(
        //         child: Card(
        //           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        //           child: ListTile(
        //             leading: Icon(
        //               Icons.place,
        //               color: Colors.deepPurple,
        //             ),
        //             title:Text(
        //               place_,
        //               style: TextStyle(
        //                   fontFamily: 'SourceSansPro',
        //                   fontSize: 20,
        //                   color: Colors.teal.shade900),
        //             ),
        //           ),
        //         ),
        //         // onTap: (){
        //         //   _launchURL('mailto:fadcrepin@gmail.com?subject=Need Flutter developer&body=Please contact me');
        //         // },
        //       ),
        //     ],
        //   ),
        // ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(

                  color: Color.fromARGB(255, 174, 120, 230),
                ),
                child:
                Column(children: [

                  Text(
                    'Mentor Me',
                    style: TextStyle(fontSize: 20,color: Colors.white),

                  ),

                  Text(name_,style: TextStyle(color: Colors.white)),
                  Text(email_,style: TextStyle(color: Colors.white)),



                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' View Profile '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(title:"View Profile",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: const Text(' Diary '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen(
                    camera: CameraDescription(
                        name: "1",
                        lensDirection: CameraLensDirection.front,
                        sensorOrientation: 1
                    ),
                  ),));
                  },
              ),
              ListTile(
                leading: Icon(Icons.change_circle),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChngPwdPage(title: "Change Password",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.send_rounded),
                title: const Text(' Send Complaint '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MySendCmplntPage(title: "Send Complaint",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.reviews),
                title: const Text(' Send Review '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MySendReviewPage(title: "Send Review",),));
                },
              ),


              ListTile(
                leading: Icon(Icons.replay_5_outlined),
                title: const Text(' View Reply'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: "View Reply",),));
                },

              ),
              // ListTile(
              //   leading: Icon(Icons.replay_5_outlined),
              //   title: const Text(' View Tips'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewTips(title: "View Tips",),));
              //   },
              //
              // ),


              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginNewPage(title: "Login"),));
                },
              ),

            ],
          ),
        ),





      ),
    );
  }




  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
