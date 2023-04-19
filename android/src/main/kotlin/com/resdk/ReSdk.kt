package com.resdk

import android.content.Context
import com.google.firebase.messaging.RemoteMessage


class ReSdk {
    var resdkPlugin=ResdkPlugin()

    fun initReSdk(flutterContext: Context){
         resdkPlugin.initReSdk(flutterContext)
    }
    fun onReceivedCampaign(remoteMessage:RemoteMessage,flutterContext: Context){
        resdkPlugin.clientMessageReceiver(remoteMessage,flutterContext)
    }

}