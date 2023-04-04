import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:AgroCeres/models/app_localization.dart';
import 'cure.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Disease extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image;
  List _recognitions;
  String diseaseName = "";
  bool _busy = false;

  Future _showDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice! "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery "),
                    onTap: () {
                      predictImagePickerGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera "),
                    onTap: () {
                      predictImagePickerCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> predictImagePickerGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  Future<void> predictImagePickerCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  final disease = {
    //to add prompt
  };

  @override
  void initState() {
    super.initState();

    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/prediction.tflite",
        labels: "assets/Labels.txt",
      );
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numfinals: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _busy = false;
      _recognitions = recognitions;
    });
  }

  handleCure() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Cure(diseaseName),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'No image selected,\nUpload by clicking on button at the bottom right corner!'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                _image,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.cover,
              ),
            ),
    ));

    stackChildren.add(Positioned(
      top: MediaQuery.of(context).size.height / 2 + 20,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: _recognitions != null
              ? _recognitions.map((res) {
                  diseaseName = res['label'];
                  return Text(
                    "Disease Name : ${res["label"]}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                        // background: Paint()..color = Colors.white,
                        ),
                  );
                }).toList()
              : [],
        ),
      ),
    ));

    if (_image != null) {
      stackChildren.add(
//           Positioned(
//         bottom: 100.0,
//         left: 140.0,
// //        width: size.width,
//         child: RaisedButton(
//           onPressed: handleCure,
//           child: Text('Cure'),
//           color: Colors.blue,
//         ),
//       ),
        Positioned(
          right: 0,
          left: 0,
          top: MediaQuery.of(context).size.height / 1.80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cure : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(disease[diseaseName]),
              ],
            ),
          ),
        ),
      );
    }

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Disease Recognition'),
      ),
      body: Stack(
        children: stackChildren,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.camera),
      ),
    );
  }
}
