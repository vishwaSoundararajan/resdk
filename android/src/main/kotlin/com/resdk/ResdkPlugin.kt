package com.resdk

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.google.firebase.messaging.RemoteMessage
import io.mob.resu.reandroidsdk.*
import org.json.JSONObject
import com.google.gson.Gson
import android.util.Log
import com.google.gson.JsonParser
import java.util.*

/** ResdkPlugin */
class ResdkPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity
  var OldScreenName: String? = null
  var newScreenName: String? = null
  private var oldCalendar = Calendar.getInstance()
  private var sCalendar = Calendar.getInstance()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "resdk")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    else if(call.method == "onDeviceUserRegister") {
    val gson=Gson()
      var jsonString: String?=call.argument("userData")
      val jsonElement = JsonParser.parseString(jsonString)
      val userUniqueId = jsonElement.asJsonObject.get("userUniqueId").asString
      val name = jsonElement.asJsonObject.get("name").asString
      val age=jsonElement.asJsonObject.get("age").asString
      val email=jsonElement.asJsonObject.get("email").asString
      val phone=jsonElement.asJsonObject.get("phone").asString
      val gender=jsonElement.asJsonObject.get("gender").asString
      val token=jsonElement.asJsonObject.get("token").asString
      val profileUrl=jsonElement.asJsonObject.get("profileUrl").asString
      val dob=jsonElement.asJsonObject.get("dob").asString
      val education=jsonElement.asJsonObject.get("education").asString
      val employed=jsonElement.asJsonObject.get("employed").asBoolean
      val married=jsonElement.asJsonObject.get("married").asBoolean
      val adId=jsonElement.asJsonObject.get("adId").asString

      val obj = MRegisterUser()
      obj.userUniqueId=userUniqueId
      obj.name=name
      obj.age=age
      obj.email=email
      obj.phone=phone
      obj.gender=gender
      obj.deviceToken=token
      obj.profileUrl=profileUrl
      obj.dob=dob
      obj.education=education
      obj.adId=adId
      if (employed != null) {
        obj.isEmployed=employed
      }
      if (married != null) {
        obj.isMarried=married
      }
      ReAndroidSDK.getInstance(context).onDeviceUserRegister(obj)
    }
    else if(call.method == "updatePushToken") {
      var token: String?=call.argument("regToken")
      ReAndroidSDK.getInstance(context).updatePushToken(token)
    }
    else if(call.method == "formDataCapture") {
      var formData:String? = call.argument("formData")
      val jobj=JSONObject(formData)
      if (formData != null) {
        ReAndroidSDK.getInstance(context).formDataCapture(jobj)
      }
    }

    else if(call.method == "onTrackEventwithData") {
      val event: String?=call.argument("event")
      val eventData:String? = call.argument("eventData")
      val jobj= eventData?.let { JSONObject(it) }
      if (eventData != null) {
        ReAndroidSDK.getInstance(context).onTrackEvent(jobj, event)
      }
    }
    else if(call.method == "onTrackEvent") {
      var content:String? = call.argument("string")
      if (content != null) {
        ReAndroidSDK.getInstance(context).onTrackEvent(content)
      }
    }
    else if(call.method =="screentracking"){
      val screenName: String ? = call.argument("screenname")
      if (screenName != null) {
        if (sCalendar == null) sCalendar = Calendar.getInstance()
        oldCalendar = sCalendar
        sCalendar = Calendar.getInstance()
        if (OldScreenName != null) {
          activity=Activity()
          // context=mycontext
          AppLifecyclePresenter.getInstance()
            .onSessionStop(context, oldCalendar, sCalendar, OldScreenName, null, null)
          AppLifecyclePresenter.getInstance().onSessionStartFragment(activity, OldScreenName, null)
        }
        if (newScreenName == null) newScreenName = screenName
        // screenTracking(screenName)
      }
      OldScreenName = newScreenName
      newScreenName = screenName
    }

    else if(call.method == "getNotifications") {
      var notificationList: ArrayList<JSONObject> = ReAndroidSDK.getInstance(context).notificationByObject;
      val gson = Gson()
      val nList = gson.toJson(notificationList)

      val hashMap: HashMap<Int, HashMap<String, String>> = HashMap()
      for (i in notificationList.indices) {
        val jsonObj: JSONObject = notificationList[i]
        val keys: Iterator<String> = jsonObj.keys()
        val jsonMap: HashMap<String, String> = HashMap()

        while (keys.hasNext()) {
          val key: String = keys.next()
          val value: String = jsonObj.getString(key)
          jsonMap.put(key, value)
        }
        hashMap[i] = jsonMap
      }
      print("HashMap :: $hashMap")
      result.success(nList)
    }


    else if(call.method == "deleteNotificationByCampaignId") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).deleteNotificationByCampaignId(cid)
      }
    }
    else if(call.method == "readNotificationCount") {
      result.success(ReAndroidSDK.getInstance(context).readNotificationCount)
    }

    else if(call.method =="unReadNotificationCount"){
      result.success(ReAndroidSDK.getInstance(context).unReadNotificationCount)
    }
    else if(call.method == "readNotification") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).readNotification(cid)
      }
    }

    else if(call.method == "unReadNotification") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).unReadNotification(cid)
      }
    }

    else if(call.method == "pushLocation") {
      var lat:Double? = call.argument("lat")
      var lang:Double? = call.argument("lang")
      if (lat != null && lang != null) {
        ReAndroidSDK.getInstance(context).onLocationUpdate(lat,lang)
      }
    }

    else if(call.method == "addNewNotification") {
      var title:String? = call.argument("title")
      var body:String? = call.argument("body")
      if (title != null && body != null) {
        ReAndroidSDK.getInstance(context).addNewNotification(title,body,"MainActivity")
      }
    }

    else if(call.method == "appConversionTracking") {
//      val jsonString = "{\"name\":\"John\",\"age\":30,\"city\":\"New York\"}"
//      val jsonObject: org.json.JSONObject = JSONObject(jsonString)
//      ReAndroidSDK.getInstance(context).appConversionTracking(jsonObject)
      ReAndroidSDK.getInstance(context).appConversionTracking()
    }

    else if(call.method == "deepLinkData") {
      ReAndroidSDK.getInstance(context).deepLinkData
    }

    else if(call.method =="qrlink") {
      class MyIGetQR:IGetQRLinkDetail{
        override fun onSmartLinkDetails(p0: String?) {
        }
        override fun onError(p0: String?) {
        }
      }
      val myLink: String? = call.argument("myLink")
      ReAndroidSDK.getInstance(context).handleQrLink(myLink,MyIGetQR())
    }

    else if(call.method =="notificationCTA"){
      val campainId: String ? = call.argument("campaignId")
      val actionId: String ? = call.argument("actionId")
      ReAndroidSDK.getInstance(context).notificationCTAClicked(campainId,actionId)

    }


    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun initReSdk(flutterContext:Context){
    ReAndroidSDK.getInstance(flutterContext)
    AppConstants.LogFlag=true
    io.flutter.Log.d("initsdk", "SDK initialized1")
  }
  fun clientMessageReceiver(remoteMessage:RemoteMessage,flutterContext: Context){
    io.flutter.Log.d("msgTrace", "From native code!!!!")
    ReAndroidSDK.getInstance(flutterContext).onReceivedCampaign(remoteMessage.data)

  }



}
