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
      home: const MySendCmplntPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MySendCmplntPage extends StatefulWidget {
  const MySendCmplntPage({super.key, required this.title});



  final String title;

  @override
  State<MySendCmplntPage> createState() => _MySendCmplntPageState();
}

class _MySendCmplntPageState extends State<MySendCmplntPage> {
  TextEditingController cmplntcontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(
            255, 174, 120, 230),

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
                  maxLines: 5,
                  controller: cmplntcontroller,
                  decoration: InputDecoration(
                    hintText: 'compliant',
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


    String complaint=cmplntcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();


    final urls = Uri.parse('$url/myapp/user_sendcmplnt/');
    try {
      final response = await http.post(urls, body: {
        'complaint':complaint,
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
