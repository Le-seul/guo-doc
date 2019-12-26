package cn.gov.gaj.phms.v3

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import cn.gov.gaj.phms.v3.plugin.PluginRegistrant
import cn.gov.gaj.phms.v3.service.QuietPlayerChannel
import cn.gov.gaj.phms.v3.TodayStepManager
import cn.gov.gaj.phms.v3.TodayStepService
import android.app.Activity
import android.content.ComponentName
import android.content.Context
import cn.gov.gaj.phms.v3.utils.log
import android.content.ServiceConnection
import android.os.*


class MainActivity : FlutterActivity() {


    //循环取当前时刻的步数中间的间隔时间
    private val TIME_INTERVAL_REFRESH: Long = 3000
    private val mDelayHandler =  Handler(TodayStepCounterCall())
    private var mStepSum: Int = 0
    private lateinit var iSportStepInterface: ISportStepInterface

    private val mServiceConnection: ServiceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            //Activity和Service通过aidl进行通信
            iSportStepInterface = ISportStepInterface.Stub.asInterface(service)
            try {
                mStepSum = iSportStepInterface.getCurrentTimeSportStep()
                updateStepCount()
            } catch (e: RemoteException) {
                e.printStackTrace()
            }
            mDelayHandler.sendEmptyMessageDelayed(REFRESH_STEP_WHAT, TIME_INTERVAL_REFRESH)
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            val intent = Intent(this@MainActivity, TodayStepService::class.java)
            startService(intent)
            bindService(intent, this, Context.BIND_AUTO_CREATE)
        }
    }


    companion object {
        const val KEY_DESTINATION = "destination"
        private const val TAG = "MainActivity"
        private const val REFRESH_STEP_WHAT = 0
        const val DESTINATION_PLAYING_PAGE = "action_playing_page"

    }

    private lateinit var playerChannel: QuietPlayerChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        PluginRegistrant.registerWith(this)
        playerChannel = QuietPlayerChannel.registerWith(registrarFor("cn.gov.gaj.phms.v3.service.QuietPlayerChannel"))
        route(intent)
        log { "服务Service准备" }
        //初始化计步模块
        TodayStepManager.startTodayStepService(application)
        //开启计步Service，同时绑定Activity进行aidl通信
        val intent = Intent(this, TodayStepService::class.java)
        startService(intent)
        bindService(intent, mServiceConnection, Context.BIND_AUTO_CREATE)
    }

    internal inner class TodayStepCounterCall:Handler.Callback {
        override fun handleMessage(msg:Message):Boolean {
            when (msg.what) {
                REFRESH_STEP_WHAT -> {
                    //每隔500毫秒获取一次计步数据刷新UI
                    if (null != iSportStepInterface)
                    {
                        var step = 0
                        try
                        {
                            step = iSportStepInterface.getCurrentTimeSportStep()
                        }
                        catch (e:RemoteException) {
                            e.printStackTrace()
                        }
                        if (mStepSum != step)
                        {
                            mStepSum = step
                            log { "获取步数$mStepSum" }
                            updateStepCount()
                        }
                    }
                    mDelayHandler.sendEmptyMessageDelayed(REFRESH_STEP_WHAT, TIME_INTERVAL_REFRESH)
                }
            }
            return false
        }
    }

    private fun updateStepCount() {
        playerChannel.count = mStepSum
    }

    override fun onDestroy() {
        playerChannel.destroy()
        val intent = Intent(this, TodayStepService::class.java)
        startService(intent)
        bindService(intent, mServiceConnection, Context.BIND_AUTO_CREATE)
        super.onDestroy()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        route(intent)
    }

    private fun route(intent: Intent) {
        when (intent.getStringExtra(KEY_DESTINATION)) {
            DESTINATION_PLAYING_PAGE -> {
                flutterView.pushRoute("/playing")
            }
        }
    }
}
