// import 'package:clinicpharma/homenew.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
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

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewReplyPage(title: 'View Reply'),
    );
  }
}

class ViewReplyPage extends StatefulWidget {
  const ViewReplyPage({super.key, required this.title});

  final String title;

  @override
  State<ViewReplyPage> createState() => _ViewReplyPageState();
}

class _ViewReplyPageState extends State<ViewReplyPage> {

  _ViewReplyPageState(){
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> date_= <String>[];
  List<String> complaint_= <String>[];
  List<String> reply_= <String>[];
  List<String> status_= <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> complaint = <String>[];
    List<String> reply = <String>[];
    List<String> status = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/user_viewreply/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        complaint.add(arr[i]['complaint']);
        reply.add(arr[i]['reply']);
        status.add(arr[i]['status']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        complaint_ = complaint;
        reply_ = reply;
        status_ = status;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home',)),);

          },),
          backgroundColor: Color.fromARGB(
              255, 174, 120, 230),
          title: Text(widget.title),
        ),
        // body: ListView.builder(
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
        //           child: Card(
        //             child:
        //             Column(
        //               children: [
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     // Text('Tips:'),
        //                     Expanded(
        //                       child: ReadMoreText(
        //                         "Date : ${date_[index]}",
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //
        //                 // Padding(
        //                 //   padding: EdgeInsets.all(5),
        //                 //   child: Row(
        //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 //
        //                 //     children: [
        //                 //       Text('Date    :'),
        //                 //       Text(date_[index]),
        //                 //     ],
        //                 //   ),
        //                 // ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     // Text('Tips:'),
        //                     Expanded(
        //                       child: ReadMoreText(
        //                         "Complaints : ${complaint_[index]}",
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //
        //                 // Padding(
        //                 //   padding: EdgeInsets.all(5),
        //                 //   child: Row(
        //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 //
        //                 //     children: [
        //                 //       Text('Complaints   :'),
        //                 //       Text(complaint_[index]),
        //                 //     ],
        //                 //   ),
        //                 // ),
        //                 // Padding(
        //                 //   padding: EdgeInsets.all(5),
        //                 //   child: Row(
        //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 //     children: [
        //                 //       Text('Reply     :'),
        //                 //       Text(reply_[index]),
        //                 //     ],
        //                 //   ),
        //                 // ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     // Text('Tips:'),
        //                     Expanded(
        //                       child: ReadMoreText(
        //                         "Reply : ${reply_[index]}",
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     // Text('Tips:'),
        //                     Expanded(
        //                       child: ReadMoreText(
        //                         "Status : ${status_[index]}",
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //
        //                 // Padding(
        //                 //   padding: EdgeInsets.all(5),
        //                 //   child: Row(
        //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 //
        //                 //     children: [
        //                 //       Text('status   :'),
        //                 //       Text(status_[index]),
        //                 //     ],
        //                 //   ),
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
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // height: 200, // Set the desired height here
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.all(5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text('Date    :'),
                      //       Text(date_[index]),
                      //     ],
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Date    :'),
                            Text(date_[index]),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Complaint:'),
                          Container(
                            width: MediaQuery.of(context).size.width-120,
                            child: ReadMoreText(
                              "${complaint_[index]}",
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Reply    :'),
                            Text(reply_[index]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                elevation: 20,
                margin: EdgeInsets.all(10),
              ),
            );
          },
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
