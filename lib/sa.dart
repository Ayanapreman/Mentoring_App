import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Byte Array',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    timer?.cancel();
  }

  Timer? timer;

  void startTimer() {
    timer = Timer(Duration(seconds: 5), () {
      captureImage();
    });
  }


  void captureImage() async {
    try {
      await _initializeControllerFuture;

      XFile? imageFile = await _controller.takePicture();

      if (imageFile != null) {
        // Retrieve the captured image as a byte array
        Uint8List bytes = await getImageBytes(imageFile);


        SharedPreferences sh = await SharedPreferences.getInstance();
        String urls = sh.getString('url').toString();
        String lid = sh.getString('lid').toString();
        ///////////////sending as multpart
        final url = Uri.parse('$urls/myapp/user_diarycam/'); // Replace with your API endpoint

        var request = http.MultipartRequest('POST', url);
        request.fields.addAll({'lid':lid});
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: 'file.jpg', // Set your desired filename
            contentType: MediaType('application', 'octet-stream'), // Set the content type
          ),
        );

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200) {
            print('Multipart request successful');
            // Handle success response here
          } else {
            print('Multipart request failed with status ${response.statusCode}');
            // Handle error response here
          }
        } catch (e) {
          print('Error sending multipart request: $e');
          // Handle exceptions here
        }



        //////////////end sending as multipart

        // Use the bytes as needed (e.g., send them over a network, process them, etc.)
        print('Captured image as byte array: $bytes');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<Uint8List> getImageBytes(XFile imageFile) async {
    final filePath = imageFile.path;
    final bytes = File(filePath).readAsBytesSync();
    return bytes;
  }
  TextEditingController diarycontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('"Be Positive,Keep going.."'),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: false,
            child: Container(
              height: 100,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(

            child: Form(key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    TextFormField(
                      onTap: () => startTimer(),
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
                        captureImage();
                      }
                    }, child: Text('submit')
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     startTimer();
      //   },
      //   child: Icon(Icons.camera),
      // ),
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



          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => CameraScreen(camera: widget.camera),));
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
