package com.visionbank

import android.content.Intent
import com.resdk.ReSdk
import com.resdk.ResdkPlugin
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import io.flutter.Log
import android.os.Bundle

class MessagingService : FirebaseMessagingService(){
    lateinit var token:String
    val bundle = Bundle()
    override fun onNewToken(tokken: String) {
        super.onNewToken(tokken)
        token=tokken
        Log.i("token", "Refreshed token :: $tokken")
    }
     override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        var intent: Intent = Intent("com.example.fluttersdkplugin_example/MY_EVENT");
        intent.putExtra("message",remoteMessage.notification?.title);
        sendBroadcast(intent);
        Log.d("msgTrace", "RemoteMessage!!!!")
        ResdkPlugin().clientMessageReceiver(remoteMessage,this)
     }

}





