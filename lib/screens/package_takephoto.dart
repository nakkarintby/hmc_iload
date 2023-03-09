import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image/image.dart' as img;
import 'package:location/location.dart';
import 'package:test/class/itemWoImageDetail.dart';
import 'package:test/class/listLoadTypeMenu.dart';
import 'package:test/class/postImage.dart';
import 'package:test/class/postImageResult.dart';
import 'package:test/class/ptDocumentIDCheckResult.dart';
import 'package:test/components/menu_list2.dart';

class PackageTakephoto extends StatefulWidget {
  @override
  _PackageTakephotoState createState() => _PackageTakephotoState();
}

class _PackageTakephotoState extends State<PackageTakephoto> {
  TextEditingController documentController = TextEditingController();
  bool documentVisible = false;
  bool documentReadonly = false;
  Color documentColor = Color(0xFFFFFFFF);
  int step = 1;
  late Timer timer;
  String configs = '';
  String accessToken = '';
  String deviceId = "";
  String deviceInfo = "";
  String osVersion = "";
  LocationData? _currentPosition;
  Location location = Location();
  String gps = "";
  late List<ImageSubWorkTypeMenu> listImageSubWorkTypeMenu = [];
  late List<LoadTypeMenu> listLoadTypeMenu = [];
  bool listVisible = false;
  bool listVisible2 = false;
  bool backMenuVisible = false;
  bool backEnabledMenu = false;
  late PTDocumentIDCheckResult result = PTDocumentIDCheckResult();
  String header1 = 'Header1';
  String header2 = 'Header2';
  String header3 = 'Header3';
  bool header1Visible = false;
  bool header2Visible = false;
  bool header3Visible = false;

  bool backEnabled = false;
  bool takePhotoEnabled = false;
  bool uploadEnabled = false;
  bool nextEnabled = false;
  bool finishEnabled = false;
  bool documentWillUpload = false;
  bool documentWillUploadOrWillFinish = false;
  bool documentWillFinish = false;

  late File? _image = null;
  final ImagePicker _picker = ImagePicker();
  String statusUpload = '';
  String fileInBase64 = '';
  bool buttonUploadVisible = false;

  int seqence = 0;
  String name = '';
  int min = 0;
  int max = 0;
  int numberupload = 0;

  @override
  void initState() {
    super.initState();
    getLocation();
    getDeviceInfo();
    setState(() {
      step = 1;
      listImageSubWorkTypeMenu.clear();
      listLoadTypeMenu.clear();
    });
    setVisible();
    setReadOnly();
    setColor();
    setText();
  }

