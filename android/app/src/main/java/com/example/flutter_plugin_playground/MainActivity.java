package com.example.flutter_plugin_playground;

import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private EventChannel channel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    // Prepare channel
    channel = new EventChannel(getFlutterView(), "events");
    channel.setStreamHandler(new EventChannel.StreamHandler() {
      @Override
      public void onListen(Object listener, EventChannel.EventSink eventSink) {
        startListening(listener, eventSink);
      }

      @Override
      public void onCancel(Object listener) {
        cancelListening(listener);
      }
    });
  }

  // Listeners
  private Map<Object, Runnable> listeners = new HashMap<>();

  void startListening(Object listener, EventChannel.EventSink emitter) {
    // Prepare a timer like self calling task
    final Handler handler = new Handler();
    listeners.put(listener, new Runnable() {
      @Override
      public void run() {
        if (listeners.containsKey(listener)) {
          // Send some value to callback
          emitter.success("Hello listener! " + (System.currentTimeMillis() / 1000));
          handler.postDelayed(this, 1000);
        }
      }
    });

    // Run task
    handler.postDelayed(listeners.get(listener), 1000);
  }

  void cancelListening(Object listener) {
    // Remove callback
    listeners.remove(listener);
    Log.d("Diego", "Count: " + listeners.size());
  }
}
