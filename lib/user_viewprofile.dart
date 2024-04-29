import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentoring/user_editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
          255, 58, 162, 183,)),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'View Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  _ViewProfilePageState()
  {
     _send_data();
  }
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(


          leading: BackButton(

          ),
          backgroundColor: Theme.of(context).colorScheme.primary,

          title: Text(widget.title),

        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              CircleAvatar(radius: 50,),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Name   :'),
                        Text(name_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Email  :'),
                        Text(email_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Phone  :'),
                        Text(phone_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('DOB  :'),
                        Text(dob_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Gender  :'),
                        Text(gender_),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Place  :'),
                        Text(place_),
                      ],
                    ),
                  ),


                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyEditProfilePage(title: "Edit Profile"),));
                },
                child: Text("Edit Profile"),
              ),

            ],
          ),
        ),
      ),
    );
  }


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
}
