// // import statements...
//
// void main() {
//   runApp(const ViewReply());
// }
//
// class ViewReply extends StatelessWidget {
//   const ViewReply({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Tips',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const UserViewTips(title: 'View Tips'),
//     );
//   }
// }
//
// class UserViewTips extends StatefulWidget {
//   const UserViewTips({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<UserViewTips> createState() => _UserViewTipsState();
// }
//
// class _UserViewTipsState extends State<UserViewTips> {
//   _UserViewTipsState() {
//     viewReply();
//   }
//
//   List<String> id_ = [];
//   List<String> date_ = [];
//   List<String> tips_ = [];
//
//   Future<void> viewReply() async {
//     List<String> id = [];
//     List<String> date = [];
//     List<String> tips = [];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/myapp/user_viewtips/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'lid': lid,
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         tips.add(arr[i]['tips'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         tips_ = tips;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home')),
//               );
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               height: 150, // Set the desired height here
//               child: Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text('Date    :'),
//                             Text(date_[index]),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: ReadMoreText(
//                               "Tips : ${tips_[index]}",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 elevation: 20,
//                 margin: EdgeInsets.all(10),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
