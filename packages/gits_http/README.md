# Gits HTTP

Gits HTTP uses the [http](https://pub.dev/packages/http) library which has been modified as needed. first we store `GitsHttp` into `locator`. `locator` is the service locator from [get_it](https://pub.dev/packages/get_it).

```dart
final locator = GetIt.instance;

locator.registerLazySingleton(
    () => GitsHttp(
      timeout: 30000,
      showLog: true,
      gitsInspector: locator(), // this for activate GitsInspector
      headers: {}, // you can add headers
    ),
  );
```

and to enable http inspector need to add dependency [gits_inspector](https://pub.dev/packages/gits_inspector) and put in `locator`.

```dart
locator.registerLazySingleton(
    () => GitsInspector(
      showNotification: true, // default true
      showInspectorOnShake: true, // default true
      saveInspectorToLocal: true, // default true
      notificationIcon: '@mipmap/ic_launcher', // default '@mipmap/ic_launcher' just for android
    ),
  );
```

## Token

To set the token, it is done after authorization and getting the token. the token is stored to local and setup on `GitsHttp`.

```dart
final GitsHttp http = locator();
final String token = getToken();
...
http.setToken(token, key: 'Authorization', prefixValue: 'Bearer');
```

After we set the token, every API call will add an `Authorization` header with a default value of `Bearer $token`.

## Get

```dart
final GitsHttp http = locator();

final response = await http.get(Uri.parse('https://api.gits.id'), body: body.toMap());
```

## Post

```dart
final GitsHttp http = locator();

final response = await http.post(Uri.parse('https://api.gits.id'), body: body.toMap());
```

## Put

```dart
final GitsHttp http = locator();

final response = await http.put(Uri.parse('https://api.gits.id'), body: body.toMap());
```

## Patch

```dart
final GitsHttp http = locator();

final response = await http.patch(Uri.parse('https://api.gits.id'), body: body.toMap());
```

## Delete

```dart
final GitsHttp http = locator();

final response = await http.delete(Uri.parse('https://api.gits.id'), body: body.toMap());
```

## Post Multipart

```dart
final GitsHttp http = locator();
final File file = getImage();

final response = await http.postMultipart(Uri.parse('https://api.gits.id'), files: {'image': file}, body: body.toMap());
```
