import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'resdk_method_channel.dart';

abstract class ResdkPlatform extends PlatformInterface {
  /// Constructs a ResdkPlatform.
  ResdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static ResdkPlatform _instance = MethodChannelResdk();

  /// The default instance of [ResdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelResdk].
  static ResdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ResdkPlatform] when
  /// they register themselves.
  static set instance(ResdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void pushLocation(double lat, double lang) {
    throw UnimplementedError('pushLocation() has not been implemented');
  }

  addNewNotification(String notificationTitle, String notificationBody){
    throw UnimplementedError('newNotification() has not been implemented');
  }

  void onTrackEvent(String content) {
    throw UnimplementedError('onTrackEvent() has not been implemented');
  }
  void onTrackEventwithData(String eventData, String event) {
    throw UnimplementedError('onTrackEventwithData() has not been implemented.');
  }

  void deleteNotificationByCampaignId(content) {
    throw UnimplementedError('deleteNotificationByCampaignId() has not been implemented');
  }
  void readNotification(content) {
    throw UnimplementedError('readNotification() has not been implemented');
  }

  void appConversionTracking() {
    throw UnimplementedError('appConversionTracking() has not been implemented');
  }

  void formDataCapture(String formData) {
    throw UnimplementedError('formDataCapture() has not been implemented');
  }

  Future<int?>readNotificationCount() {
    throw UnimplementedError('readNotificationCount() has not been implemented');
  }

  void updatePushToken(String token) {
    throw UnimplementedError('updatePushToken() has not been implemented');
  }

  void onDeviceUserRegister(String userData) {
    throw UnimplementedError('onDeviceUserRegister() has not been implemented');
  }

  void deepLinkData() {
    throw UnimplementedError('deepLinkData() has not been implemented');
  }

  void unReadNotification(String cid) {
    throw UnimplementedError('unReadNotification() has not been implemented');
  }
  Future <int?> unReadNotificationCount() {
    throw UnimplementedError('unReadNotification() has not been implemented');
  }

  onMessageReceived(RemoteMessage msg) {
    throw UnimplementedError('onMessageReceived() has not been implemented.');
  }

  Future<dynamic>getNotification() {
    throw UnimplementedError('getNotification() has not been implemented.');
  }

  void screentracking(String screenName) {
    throw UnimplementedError('screentracking() has not been implemented.');
  }

  void qrlink(String myLink) {
    throw UnimplementedError('qrlink() has not been implemented.');
  }

  void notificationCTAClicked(String camplaignId, String actionId) {
    throw UnimplementedError('notificationCTAClicked() has not been implemented.');
  }

  void getCampaignData() {
    throw UnimplementedError('getCampaignData() has not been implemented');
  }





}
