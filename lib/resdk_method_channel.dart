import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'resdk_platform_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
/// An implementation of [ResdkPlatform] that uses method channels.
class MethodChannelResdk extends ResdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('resdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  pushLocation(double lat, double lang) {
    methodChannel.invokeMapMethod('pushLocation', {'lat': lat, 'lang': lang});
  }

  @override
  addNewNotification(String notificationTitle, String notificationBody) {
    methodChannel.invokeMapMethod('addNewNotification',{'title': notificationTitle,'body':notificationBody});
  }
  @override
  onTrackEvent(String content) {
    methodChannel.invokeMapMethod('onTrackEvent',{'string': content});
  }

  @override
  onTrackEventwithData(String eventData,String event){
    methodChannel.invokeMapMethod('onTrackEventwithData',{"eventData":eventData,"event":event});
  }

  @override
  deleteNotificationByCampaignId(content) {
    methodChannel.invokeMapMethod('deleteNotificationByCampaignId',{'cid':content});
  }
  @override
  readNotification(content) {
    methodChannel.invokeMapMethod('readNotification',{'cid':content});
  }
  @override
  appConversionTracking() {
    methodChannel.invokeMapMethod('appConversionTracking');
  }

  @override
  formDataCapture(String formData) {
    methodChannel.invokeMapMethod('formDataCapture',{'formData':formData});
  }

  @override
  updatePushToken(String regToken) {
    methodChannel.invokeMapMethod('updatePushToken',{'regToken':regToken});
  }
  @override
  onDeviceUserRegister(String userData) {
    methodChannel.invokeMapMethod('onDeviceUserRegister',{'userData':userData});
  }
  @override
  deepLinkData() {
    methodChannel.invokeMapMethod('deepLinkData');
  }
  @override
  Future<int?> readNotificationCount() async {
    final notifyCount=await methodChannel.invokeMethod<int>('readNotificationCount');
    return notifyCount;
  }
  @override
  unReadNotification(String cid) {
    methodChannel.invokeMapMethod('unReadNotification',{'cid':cid});
  }
  @override
  Future <int?> unReadNotificationCount() async {
    final ur_nCount= await methodChannel.invokeMethod('unReadNotificationCount');
    return ur_nCount;
  }
  @override
  onMessageReceived(RemoteMessage msg){
    methodChannel.invokeMethod('onMessageReceived',{'msg':msg});

  }
  @override
  Future<dynamic> getNotification() async {
    var nList = await methodChannel.invokeMethod('getNotifications');
    return nList;
  }

  @override
  screentracking(String screenName){
    methodChannel.invokeMapMethod('screentracking',{"screenname":screenName});
  }
  @override
  qrlink(String myLink){
    methodChannel.invokeMapMethod('qrlink',{"myLink":myLink});
  }
  @override
  notificationCTAClicked(String camplaignId,String actionId){
    methodChannel.invokeMapMethod('notificationCTA',{"campaignId":camplaignId,"actionId":actionId});
  }
  @override
  getCampaignData(){
    methodChannel.invokeMethod('getCampaignData');
  }


}
