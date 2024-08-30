package apps.sureapps.audiostreams_flutter;

import androidx.annotation.NonNull;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
// import io.flutter.plugins.GeneratedPluginRegistrant;
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
// import com.tekartik.sqflite.SqflitePlugin;


public class Application extends FlutterApplication implements PluginRegistrantCallback {

    @Override
    public void onCreate() {
        super.onCreate();
        //FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        //FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
        // GeneratedPluginRegistrant.registerWith(registry);
        // SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    }

}