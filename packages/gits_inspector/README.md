# Gits Inspector

Gits Inspector is a simple in-app for Gits HTTP inspector. Gits Inspector intercepts and persists all HTTP requests and responses inside your application, and provides a UI for inspecting their content. It is inspired from [Alice](https://pub.dev/packages?q=alice), [Chuck](https://github.com/jgilfelt/chuck) and [Chucker](https://github.com/ChuckerTeam/chucker).

## Supported

- [Gits HTTP](https://pub.dev/packages/gits_http)

## Feature

- Detailed logs for each HTTP calls (HTTP Request, HTTP Response)
- Inspector UI for viewing HTTP calls
- Save HTTP calls to Sqflite
- Notification on HTTP call
- Support for top used HTTP clients in Dart
- Shake to open inspector
- HTTP calls search

## How to Usage

```dart
locator.registerLazySingleton(
    () => GitsInspector(
      showNotification: true, // default true
      showInspectorOnShake: true, // default true
      saveInspectorToLocal: true, // default true
      notificationIcon: '@mipmap/ic_launcher', // default '@mipmap/ic_launcher' just for android
    ),
  );
  locator.registerLazySingleton(
    () => GitsHttp(
      timeout: 30000,
      showLog: true,
      gitsInspector: locator(), // add this for activate inspector in Gits HTTP
    ),
  );
```

to help navigate without context to the gits inspector page it is necessary to setup the navigator state with the method `setNavigatorState(Navigator.of(context))` and is recommended on start pages like `SplashPage`.

```dart
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    locator<GitsInspector>().setNavigatorState(Navigator.of(context)); // add this to navigate from local notification or on shake 
    ...
  }
  ...
}
```
