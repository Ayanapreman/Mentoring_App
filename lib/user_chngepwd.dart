import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyChngPwdPage(title: 'Mentoring App'),
    );
  }
}

class MyChngPwdPage extends StatefulWidget {
  const MyChngPwdPage({super.key, required this.title});



  final String title;

  @override
  State<MyChngPwdPage> createState() => _MyChngPwdPageState();
}

class _MyChngPwdPageState extends State<MyChngPwdPage> {
  TextEditingController oldpasswordcontroller=TextEditingController();
  TextEditingController newpasswordcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(

        child: Form(key: formkey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty){
                      return 'field must not be empty';
                    }
                    return null;
                  },
                  controller: oldpasswordcontroller,
                  decoration: InputDecoration(
                    hintText: 'old password',
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty){
                      return 'field must not be empty';
                    }
                    return null;
                  },
                  controller: newpasswordcontroller,
                  decoration: InputDecoration(
                    hintText: 'new password',
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty){
                      return 'field must not be empty';
                    }
                    return null;
                  },

                  controller: confirmpasswordcontroller,
                  decoration: InputDecoration(
                    hintText: 'confirm password',
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              ElevatedButton(onPressed: (){
                if(formkey.currentState!.validate()){
                  _send_data();
                }

              }, child: Text('submit')
              ),

            ],
          ),
        ),
      ),

    );
  }
  void _send_data() async{


    String oldpwd=oldpasswordcontroller.text;
    String newpwd=newpasswordcontroller.text;
    String confirmpwd=confirmpasswordcontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/user_changepwd/');
    try {
      final response = await http.post(urls, body: {
        'oldpassword':oldpwd,
        'newpassword':newpwd,
        'confirmpassword':confirmpwd,
        'lid':lid


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {



          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeNewPage(title: "Home"),));
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
