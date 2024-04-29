
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewcontacts(title: 'View Reply'),
    );
  }
}

class viewcontacts extends StatefulWidget {
  const viewcontacts({super.key, required this.title});

  final String title;

  @override
  State<viewcontacts> createState() => _viewcontactsState();
}

class _viewcontactsState extends State<viewcontacts> {
  // _viewcontactsState() {
  //   viewreply();
  // }
  //
  // List<String> id_ = <String>[];
  // List<String> date_ = <String>[];
  // List<String> complaint_ = <String>[];
  // List<String> reply_ = <String>[];
  // List<String> status_ = <String>[];
  //
  // Future<void> viewreply() async {
  //   List<String> id = <String>[];
  //   List<String> date = <String>[];
  //   List<String> complaint = <String>[];
  //   List<String> reply = <String>[];
  //   List<String> status = <String>[];
  //
  //   try {
  //     SharedPreferences sh = await SharedPreferences.getInstance();
  //     String urls = sh.getString('url').toString();
  //     String lid = sh.getString('lid').toString();
  //     String url = '$urls/myapp/user_viewreply/';
  //
  //     var data = await http.post(Uri.parse(url), body: {'lid': lid});
  //     var jsondata = json.decode(data.body);
  //     String statuss = jsondata['status'];
  //
  //     var arr = jsondata["data"];
  //
  //     print(arr.length);
  //
  //     for (int i = 0; i < arr.length; i++) {
  //       id.add(arr[i]['id'].toString());
  //       date.add(arr[i]['date']);
  //       complaint.add(arr[i]['complaint']);
  //       reply.add(arr[i]['reply']);
  //       status.add(arr[i]['status']);
  //     }
  //
  //     setState(() {
  //       id_ = id;
  //       date_ = date;
  //       complaint_ = complaint;
  //       reply_ = reply;
  //       status_ = status;
  //     });
  //
  //     print(statuss);
  //   } catch (e) {
  //     print("Error ------------------- " + e.toString());
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeNewPage(
                          title: 'Home',
                        )),
              );
            },
          ),
          backgroundColor: Color.fromARGB(
              255, 174, 120, 230),
          // backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          children: [
            ListTile(
              title: Text("Mr. Arun Verma"),
              subtitle: Text("921918532"),
            ),
            ListTile(
              title: Text("Ms. Kavita Chaturvedi"),
              subtitle: Text("9557722660"),
            ),
            ListTile(
              title: Text("Mr. Kiran Purohit"),
              subtitle: Text("8126208192"),
            ),
            ListTile(
              title: Text("Mr. Gireesh Kumar"),
              subtitle: Text("9897483870"),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => MySendComplaint()));
        //
        // },
        //   child: Icon(Icons.plus_one),
        // ),
      ),
    );
  }
}
