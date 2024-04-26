import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'package:http/http.dart'as http;
import 'package:mentoring/user_register.dart';

import 'login_new.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ForgotpasswordPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({super.key, required this.title});



  final String title;

  @override
  State<ForgotpasswordPage> createState() => _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-2.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(duration: Duration(milliseconds: 1300), child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/clock.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                                ),
                                child: TextField(
                                  controller: usernamecontroller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email ",
                                      hintStyle: TextStyle(color: Colors.grey[700])
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: TextField(
                              //     obscureText: true,
                              //     controller: passwordcontroller,
                              //     decoration: InputDecoration(
                              //         border: InputBorder.none,
                              //         hintText: "Password",
                              //         hintStyle: TextStyle(color: Colors.grey[700])
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        )),
                        SizedBox(height: 30,),
                        // FadeInUp(duration: Duration(milliseconds: 1900), child: Container(
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       gradient: LinearGradient(
                        //           colors: [
                        //             Color.fromRGBO(143, 148, 251, 1),
                        //             Color.fromRGBO(143, 148, 251, .6),
                        //           ]
                        //       )
                        //   ),
                        //   child: Center(
                        //     child: TextButton(onPressed: (){
                        //
                        //       Navigator.push(context, MaterialPageRoute(
                        //         builder: (context) => MyRegisterPage(title: "Home"),));
                        //       // _send_data();
                        //     },child: Text("Submit"
                        //       ,
                        //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
                        //   ),
                        // )),
                        SizedBox(height: 30,),
                        InkWell(
                          onTap: () {
                            _send_data();

                          },
                          child: FadeInUp(duration: Duration(milliseconds: 1900), child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ]
                                )
                            ),
                            child: Center(
                              child: TextButton(onPressed: (){
                                _send_data();
                              },child: Text("Submit"
                                ,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
                            ),
                          )),
                        ),

                        SizedBox(height: 70,),
                        // FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
  void _send_data() async{


    String uname=usernamecontroller.text;
    // String pswd=passwordcontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/myapp/user_forgotpwd/');
    try {
      final response = await http.post(urls, body: {
        'name':uname,
        // 'password':pswd,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          String lid=jsonDecode(response.body)['lid'].toString();
          sh.setString("lid", lid);

          Fluttertoast.showToast(msg: 'Password updated. please check your email');


          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyLoginNewPage(title: "login"),));
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