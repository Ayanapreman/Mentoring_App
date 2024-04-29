// import 'package:clinicpharma/homenew.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';

void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Classes',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const UserViewMentoringClass(title: 'View Classes'),
    );
  }
}

class UserViewMentoringClass extends StatefulWidget {
  const UserViewMentoringClass({super.key, required this.title});

  final String title;

  @override
  State<UserViewMentoringClass> createState() => _UserViewMentoringClassState();
}

class _UserViewMentoringClassState extends State<UserViewMentoringClass> {


  _UserViewMentoringClassState(){
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> date_= <String>[];
  List<String> link_= <String>[];



  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> link = <String>[];




    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/user_mentoringclass/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        link.add(arr[i]['link'].toString());


      }

      setState(() {
        id_ = id;
        date_ = date;
        link_ = link;
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
        body:
        ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              SizedBox(width: 2,),
                              Text('Date    :'),
                              Text(date_[index]),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                launchUrl(Uri.parse(link_[index]), mode: LaunchMode.platformDefault);
                              }, // This calls the _launchURL function when pressed
                              child: Text('Open URL'),
                            ),
                            // Other widgets can be added here if needed
                          ],
                        )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     FlatButton(
                        //       onPressed: _launchURL,
                        //       child: Text('Open URL'),
                        //     )
                        //     // Text('Tips:'),
                        //     // SizedBox(width: 4,),
                        //
                        //     // Expanded(
                        //     //   child: ReadMoreText(
                        //     //     "link : ${link_[index]}",
                        //     //   ),
                        //     // ),
                        //   ],
                        // )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text('Tips:'),
                        //     Expanded(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [
                        //           Text(
                        //             tips_[index],
                        //             overflow: TextOverflow.ellipsis,
                        //           ),
                        //           SizedBox(width: 8), // Adding some space between text and button
                        //           ElevatedButton(
                        //             onPressed: () {
                        //               // Handle "Read More" button tap
                        //             },
                        //             child: Text('Read More'),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('Tips:'),
                        //     GestureDetector(
                        //       onTap: () {
                        //         // Handle the read more action here
                        //       },
                        //       child: Text(
                        //         tips_[index],
                        //         overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                        //       ),
                        //     ),
                        //   ],
                        // )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('Tips     :'),
                        //     Text(tips_[index]),
                        //   ],
                        // ),
                      ],
                    ),

                    elevation: 8,
                    margin: EdgeInsets.all(10),
                  )),
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
  _launchURL(index) async {
    String url = link_[index]; // Replace this with your desired URL
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
