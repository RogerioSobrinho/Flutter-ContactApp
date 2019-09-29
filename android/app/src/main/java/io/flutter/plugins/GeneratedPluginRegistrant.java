package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.pichillilorenzo.flutter_appavailability.AppAvailability;
import flutterlaunch.thyagoluciano.com.flutter_launch.FlutterLaunchPlugin;
import io.flutter.plugins.share.SharePlugin;
import com.tekartik.sqflite.SqflitePlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AppAvailability.registerWith(registry.registrarFor("com.pichillilorenzo.flutter_appavailability.AppAvailability"));
    FlutterLaunchPlugin.registerWith(registry.registrarFor("flutterlaunch.thyagoluciano.com.flutter_launch.FlutterLaunchPlugin"));
    SharePlugin.registerWith(registry.registrarFor("io.flutter.plugins.share.SharePlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
