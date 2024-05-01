import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}
// MyAppnew comment

// second comment

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
      home: const MyDiaryPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyDiaryPage extends StatefulWidget {
  const MyDiaryPage({super.key, required this.title});



  final String title;


  @override
  State<MyDiaryPage> createState() => _MyDiaryPageState();
}

class _MyDiaryPageState extends State<MyDiaryPage> {
  TextEditingController diarycontroller=TextEditingController();
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                TextFormField(
                  maxLines: 10,
                  validator: (value) {
                    if (value!.isEmpty){
                      return 'field must not be empty';
                    }
                    return null;
                  },
                  controller: diarycontroller,
                  decoration: InputDecoration(
                    hintText: 'Diary',
                    border: OutlineInputBorder(),
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
      ),

    );
  }
  void _send_data() async{


    String diary=diarycontroller.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/user_adddiary/');
    try {
      final response = await http.post(urls, body: {
        'content':diary,
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
