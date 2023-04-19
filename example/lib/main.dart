import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:resdk/resdk.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
      token = "eaAa9ANZQ4aGwoSaibCpWn:APA91bFDXGwMaQxwGNuDoSyatr8QGg23uwIzdPmwqusHvaI8_BEtE6Dh0q2HW3ZRSz6KKX_Ngo-5pK1P4z5-DePPpqE54KZP8VhU8nCZKqjBWbLqBJpoLwz1VPZssIfhO_gimvOn8oXc";
  int notificationCount = 0,
      _counter = 0;
  late String cid;
  late String nList;
  late  MethodChannel _methodChannel;
  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
  _methodChannel = MethodChannel('myChannel');
    initPlatformState();
  }
  passLocation() {
    double lat = 13.0827;
    double lang = 80.2707;
    _reSdkPlugin.locationUpdate(lat, lang);
  }

  newNotification() {
    var notificationTitle = "sample Title";
    var notificationBody = "sample Body";
    _reSdkPlugin.addNewNotification(
        notificationTitle, notificationBody);
  }

  ontrackEvent() {
    var content = "On Track Event called!!!";
    _reSdkPlugin.onCustomEvent(content);
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
    _reSdkPlugin.onCustomEventWithData(eventData, "Purchase");
  }

  updatepushToken() {
    _reSdkPlugin.updatePushToken(token);
  }
  ondeviceRegister() {

    Map param = {
      "userUniqueId":"123",
      "name": "vishwa",
      "age":"23",
      "email": "abc@gmail.com",
      "phone": "12334455",
      "gender": "Male",
      "profileUrl":"",
      "dob":"23/12/2010",
      "education":"BE",
      "employed":"true",
      "married":"false",
      "deviceToken":token,
      "storeId":"2334"
    };
    String userData = jsonEncode(param);
    _reSdkPlugin.onDeviceUserRegister(userData);
  }


  getdeepLinkData() {
    _reSdkPlugin.deepLinkData();
  }
  Future<int?> readnotificationCount() async {
    var rnCount = await _reSdkPlugin.getReadNotificationCount()!;
    setState(() {
      notificationCount = rnCount!;
    });
    if (kDebugMode) {
      print("readNotificationCount::$rnCount");
    }
    return null;
  }

  void initDynamicLinks() async{
    print("initDynamic links called!!!");
    final PendingDynamicLinkData? dynamicLink =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deeplink = dynamicLink?.link;
    if (deeplink != null) {
      Get.toNamed(deeplink.queryParameters.values.first);
    }
    else{
      if (kDebugMode) {
        print("Page not available!!!");
      }
    }
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

  void myMethod(String message) {
    print('Message from native code: $message');
  }

  @override
  Widget build(BuildContext context) {

   _methodChannel = MethodChannel('myChannel');
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'myMethod') {
        String message = call.arguments;
        myMethod(message);
      }
    });


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
                            .getUnReadNotificationCount();
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      _reSdkPlugin.getCampaiginData();
                    }, child: Text("GetCampaignData"),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      style:
                      ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),);
                      _reSdkPlugin.deepLinkData();
                    }, child: Text("GetDeepLinkData"),),
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
