package com.example.fluttersdkplugin_example

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.resdk.ResdkPlugin
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import io.flutter.Log


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





