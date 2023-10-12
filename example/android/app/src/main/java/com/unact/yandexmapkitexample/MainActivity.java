package com.unact.yandexmapkitexample;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import com.yandex.mapkit.MapKitFactory;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    MapKitFactory.setLocale("ru_RU");
    MapKitFactory.setApiKey("213d860b-5ed1-45f4-a61a-16f226a5113d");
    super.configureFlutterEngine(flutterEngine);
  }
}
