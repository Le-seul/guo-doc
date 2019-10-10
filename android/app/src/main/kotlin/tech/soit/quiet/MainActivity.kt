package cn.gov.gaj.phms.v3

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import cn.gov.gaj.phms.v3.plugin.PluginRegistrant
import cn.gov.gaj.phms.v3.service.QuietPlayerChannel

class MainActivity : FlutterActivity() {

    companion object {


        const val KEY_DESTINATION = "destination"

        const val DESTINATION_PLAYING_PAGE = "action_playing_page"

    }

    private lateinit var playerChannel: QuietPlayerChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        PluginRegistrant.registerWith(this)
        playerChannel = QuietPlayerChannel.registerWith(registrarFor("cn.gov.gaj.phms.v3.service.QuietPlayerChannel"))
        route(intent)
    }

    override fun onDestroy() {
        playerChannel.destroy()
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
