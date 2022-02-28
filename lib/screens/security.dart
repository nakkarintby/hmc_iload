import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/image.dart';
import 'package:test/class/resvalidateimage.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  TextEditingController documentController = TextEditingController();
  bool documentVisible = false;
  bool documentReadonly = false;
  Color documentColor = Color(0xFFFFFFFF);
  bool takePhotoEnabled = false;
  bool uploadEnabled = false;
  bool finishEnabled = false;
  bool backEnabled = false;

  String documentIdInput = '';
  String eventType = '';
  String statusUpload = '';
  String fileInBase64 = '';

  bool documentWillUpload = false;
  bool documentWillUploadOrWillFinish = false;
  bool documentWillFinish = false;

  int isUsername = 0;
  String username = "";

  int step = 0;
  final ImagePicker _picker = ImagePicker();
  late File? _image = null;
  late ImagePic? imagePic = new ImagePic();

  late List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  late Timer timer;
  late ResValidateImage? resultValImage;
  late Document? resultDocument;

  String configs = '';

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    getSession();
    setState(() {
      step = 0;
    });
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      configs = prefs.getString('configs');
    });
  }

  Future<void> getSession() async {
    isUsername = await FlutterSession().get("token_username");
    setState(() {
      username = isUsername.toString();
    });
  }

  void setVisible() {
    if (step == 0) {
      setState(() {
        documentVisible = true;
      });
    }
  }

  void setReadOnly() {
    if (step == 0) {
      setState(() {
        documentReadonly = false;
        takePhotoEnabled = false;
        backEnabled = false;
        uploadEnabled = false;
        finishEnabled = false;

        documentWillUpload = false;
        documentWillUploadOrWillFinish = false;
        documentWillFinish = false;
      });
    } else if (step == 1) {
      setState(() {
        documentReadonly = true;
        takePhotoEnabled = true;
        backEnabled = true;
        uploadEnabled = false;
        finishEnabled = false;
      });
    } else if (step == 2) {
      setState(() {
        documentReadonly = true;
        takePhotoEnabled = false;
        backEnabled = true;
        uploadEnabled = true;
        finishEnabled = false;
      });
    } else if (step == 3) {
      if (documentWillUploadOrWillFinish) {
        setState(() {
          documentReadonly = true;
          takePhotoEnabled = true;
          backEnabled = true;
          uploadEnabled = false;
          finishEnabled = true;
        });
      } else if (documentWillFinish) {
        setState(() {
          documentReadonly = true;
          takePhotoEnabled = false;
          backEnabled = true;
          uploadEnabled = false;
          finishEnabled = true;
        });
      }
    }
  }

  void setColor() {
    if (step == 0) {
      setState(() {
        documentColor = Color(0xFFFFFFFF);
      });
    } else if (step == 1) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
      });
    }
  }

  void setText() {
    if (step == 0) {
      setState(() {
        documentController.text = "";
        statusUpload = "No image selected";
      });
    } else if (step == 1) {
      setState(() {
        documentController.text = documentIdInput;
      });
    }
  }

  void setFocus() {
    if (step == 0) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[0]));
    } else if (step == 1) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[1]));
    } else if (step == 2) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[2]));
    } else if (step == 3) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[3]));
    }
  }

  void back() {
    if (step == 1 || step == 2) {
      setState(() {
        step--;
        _image = null;
      });
    } else if (step == 3) {
      setState(() {
        step = 0;
        _image = null;
      });
    }
  }

  void alertDialog(String msg, String type) {
    Icon icon = Icon(Icons.info_outline, color: Colors.lightBlue);
    switch (type) {
      case "Success":
        icon = Icon(Icons.check_circle_outline, color: Colors.lightGreen);
        break;
      case "Error":
        icon = Icon(Icons.error_outline, color: Colors.redAccent);
        break;
      case "Warning":
        icon = Icon(Icons.warning_amber_outlined, color: Colors.orangeAccent);
        break;
      case "Infomation":
        icon = Icon(Icons.info_outline, color: Colors.lightBlue);
        break;
    }

    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          timer = Timer(Duration(seconds: 2), () {
            Navigator.of(context, rootNavigator: true).pop();
          });

          return AlertDialog(
            title: Row(children: [icon, Text(" " + type)]),
            content: Text(msg),
          );
        }).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }

  void showErrorDialog(String error) {
    //MyWidget.showMyAlertDialog(context, "Error", error);
    alertDialog(error, 'Error');
  }

  void showSuccessDialog(String success) {
    //MyWidget.showMyAlertDialog(context, "Success", success);
    alertDialog(success, 'Success');
  }

  Future<void> documentIDCheck() async {
    setState(() {
      documentIdInput = documentController.text;
      eventType = 'Security';
    });

    var url = Uri.parse(configs +
        '/api/api/document/validateimage/' +
        documentIdInput +
        '/' +
        eventType);
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      resultValImage = ResValidateImage.fromJson(data);
      resultDocument = resultValImage?.document;
    });

    if (resultDocument == null) {
      showErrorDialog(resultValImage!.errorMsg.toString());
    } else {
      bool? temp1 = resultValImage?.canUpload;
      bool canUpload = temp1!;
      bool? temp2 = resultValImage?.canComplete;
      bool canComplete = temp2!;

      if (!canUpload && canComplete) {
        setState(() {
          documentWillUpload = false;
          documentWillUploadOrWillFinish = false;
          documentWillFinish = true;
          _image = null;
          statusUpload = 'finish';
          step = 3;
          documentReadonly = true;
          documentColor = Color(0xFFEEEEEE);
          documentController.text = documentIdInput;
        });
      } else if (canUpload && !canComplete) {
        setState(() {
          documentWillUpload = true;
          documentWillUploadOrWillFinish = false;
          documentWillFinish = false;
          _image = null;
          statusUpload = 'not enough images';
          step++;
        });
      } else if (canUpload && canComplete) {
        setState(() {
          documentWillUpload = true;
          documentWillUploadOrWillFinish = true;
          documentWillFinish = false;
          _image = null;
          statusUpload = 'add more images or finish';
          step = 3;
          documentReadonly = true;
          documentColor = Color(0xFFEEEEEE);
          documentController.text = documentIdInput;
        });
      }
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> imageFromCamera() async {
    setState(() {
      step = 1;
      fileInBase64 = '';
    });
    PickedFile? selectedImage =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File? temp;
    if (selectedImage != null) {
      temp = File(selectedImage.path);
      if (selectedImage.path.isNotEmpty) {
        setState(() {
          _image = temp;
          //encode base64
          final encodedBytes = _image!.readAsBytesSync();
          fileInBase64 = base64Encode(encodedBytes);
        });

        //double temp1 = _image!.lengthSync() * 0.0000009537;
        //String temp2 = temp1.toString() + ' MB';
        //print(temp2);
        //print(fileInBase64); //base64

        //decode base64
        /*
        final decodedBytes = base64Decode(fileInBase64);
        final directory = await getApplicationDocumentsDirectory();
        File fileImg = File('${directory.path}/testImage.png');
        fileImg.writeAsBytesSync(
            List.from(decodedBytes)); //fileImg is decode base64 to file
        setState(() {
          _image = fileImg;
        });
        */
      }
    }
    if (_image != null) {
      setState(() {
        step++;
      });
      setVisible();
      setReadOnly();
      setColor();
      setText();
      setFocus();
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (step == 0) {
      setState(() {
        documentController.text = barcodeScanRes;
      });
      documentIDCheck();
    }
  }

  Future<void> upload() async {
    //post image
    DateTime? a = DateTime.now();
    if (imagePic != null) {
      setState(() {
        imagePic!.documentId = resultDocument!.documentId;
        imagePic!.sequence = resultValImage!.sequence;
        imagePic!.eventType = eventType;
        imagePic!.imageValue = fileInBase64;
        imagePic!.isDeleted = false;
        imagePic!.createdBy = resultDocument!.createdBy;
        imagePic!.createdOn = resultDocument!.createdOn;
        imagePic!.modifiedBy = username;
        imagePic!.modifiedOn = a.toString();
      });
    }

    String tempAPI = configs + '/api/api/image/create';
    final uri = Uri.parse(tempAPI);
    final headers = {'Content-Type': 'application/json'};
    var jsonBody = jsonEncode(imagePic);
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    var data = json.decode(response.body);

    //check can upload?
    var url2 = Uri.parse(configs +
        '/api/api/document/validateimage/' +
        documentIdInput +
        '/' +
        eventType);
    http.Response response2 = await http.get(url2);
    var data2 = json.decode(response2.body);
    setState(() {
      resultValImage = ResValidateImage.fromJson(data2);
      resultDocument = resultValImage?.document;
    });

    if (resultDocument == null) {
      showErrorDialog(resultValImage!.errorMsg.toString());
    } else {
      bool? temp1 = resultValImage?.canUpload;
      bool canUpload = temp1!;
      bool? temp2 = resultValImage?.canComplete;
      bool canComplete = temp2!;

      if (!canUpload && canComplete) {
        setState(() {
          documentWillUpload = false;
          documentWillUploadOrWillFinish = false;
          documentWillFinish = true;
          _image = null;
          statusUpload = 'upload successful';
          step++;
        });
      } else if (canUpload && !canComplete) {
        setState(() {
          documentWillUpload = true;
          documentWillUploadOrWillFinish = false;
          documentWillFinish = false;
          _image = null;
          statusUpload = 'upload successful but not enough images';
          step--;
        });
      } else if (canUpload && canComplete) {
        setState(() {
          documentWillUpload = true;
          documentWillUploadOrWillFinish = true;
          documentWillFinish = false;
          _image = null;
          statusUpload = 'upload successful but can add more images';
          step++;
        });
      }
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> finish() async {
    setState(() {
      //resultDocument!.documentStatus = "In Progress";
      resultDocument!.modifiedBy = username;
      resultDocument!.flagImgSecurity = true;
    });
    String tempAPI = configs + '/api/api/document/updatemobile';
    final uri = Uri.parse(tempAPI);
    final headers = {'Content-Type': 'application/json'};
    var jsonBody = jsonEncode(resultDocument?.toJson());
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    var data = json.decode(response.body);
    setState(() {
      resultDocument = Document.fromJson(data);
    });

    if (resultDocument == null) {
      showErrorDialog("Error Update Status Document");
    } else {
      setState(() {
        step = 0;
      });
      showSuccessDialog('Upload Complete');
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Security',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.black,
                ),
                onPressed: scanQR)
          ],
        ),
        body: SafeArea(
            child: Column(children: [
          SizedBox(height: 30),
          Container(
              padding: new EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5),
              child: Visibility(
                  visible: documentVisible,
                  child: TextFormField(
                    focusNode: focusNodes[0],
                    readOnly: documentReadonly,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (value) {
                      documentIDCheck();
                    },
                    decoration: InputDecoration(
                      //icon: const Icon(Icons.person),
                      fillColor: documentColor,
                      filled: true,
                      hintText: 'Enter Document No.',
                      labelText: 'Document Number',
                      border: OutlineInputBorder(),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(15), //
                    ),
                    controller: documentController,
                  ))),
          SizedBox(height: 10),
          new Center(
            child: new ButtonBar(
              mainAxisSize: MainAxisSize
                  .min, // this will take space as minimum as posible(to center)
              children: <Widget>[
                new RaisedButton(
                  color: Colors.blue,
                  child: const Text('Back',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: backEnabled
                      ? () {
                          back();
                          setVisible();
                          setReadOnly();
                          setColor();
                          setText();
                          setFocus();
                        }
                      : null,
                ),
                new RaisedButton(
                  focusNode: focusNodes[1],
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[Icon(Icons.add_a_photo_outlined)],
                  ),
                  onPressed: takePhotoEnabled
                      ? () {
                          imageFromCamera();
                        }
                      : null,
                ),
                new RaisedButton(
                  focusNode: focusNodes[2],
                  color: Colors.blue,
                  child: const Text('Upload',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: uploadEnabled
                      ? () {
                          upload();
                          setVisible();
                          setReadOnly();
                          setColor();
                          setText();
                          setFocus();
                        }
                      : null,
                ),
                new RaisedButton(
                  focusNode: focusNodes[3],
                  color: Colors.blue,
                  child: const Text('Finish',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: finishEnabled
                      ? () {
                          finish();
                          setVisible();
                          setReadOnly();
                          setColor();
                          setText();
                          setFocus();
                        }
                      : null,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: _image != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image.file(
                          _image!,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(statusUpload),
                    ),
            )
          ]),
        ])));
  }
}
