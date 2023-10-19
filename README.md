# System Back Confirmation

A Flutter plugin to avoid accidentally killing Flutter apps on Android.

## Getting Started

To get started, add the plugin to your pubspec.yaml dependencies and add `SystemBackConfirmation` to your MaterialApp, CupertinoApp, or WidgetsApp builder:
```dart
MaterialApp(
  builder: (context, child) => SystemBackConfirmation(
    child: child!,
  ),
  home: MyApp(),
);
```

## Android 12 and later

Android 12 changed the default system back gesture behaviour to keep the app's activity alive if it was started from the launcher. This plugin automatically adjusts it's behavour to enable/disable back confirmation based on the Android version and activity state.

For more information on the changes in Android 12, see: https://developer.android.com/about/versions/12/behavior-changes-all#back-press