  Future<void> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    /*print('' +
        _currentPosition!.latitude.toString() +
        ',' +
        _currentPosition!.longitude.toString());*/
    setState(() {
      gps = (_currentPosition!.latitude.toString() +
          ',' +
          _currentPosition!.longitude.toString());
    });
  }

  Future<void> getDeviceInfo() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    setState(() {
      deviceId = androidInfo.androidId;
      osVersion = 'Android(' + androidInfo.version.release + ')';
      deviceInfo = androidInfo.manufacturer + '(' + androidInfo.model + ')';
    });
  }

  Future<void> showProgressImageFromCamera() async {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        progress: 50.0,
        message: "Please wait...",
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    await pr.show();
    timer = Timer(Duration(seconds: 3), () async {
      await pr.hide();
    });
  }

  Future<void> showProgressLoading(bool finish) async {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        progress: 50.0,
        message: "Please wait...",
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    if (finish == false) {
      await pr.show();
    } else {
      await pr.hide();
    }
  }

  void setVisible() {
    if (step == 1) {
      setState(() {
        documentVisible = true;
        header1Visible = false;
        header2Visible = false;
        listVisible = false;
        listVisible2 = false;
        backMenuVisible = false;
        buttonUploadVisible = false;
      });
    } else if (step == 2) {
      setState(() {
        documentVisible = true;
        header1Visible = true;
        header2Visible = false;
        listVisible = true;
        listVisible2 = false;
        backMenuVisible = true;
        buttonUploadVisible = false;
      });
    } else if (step == 3) {
      setState(() {
        documentVisible = true;
        header1Visible = true;
        header2Visible = true;

        listVisible = false;
        listVisible2 = true;
        backMenuVisible = true;
        buttonUploadVisible = false;
      });
    } else if (step == 4 || step == 5 || step == 6 || step == 7) {
      setState(() {
        documentVisible = true;
        header1Visible = true;
        header2Visible = true;
        header3Visible = true;

        listVisible = false;
        listVisible2 = false;
        backMenuVisible = false;
        buttonUploadVisible = true;
      });
    }
  }

  void setReadOnly() {
    if (step == 1) {
      setState(() {
        documentReadonly = false;
        backEnabled = false;
        takePhotoEnabled = false;
        uploadEnabled = false;
        nextEnabled = false;
        finishEnabled = false;
        documentWillUpload = false;
        documentWillUploadOrWillFinish = false;
        documentWillFinish = false;
      });
    } else if (step == 2) {
      setState(() {
        documentReadonly = true;
        backEnabled = false;
        takePhotoEnabled = false;
        uploadEnabled = false;
        nextEnabled = false;
        finishEnabled = false;
        documentWillUpload = false;
        documentWillUploadOrWillFinish = false;
        documentWillFinish = false;
      });
    } else if (step == 3) {
      setState(() {
        documentReadonly = true;
        backEnabled = false;
        takePhotoEnabled = false;
        uploadEnabled = false;
        nextEnabled = false;
        finishEnabled = false;
        documentWillUpload = false;
        documentWillUploadOrWillFinish = false;
        documentWillFinish = false;
      });
    } else if (step == 4) {
      if (documentWillUpload) {
        setState(() {
          documentReadonly = true;
          backEnabled = true;
          takePhotoEnabled = true;
          uploadEnabled = false;
          nextEnabled = false;
          finishEnabled = false;
        });
      } else if (documentWillUploadOrWillFinish) {
        setState(() {
          documentReadonly = true;
          backEnabled = true;
          takePhotoEnabled = true;
          uploadEnabled = false;
          nextEnabled = true;
          finishEnabled = false;
        });
      }
    } else if (step == 5) {
      setState(() {
        documentReadonly = true;
        backEnabled = true;
        takePhotoEnabled = false;
        uploadEnabled = true;
        nextEnabled = false;
        finishEnabled = false;
      });
    } else if (step == 6) {
      if (documentWillFinish) {
        setState(() {
          documentReadonly = true;
          backEnabled = true;
          takePhotoEnabled = false;
          uploadEnabled = false;
          nextEnabled = true;
          finishEnabled = false;
        });
      } else if (documentWillUploadOrWillFinish) {
        setState(() {
          documentReadonly = true;
          backEnabled = true;
          takePhotoEnabled = true;
          uploadEnabled = false;
          nextEnabled = true;
          finishEnabled = false;
        });
      }
    } else if (step == 7) {
      setState(() {
        documentReadonly = true;
        backEnabled = true;
        takePhotoEnabled = false;
        uploadEnabled = false;
        nextEnabled = false;
        finishEnabled = true;
      });
    }
  }

  void setColor() {
    if (step == 1) {
      setState(() {
        documentColor = Color(0xFFFFFFFF);
      });
    } else if (step == 2) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
      });
    }
  }

  void setText() {
    if (step == 1) {
      setState(() {
        documentController.text = '';
        header1 = '';
        header2 = '';
        header3 = '';
        statusUpload = '';
        fileInBase64 = '';
        seqence = 0;
        name = '';
        min = 0;
        max = 0;
        numberupload = 0;
      });
    }
  }

  Future<void> backMenu() async {
    if (step == 2) {
      setState(() {
        step--;
      });
    } else if (step == 3) {
      setState(() {
        step--;
      });
      await documentIDCheck();
    }
  }

  Future<void> backButtonUpload() async {
    if (step == 4 || step == 6) {
      setState(() {
        step = 1;
        _image = null;
        listImageSubWorkTypeMenu.clear();
        listLoadTypeMenu.clear();
      });
    } else if (step == 5) {
      setState(() {
        step--;
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
          timer = Timer(Duration(seconds: 5), () {
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

  Future<void> setPrefsDocumentId(int documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('documentId', documentId);
  }

  Future<void> setPrefsWorkTypeId(int loadTypeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('workTypeId', loadTypeId);
  }

  Future<void> setPrefsWorkTypeName(String loadTypeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('workTypeName', loadTypeName);
  }

  Future<void> setPrefsImageSubWorkTypeId(int imageSubWorkTypeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('imageSubWorkTypeId', imageSubWorkTypeId);
  }

  Future<void> setPrefsImageSubWorkTypeName(String imageSubWorkTypeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imageSubWorkTypeName', imageSubWorkTypeName);
  }

  Future<void> setPrefsLoadTypeId(int loadTypeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('loadTypeId', loadTypeId);
  }

  Future<void> setPrefsLoadTypeName(String loadTypeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loadTypeName', loadTypeName);
  }

  Future<void> setPrefsWoImageHeaderId(int woImageHeaderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('woImageHeaderId', woImageHeaderId);
  }

  Future<void> setPrefsWoImageDetailId(int woImageDetailId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('woImageDetailId', woImageDetailId);
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
      await documentIDCheck();
      setVisible();
      setReadOnly();
      setColor();
      setText();
    }
  }

  Future<void> documentIDCheck() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('token');
        documentController.text = '100000001';
        listImageSubWorkTypeMenu.clear();
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Documents/ValidateDocument/' +
          documentController.text);

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      http.Response response = await http.get(url, headers: headers);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        late PTDocumentIDCheckResult result;
        setState(() {
          result = PTDocumentIDCheckResult.fromJson(data);
        });

        //getHeader1
        setState(() {
          String temp = result.workTypeName.toString();
          header1 = 'ประเภทงาน : $temp';
        });

        //getListImageSubWorkTypeMenu
        for (int i = 0; i < result.data!.length; i++) {
          late ImageSubWorkTypeMenu temp;
          setState(() {
            temp = result.data![i];
            listImageSubWorkTypeMenu.add(temp);
          });
        }

        if (step == 1) {
          setState(() {
            step++;
          });
        }

        await setPrefsDocumentId(result.documentId!);
        await setPrefsWorkTypeId(result.workTypeId!);
        await setPrefsWorkTypeName(result.workTypeName!);
      } else {
        setState(() {
          documentController.text = '';
        });
        showErrorDialog('DocumentID Not Found!');
      }
    } catch (e) {
      setState(() {
        documentController.text = '';
      });
      showErrorDialog('Error occured while documentIDCheck');
    }
  }

  Future<void> getLoadTypeMenu() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int documentIdTemp = prefs.getInt('documentId');
      int imageSubWorkTypeIdTemp = prefs.getInt('imageSubWorkTypeId');
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('token');
        listLoadTypeMenu.clear();
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Documents/GetLoadTypeMenu/' +
          imageSubWorkTypeIdTemp.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      http.Response response = await http.get(url, headers: headers);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        late ListLoadTypeMenu result;
        setState(() {
          result = ListLoadTypeMenu.fromJson(data);
        });

        //getListLoadTypeMenu
        for (int i = 0; i < result.data!.length; i++) {
          late LoadTypeMenu temp;
          setState(() {
            temp = result.data![i];
            listLoadTypeMenu.add(temp);
          });
        }
      } else {
        showErrorDialog('LoadTypeMenu Not Found!');
      }
    } catch (e) {
      showErrorDialog('Error occured while getLoadTypeMenu');
    }
  }

  Future<void> getItemWoImageDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int documentIdTemp = prefs.getInt('documentId');
      int imageSubWorkTypeIdTemp = prefs.getInt('imageSubWorkTypeId');
      int workTypeIdTemp = prefs.getInt('workTypeId');
      int loadIdTemp = prefs.getInt('loadTypeId');
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('token');
        listLoadTypeMenu.clear();
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Documents/GetItemWoImageDetail?documentId=' +
          documentIdTemp.toString() +
          '&workTypeId=' +
          workTypeIdTemp.toString() +
          '&imageSubWorkTypeId=' +
          imageSubWorkTypeIdTemp.toString() +
          '&loadTypeId=' +
          loadIdTemp.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      http.Response response = await http.get(url, headers: headers);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var datalist = List<ItemWoImageDetail>.from(
            data.map((model) => ItemWoImageDetail.fromJson(model)));
        late ItemWoImageDetail result;
        result = datalist[0];

        if (result.isCompleted!) {
          setState(() {
            step = 1;
          });
          showSuccessDialog('Take Photo Complete');
          return;
        }

        setState(() {
          min = result.min!;
          max = result.max!;
          numberupload = result.numberUpload!;
        });

        if (numberupload < max && numberupload < min) {
          setState(() {
            documentWillUpload = true;
            documentWillUploadOrWillFinish = false;
            documentWillFinish = false;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = seqence.toString() +
                '. ' +
                name +
                ' : ' +
                numberupload.toString() +
                ' / ' +
                max.toString();
            step = 4;
          });
        } else if (numberupload < max && numberupload > min) {
          setState(() {
            documentWillUpload = true;
            documentWillUploadOrWillFinish = true;
            documentWillFinish = false;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = seqence.toString() +
                '. ' +
                name +
                ' : ' +
                numberupload.toString() +
                ' / ' +
                max.toString();
            step = 6;
          });
        } else if (numberupload == max) {
          setState(() {
            documentWillUpload = false;
            documentWillUploadOrWillFinish = false;
            documentWillFinish = true;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = 'Take Photo Successful. Please Press Complete ';
            step = 6;
          });
        }

        await setPrefsWoImageHeaderId(result.woImageHeaderId!);
        await setPrefsWoImageDetailId(result.woImageDetailId!);
      } else {
        showErrorDialog('ItemWoImageDetail Not Found!');
      }
    } catch (e) {
      showErrorDialog('Error occured while getItemWoImageDetail');
    }
  }

  Future<void> openCamera() async {
    if (step == 6) {
      setState(() {
        step = 4;
      });
    }
    //open camera device
    PickedFile? selectedImage = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 30,
        maxHeight: 2000,
        maxWidth: 2000);

    //set image from camera
    File? temp;
    if (selectedImage != null) {
      temp = File(selectedImage.path);
      if (selectedImage.path.isNotEmpty) {
        setState(() {
          _image = temp;
          final encodedBytes = _image!.readAsBytesSync();
          fileInBase64 = base64Encode(encodedBytes);
        });

        /* //print size file image
        double news = fileInBase64.length / (1024 * 1024);
        print('Base64 : ' + news.toString() + ' MB');

        //print size width, height image
        var decoded = await decodeImageFromList(_image!.readAsBytesSync());
        print('Original Width : ' + decoded.width.toString());
        print('Original Height : ' + decoded.height.toString());

        //resize image
        img.Image? image = img.decodeImage(temp.readAsBytesSync());
        var resizedImage = img.copyResize(image!, height: 120, width: 120);

        //Get a path to save the resized file
        final directory = await getApplicationDocumentsDirectory();
        String path = directory.path;

        // Save file
        File resizedFile = File('$path/resizedImage.jpg')
          ..writeAsBytesSync(img.encodePng(resizedImage));

        //encode image to base64
        final encodedBytes2 = resizedFile.readAsBytesSync();
        String fileResizeInBase64 = base64Encode(encodedBytes2);

        //print size file image
        double news2 = fileResizeInBase64.length / (1024 * 1024);
        print('Base64 : ' + news2.toString() + ' MB');

        //print size width, height image
        var decoded2 = await decodeImageFromList(resizedFile.readAsBytesSync());
        print('Resize Width : ' + decoded2.width.toString());
        print('Resize Height : ' + decoded2.height.toString());

        setState(() {
          fileInBase64 = fileResizeInBase64;
        });*/
      }
    }
    if (_image != null) {
      showProgressImageFromCamera();
      setState(() {
        step++;
        print(step);
      });
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      uploadEnabled = false;
    });
    await showProgressLoading(false);
    await getDeviceInfo();
    await getLocation();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int woImageDetailIdTemp = prefs.getInt('woImageDetailId');
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('token');
        listLoadTypeMenu.clear();
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Documents/UploadImageWoImageDetailByImage');

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      late PostImage? imageupload = new PostImage();

      setState(() {
        imageupload.woImageDetailId = woImageDetailIdTemp;
        imageupload.type = 'P';
        imageupload.imageNo = 0;
        imageupload.imageValue = fileInBase64;
        imageupload.deviceInfo = deviceInfo;
        imageupload.osInfo = osVersion;
      });

      var jsonBody = jsonEncode(imageupload);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        PostImageResult result = PostImageResult.fromJson(data);

        setState(() {
          min = result.min!;
          max = result.max!;
          numberupload = result.numberUpload!;
        });

        if (numberupload < max && numberupload < min) {
          setState(() {
            documentWillUpload = true;
            documentWillUploadOrWillFinish = false;
            documentWillFinish = false;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = seqence.toString() +
                '. ' +
                name +
                ' : ' +
                numberupload.toString() +
                ' / ' +
                max.toString();
            step--;
            print(step);
            _image = null;
          });
        } else if (numberupload < max && numberupload >= min) {
          setState(() {
            documentWillUpload = true;
            documentWillUploadOrWillFinish = true;
            documentWillFinish = false;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = seqence.toString() +
                '. ' +
                name +
                ' : ' +
                numberupload.toString() +
                ' / ' +
                max.toString();
            step++;
            print(step);
            _image = null;
          });
        } else if (numberupload >= max) {
          setState(() {
            documentWillUpload = false;
            documentWillUploadOrWillFinish = false;
            documentWillFinish = true;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = 'Take Photo Successful. Please Next Step ';
            step++;
            print(step);
            _image = null;
          });
        }

        await setPrefsWoImageHeaderId(result.woImageHeaderId!);
        await setPrefsWoImageDetailId(result.woImageDetailId!);
        await showProgressLoading(true);
      } else {
        await showProgressLoading(true);
        showErrorDialog('Error occured while uploadImage');
      }
    } catch (e) {
      await showProgressLoading(true);
      showErrorDialog('Error occured while uploadImage');
    }
  }

  Future<void> next() async {
    setState(() {
      nextEnabled = false;
    });
    await showProgressLoading(false);
    await getDeviceInfo();
    await getLocation();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int woImageHeaderIdTemp = prefs.getInt('woImageHeaderId');
      int woImageDetailIdTemp = prefs.getInt('woImageDetailId');
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('token');
        listLoadTypeMenu.clear();
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Documents/CompletedWoImageDetailitemBySeq?woImageHeaderId=' +
          woImageHeaderIdTemp.toString() +
          '&woImageDetailId=' +
          woImageDetailIdTemp.toString());

      print('header :' + woImageHeaderIdTemp.toString());

      print('detail :' + woImageDetailIdTemp.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      Map<String, dynamic> body = {
        'woImageHeaderId': woImageHeaderIdTemp,
        'woImageDetailIdTemp': woImageDetailIdTemp
      };
      var jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      var data = json.decode(response.body);

      print('status' + response.statusCode.toString());
      if (response.statusCode == 200) {
        PostImageResult result = PostImageResult.fromJson(data);

        setState(() {
          min = result.min!;
          max = result.max!;
          numberupload = result.numberUpload!;
        });

        if (numberupload < max && numberupload < min) {
          setState(() {
            documentWillUpload = true;
            documentWillUploadOrWillFinish = false;
            documentWillFinish = false;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = seqence.toString() +
                '. ' +
                name +
                ' : ' +
                numberupload.toString() +
                ' / ' +
                max.toString();
            step--;
            step--;
            print(step);
            _image = null;
          });
        } else if (numberupload < max && numberupload >= min) {
          setState(() {
            documentWillUpload = true;
            documentWillUploadOrWillFinish = true;
            documentWillFinish = false;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = seqence.toString() +
                '. ' +
                name +
                ' : ' +
                numberupload.toString() +
                ' / ' +
                max.toString();
            step++;
            print(step);
            _image = null;
          });
        } else if (numberupload >= max) {
          setState(() {
            documentWillUpload = false;
            documentWillUploadOrWillFinish = false;
            documentWillFinish = true;
            seqence = result.sequence!;
            name = result.name!;
            statusUpload = 'Take Photo Successful. Please Next Step ';
            step++;
            print(step);
            _image = null;
          });
        }

        await setPrefsWoImageHeaderId(result.woImageHeaderId!);
        await setPrefsWoImageDetailId(result.woImageDetailId!);
        await showProgressLoading(true);
      } else if (response.statusCode == 404) {
        await showProgressLoading(true);
        setState(() {
          step++;
        });
      } else {
        await showProgressLoading(true);
        showErrorDialog('Error occured while next');
      }
    } catch (e) {
      await showProgressLoading(true);
      showErrorDialog('Error occured while next');
    }
  }

  Future<void> finish() async {
    setState(() {
      finishEnabled = false;
    });
    await showProgressLoading(false);
    await getDeviceInfo();
    await getLocation();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int woImageHeaderIdTemp = prefs.getInt('woImageHeaderId');
      int woImageDetailIdTemp = prefs.getInt('woImageDetailId');
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('token');
        listLoadTypeMenu.clear();
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Documents/CompletedWoImageDetailitemBySeq?woImageHeaderId=' +
          woImageHeaderIdTemp.toString() +
          '&woImageDetailId=' +
          woImageDetailIdTemp.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      Map<String, dynamic> body = {
        'woImageHeaderId': woImageHeaderIdTemp,
        'woImageDetailIdTemp': woImageDetailIdTemp
      };
      var jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          step = 1;
        });
        await showProgressLoading(true);
      } else {
        await showProgressLoading(true);
        showErrorDialog('Error occured while finish');
      }
    } catch (e) {
      await showProgressLoading(true);
      showErrorDialog('Error occured while finish');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'ถ่ายภาพการบรรจุสินค้า',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 18),
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
            child: Container(
                child: SingleChildScrollView(
                    child: Column(children: [
          SizedBox(height: 28),
          Container(
              padding: new EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5),
              child: Visibility(
                  visible: documentVisible,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    readOnly: documentReadonly,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (value) async {
                      await documentIDCheck();
                      setVisible();
                      setReadOnly();
                      setColor();
                      setText();
                    },
                    decoration: InputDecoration(
                      //icon: const Icon(Icons.person),
                      fillColor: documentColor,
                      filled: true,
                      hintText: 'กรอกข้อมูล',
                      labelText: 'เลขที่ใบงาน / DO No.',
                      border: OutlineInputBorder(),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(13.5), //
                    ),
                    controller: documentController,
                  ))),
          SizedBox(
            height: 12,
          ),
          Visibility(
              visible: header1Visible,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(header1),
              )),
          Visibility(
              visible: header2Visible,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(header2),
              )),
          Visibility(
              visible: header3Visible,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(header3),
              )),
          Visibility(
              visible: listVisible,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _showLists(context),
                  ],
                ),
              )),
          Visibility(
              visible: listVisible2,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _showLists2(context),
                  ],
                ),
              )),
          Visibility(
              visible: backMenuVisible,
              child: new Center(
                child: new ButtonBar(
                  mainAxisSize: MainAxisSize
                      .min, // this will take space as minimum as posible(to center)
                  children: <Widget>[
                    new RaisedButton(
                      color: Colors.red,
                      child: const Text('ย้อนกลับ',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: true
                          ? () async {
                              await backMenu();
                              setVisible();
                              setReadOnly();
                              setColor();
                              setText();

                              if (step == 1) {
                                setState(() {
                                  listImageSubWorkTypeMenu.clear();
                                });
                              } else if (step == 2) {
                                setState(() {
                                  listLoadTypeMenu.clear();
                                });
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              )),
          //SizedBox(height: 10),
          Visibility(
              visible: buttonUploadVisible,
              child: new Center(
                child: new ButtonBar(
                  mainAxisSize: MainAxisSize
                      .min, // this will take space as minimum as posible(to center)
                  children: <Widget>[
                    SizedBox(
                        width: 63, // specific value
                        child: new RaisedButton(
                          color: Colors.blue,
                          child: const Text('ย้อนกลับ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.3)),
                          onPressed: backEnabled
                              ? () async {
                                  await backButtonUpload();
                                  setVisible();
                                  setReadOnly();
                                  setColor();
                                  setText();
                                }
                              : null,
                        )),
                    SizedBox(
                        width: 58, // specific value
                        child: new RaisedButton(
                          color: step == 4 ? Colors.green : Colors.blue,
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.add_a_photo_outlined)
                            ],
                          ),
                          onPressed: takePhotoEnabled
                              ? () async {
                                  await openCamera();
                                  setVisible();
                                  setReadOnly();
                                  setColor();
                                  setText();
                                }
                              : null,
                        )),
                    SizedBox(
                        width: 58, // specific value
                        child: new RaisedButton(
                          color: step == 5 ? Colors.green : Colors.blue,
                          child: Column(
                            children: <Widget>[Icon(Icons.upload_file)],
                          ),
                          onPressed: uploadEnabled
                              ? () async {
                                  await uploadImage();
                                  setVisible();
                                  setReadOnly();
                                  setColor();
                                  setText();
                                }
                              : null,
                        )),
                    SizedBox(
                        width: 58, // specific value
                        child: new RaisedButton(
                          color: step == 6 ? Colors.green : Colors.blue,
                          child: const Text('ถัดไป',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.3)),
                          onPressed: nextEnabled
                              ? () async {
                                  await next();
                                  setVisible();
                                  setReadOnly();
                                  setColor();
                                  setText();
                                }
                              : null,
                        )),
                    SizedBox(
                        width: 58, // specific value
                        child: new RaisedButton(
                          color: step == 7 ? Colors.green : Colors.blue,
                          child: const Text('เสร็จสิ้น',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.3)),
                          onPressed: finishEnabled
                              ? () async {
                                  await finish();
                                  setVisible();
                                  setReadOnly();
                                  setColor();
                                  setText();
                                }
                              : null,
                        )),
                  ],
                ),
              )),
          Visibility(
              visible: buttonUploadVisible,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: _image != null
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 225,
                                height: 225,
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
                  ])),
        ])))));
  }

  Widget _showLists(BuildContext context) {
    return Visibility(
        visible: listVisible,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int temp = index + 1;
                return MenuList2(
                  text: listImageSubWorkTypeMenu[index]
                      .menuWorkTypeNameMobile
                      .toString(),
                  imageIcon: ImageIcon(
                    AssetImage('assets/camera.png'),
                    size: 25,
                    color: Colors.blue,
                  ),
                  press: () async => {
                    setState(() {
                      //getHeader2
                      String temp = listImageSubWorkTypeMenu[index]
                          .menuWorkTypeNameMobile
                          .toString();
                      header2 = 'เมนู : $temp';
                      step++;
                    }),
                    await setPrefsImageSubWorkTypeId(
                        listImageSubWorkTypeMenu[index].imageSubWorkTypeId!),
                    await setPrefsImageSubWorkTypeName(
                        listImageSubWorkTypeMenu[index]
                            .menuWorkTypeNameMobile!),
                    await getLoadTypeMenu(),
                    setVisible(),
                    setReadOnly(),
                    setColor(),
                    setText(),
                  },
                );
              },
              itemCount: listImageSubWorkTypeMenu.length,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.vertical,
            ),
          ]),
        ));
  }

  Widget _showLists2(BuildContext context) {
    return Visibility(
        visible: listVisible2,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int temp = index + 1;
                return MenuList2(
                  text: listLoadTypeMenu[index].loadTypeName.toString(),
                  imageIcon: ImageIcon(
                    AssetImage('assets/camera.png'),
                    size: 25,
                    color: Colors.blue,
                  ),
                  press: () async => {
                    setState(() {
                      //getHeader3
                      String temp =
                          listLoadTypeMenu[index].loadTypeName.toString();
                      header3 = 'ขั้นตอน : $temp';
                      step++;
                    }),
                    await setPrefsLoadTypeId(
                        listLoadTypeMenu[index].loadTypeId!),
                    await setPrefsLoadTypeName(
                        listLoadTypeMenu[index].loadTypeName!),
                    await getItemWoImageDetail(),
                    setVisible(),
                    setReadOnly(),
                    setColor(),
                    setText(),
                  },
                );
              },
              itemCount: listLoadTypeMenu.length,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.vertical,
            ),
          ]),
        ));
  }
}
