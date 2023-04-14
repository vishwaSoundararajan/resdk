import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:resdk/resdk.dart';
import 'package:resdk_example/screen1.dart';

import 'Screen2.dart';

void main() {
  runApp(const MyApp());
}
final _reSdkPlugin = Resdk();
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown',
      token = "ezyY7vF9TSqiwA3wxwJmYC:APA91bENxHnr2Z2XFHRpbu7GVJklVnDjs7phmEh2M4YNcxxxrPNRw1wtlvwAkGES_uEH8-wRAck30oBkvOwlZ0fJOyVYbcuOAaiOlHGwA9LTLxFnT5iAPAQEGN2LIgfyh6Ax9Iw5Kcf7";
  int notificationCount = 0,
      _counter = 0;
  late String cid;
  late String nList;
  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  passLocation() {
    double lat = 13.0827;
    double lang = 80.2707;
    _reSdkPlugin.pushLocation(lat, lang);
  }

  newNotification() {
    var notificationTitle = "sample Title";
    var notificationBody = "sample Body";
    _reSdkPlugin.addNewNotification(
        notificationTitle, notificationBody);
  }

  ontrackEvent() {
    var content = "On Track Event called!!!";
    _reSdkPlugin.onTrackEvent(content);
  }

  deleteNotificationByCampaignid() {
    setCidState();
    _reSdkPlugin.deleteNotificationByCampaignId(cid);
  }

  setCidState() {
    setState(() {
      cid ="k2S||FaV|vV|T_tX7N6|1003123|Bulk|20221115060533";
    });
  }

  readnotification() {
    setCidState();
    _reSdkPlugin.readNotification(cid);
  }

  unreadNotification() {
    setCidState();
    _reSdkPlugin.unReadNotification(cid);
  }

  appconversionTracking() {
    _reSdkPlugin.appConversionTracking();
  }

  formdataCapture() {
    Map param = {
      "Name": "vishwa",
      "EmailID": "abc@gmail.com",
      "MobileNo": 9329222922,
      "Gender": "Male",
      "formid": 101, // required
      "apikey": "api_key_b78db6rb3-9462-4132-a4d3-894db10b3782",
      "City": "Chennai" // required
    };
    String formData = jsonEncode(param);
    _reSdkPlugin.formDataCapture(formData);
  }

  onTrackEventwithData() {
    var data = {
      "name": "payment",
      "data": {"id": "2d43", "price": "477"}
    };
    String eventData = jsonEncode(data);
    _reSdkPlugin.onTrackEventwithData(eventData, "Purchase");
  }

  updatepushToken() {
    _reSdkPlugin.updatePushToken(token);
  }
  ondeviceRegister() {

    Map param = {
      "userUniqueId":"123",
      "name": "vishwa",
      "email": "abc@gmail.com",
      "phone": "12334455",
      "gender": "Male",
      "profileUrl":"",
      "dob":"23/12/2010",
      "education":"BE",
      "employed":"true",
      "married":"false",
      "deviceToken":token,
      "StoreId":"2334"
    };
    String userData = jsonEncode(param);
    _reSdkPlugin.onDeviceUserRegister(userData);
  }
  getdeepLinkData() {
    _reSdkPlugin.deepLinkData();
  }
  Future<int?> readnotificationCount() async {
    var rnCount = await _reSdkPlugin.readNotificationCount()!;
    setState(() {
      notificationCount = rnCount!;
    });
    if (kDebugMode) {
      print("readNotificationCount::$rnCount");
    }
    return null;
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _reSdkPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child:ConstrainedBox(
            constraints: BoxConstraints(),
            child:Container(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () { //
                      ondeviceRegister();
                    }, child: Text("On Device User Register"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      updatepushToken();
                    }, child: Text("update Push Token"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      passLocation();
                    }, child: Text("Update Location"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(

                      onPressed: () {
                        newNotification();
                      }, child: Text("Add New Notification"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      readnotification();
                    }, child: Text("Read Notification By Id"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      unreadNotification();
                    }, child: Text("UnRead Notification BY Id"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      setState(() async {
                        nList = await _reSdkPlugin
                            .getNotification();
                      });
                    }, child: Text("Get Notifications"),),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      readnotificationCount();
                    }, child: const Text("Read Notification Count"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      setState(() async {
                        var un_rCount = await _reSdkPlugin
                            .unReadNotificationCount();
                        print("unReadNotificationCount:: $un_rCount");
                      });
                    }, child: const Text("Un_Read_Notification_Count"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      deleteNotificationByCampaignid();
                      setState(() {
                        controller1.clear();
                      });
                    }, child: Text("Delete Notification By CampaignId"),),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      formdataCapture();
                    }, child: Text("form Data Capture"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      ontrackEvent();
                    }, child: Text("OnTrackEvent"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      onTrackEventwithData();
                    }, child: const Text("OnTrackEventwithData"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      appconversionTracking();
                    }, child: Text("app Conversion Tracking"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      getdeepLinkData();
                    }, child: Text("Get deepLinkData"),),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      _reSdkPlugin.screentracking("Screen1");
                    },
                        style:
                        ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),), child: Text("Screen-1"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      _reSdkPlugin.screentracking("Screen2");
                    },style:
                    ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),), child: Text("Screen-2"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      _reSdkPlugin.screentracking("Screen3");
                    }, child: Text("Screen-3"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      _reSdkPlugin.qrlink(
                          "http://myolaapp.page.link/start");
                    }, child: Text("QR-Link"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      _reSdkPlugin.notificationCTAClicked(
                          "c_id12", "a_id34");
                    }, child: Text("NotificationCTAClicked"),),
                  ),


                ],
              ),
            )
          )
        )
      ),
    );
  }
}
