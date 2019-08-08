package com.example.dlt_app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String BATTERY_CHANNEL = "samples.flutter.dev/battery";
  private static final String CHARGING_CHANNEL = "samples.flutter.dev/charging";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), BATTERY_CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                      if (call.method.equals("getBatteryLevel")){
                        //模拟数据 
                        result.success(90);
                        // result.error("UNAVAILABLE", "Battery level not available.", null);
                      }
                    }
                });

                new EventChannel(getFlutterView(), CHARGING_CHANNEL).setStreamHandler(
                  new StreamHandler() {
                    private BroadcastReceiver chargingStateChangeReceiver;
                    @Override
                    public void onListen(Object arguments, EventSink events) {
                      chargingStateChangeReceiver = createChargingStateChangeReceiver(events);
                      registerReceiver(
                          chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
                    }
          
                    @Override
                    public void onCancel(Object arguments) {
                      unregisterReceiver(chargingStateChangeReceiver);
                      chargingStateChangeReceiver = null;
                    }
                  }
              );                
  }
}
