import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'login_new.dart';

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
      home: const MyRegisterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key, required this.title});



  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController phonenumbercontroller=TextEditingController();
  TextEditingController dobcontroller=TextEditingController();
  TextEditingController gendercontroller=TextEditingController();
  TextEditingController placecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobcontroller.text = selectedDate.toString().substring(0,10);
      });
    }
  }



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
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: 'Name',
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
                    if (!RegExp(r'^[\w-\.]+@gmail\.com$').hasMatch(value)) {
                      return 'Enter a valid Gmail address';
                    }
                    return null;
                  },

                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                    if (!RegExp(r'^\+?[6-9]\d{1,10}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                  controller: phonenumbercontroller,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                   onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value!.isEmpty){
                      return 'field must not be empty';
                    }
                    return null;
                  },
                  controller: dobcontroller,
                  decoration: InputDecoration(
                    hintText: 'DOB',
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Column(
                    children: [
                      RadioListTile(value: 'Male',title: Text('Male'), groupValue: gendercontroller.text, onChanged: (value) {
                        setState(() {
                          gendercontroller.text='Male';
                        });
                      },),
                      RadioListTile(value: 'Female',title: Text('Female'), groupValue: gendercontroller.text, onChanged: (value) {
                        setState(() {
                          gendercontroller.text='Female';
                        });
                      },)
                    ],
                  ),
                )
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
                  controller: placecontroller,
                  decoration: InputDecoration(
                    hintText: 'place',
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
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    hintText: 'Confirm password',
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              ElevatedButton(onPressed: (){
                if(formkey.currentState!.validate()){
                  _send_data();
                }

              }, child: Text('Register')
              ),
            ],
          ),
        ),
      ),

    );
  }
  void _send_data() async{


    String name=namecontroller.text;
    String email=emailcontroller.text;
    String phonenumber=phonenumbercontroller.text;
    String dob=dobcontroller.text;
    String gender=gendercontroller.text;
    String place=placecontroller.text;
    String pwd=passwordcontroller.text;
    String confirmpwd=confirmpasswordcontroller.text;





    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/myapp/user_register/');
    try {
      final response = await http.post(urls, body: {
        'name':name,
        'email':email,
        'phonenumber':phonenumber,
        'dob':dob,
        'gender':gender,
        'place':place,
        'password':pwd,
        'confirmpassword':confirmpwd



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyLoginNewPage(title: "Log In"),));
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
