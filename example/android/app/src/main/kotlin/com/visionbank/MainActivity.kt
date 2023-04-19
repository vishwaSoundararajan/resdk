package com.visionbank

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import com.google.firebase.messaging.RemoteMessage
import io.flutter.embedding.android.FlutterActivity
import com.resdk.ReSdk
import com.resdk.ResdkPlugin
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel


class MainActivity: FlutterActivity() {
    private lateinit var eChannel: EventChannel
    private lateinit var remoteMessenger: RemoteMessage

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ResdkPlugin().initReSdk(this)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val filter = IntentFilter("com.example.fluttersdkplugin_example/MY_EVENT")
        registerReceiver(receiver, filter)
        eChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.fluttersdkplugin_example/channell"
        )
    }
    private val receiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            val message: String? = intent.getStringExtra("message")

            val token:String?=intent.getStringExtra("dtoken")
            if (message != null) {
                callEventChannel(message)
            }
        }
    }
    fun callEventChannel(data:String){
        eChannel.setStreamHandler(MessageNotifier(data))
    }
    fun msgReceiver(remoteMessage: RemoteMessage){
        print("msgReceiver called!!!!!!!!!!!")
//        _fluttersdkplugin=FluttersdkpluginPlugin()
//        _fluttersdkplugin.clientMessageReceiver(remoteMessenger,this)
    }

}


class MessageNotifier(var msg:String)  : EventChannel.StreamHandler {

    override fun onListen(arguments: Any?,events: EventChannel.EventSink) {
        events.success(msg)
        msg="";
    }
    override fun onCancel(arguments: Any?) {

    }

}

