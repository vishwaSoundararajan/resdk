
import 'resdk_platform_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class Resdk {
  Future<String?> getPlatformVersion() {
    return ResdkPlatform.instance.getPlatformVersion();
  }
  locationUpdate(double lat, double lang) {
    ResdkPlatform.instance.pushLocation(lat, lang);
  }
  addNewNotification(String notificationTitle, String notificationBody) {
    ResdkPlatform.instance.addNewNotification(
        notificationTitle, notificationBody);
  }
  onCustomEvent(String content) {
    ResdkPlatform.instance.onTrackEvent(content);
  }

  onCustomEventWithData(String eventData,String event){
    ResdkPlatform.instance.customEvent(eventData,event);
  }

  void deleteNotificationByCampaignId(String cid) {
    ResdkPlatform.instance.deleteNotificationByCampaignId(cid);
  }
  void readNotification(String cid) {
    ResdkPlatform.instance.readNotification(cid);
  }
  void appConversionTracking() {
    ResdkPlatform.instance.appConversionTracking();
  }

  void appConversionTrackingWithData() {
    ResdkPlatform.instance.appConversionTracking();
  }

  void formDataCapture(String formData) {
    ResdkPlatform.instance.formDataCapture(formData);
  }
  Future<int?>  getReadNotificationCount()async {
    var r_Ncount= ResdkPlatform.instance.readNotificationCount();
    return r_Ncount;
  }
  Future <int?> getUnReadNotificationCount()async {
    var un_Ncount= await ResdkPlatform.instance.unReadNotificationCount();
    return un_Ncount;
  }
  void updatePushToken(String token) {
    ResdkPlatform.instance.updatePushToken(token);
  }
  void onDeviceUserRegister(String userData) {
    ResdkPlatform.instance.onDeviceUserRegister(userData);
  }
  void deepLinkData () {
   ResdkPlatform.instance.deepLinkData();

  }
  void unReadNotification(String cid) {
    ResdkPlatform.instance.unReadNotification(cid);
  }

  onMessageReceived(RemoteMessage msg) {
    ResdkPlatform.instance.onMessageReceived(msg);
  }
  Future<dynamic> getNotification()async{
    var nList = await ResdkPlatform.instance.getNotification();
    return nList;
  }

  screentracking(String screenName){
    ResdkPlatform.instance.screentracking(screenName);
  }
  qrlink(String myLink){
    ResdkPlatform.instance.qrlink(myLink);
  }
  notificationCTAClicked(String camplaignId,String actionId){
    ResdkPlatform.instance.notificationCTAClicked(camplaignId,actionId);
  }
  getCampaiginData(){
    ResdkPlatform.instance.getCampaignData();
  }
}
