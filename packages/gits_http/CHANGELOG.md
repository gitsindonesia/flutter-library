## 3.1.1

- build: upgrade dependency gits_inspector to ^3.2.1

## 3.1.0

- build: upgrade dependency http to ^1.1.2
- build: uuid dependency http to ^4.3.1
- build: gits_inspector dependency http to ^3.2.0
- build: flutter_lint dependency http to ^3.0.1

## 3.0.2

- build: upgrade dependency http to ^1.1.0
- build: upgrade dependency logger to ^2.0.1
- build: upgrade dependency path_provider to ^2.1.0

## 3.0.1

- fix: remove final class for GitsHttp

## 3.0.0

- feat!: Requires Dart 3.0 or later.
- build: bump version dependencies http to 1.0.0
- chore: support dart 3.0.0 and flutter 3.10.0

## 2.0.6

- build: bump version dependencies

## 2.0.5

- fix add write to cache with strategy async_or_cache or cache_or_async

## 2.0.4

- fix write to cache when status code success

## 2.0.3

- fix key hashcode for cache strategy

## 2.0.2

- fix key for cache strategy
- add clearCache method in GitsHttp

## 2.0.1

- fix key for cache strategy

## 2.0.0

- stable version with add cache strategy
- add equatable for each strategy

## 2.0.0-dev.3

- fix fromMap for headers Map in cache wrapper

## 2.0.0-dev.2

- fix simply key for write to storage
- fix cache wrapper add status_code in toMap

## 2.0.0-dev.1

- fix hive init

## 2.0.0-dev

- add cache strategy (AsyncOrCacheStrategy, CacheOrAsyncStrategy, JustAsyncStrategy, JustCacheStrategy), default JustAsyncStrategy
- remove head method in GitsHttp
- remove read method in GitsHttp
- remove readBytes method in GitsHttp

## 1.1.3

- update dependency gits_inspector to 2.0.1

## 1.1.2

- add await call middleware response

## 1.1.1

- export middleware response option

## 1.1.0

- add exception for no internet connection
- add middle response option

## 1.0.0

- update package gits_inspector to 2.0.0
- fix auth token option to exclude url

## 0.3.4

- fix equality either for support type List

## 0.3.3

- update package http to 0.13.5
- update package equatable to 2.0.5
- update package gits_inspector to 1.0.1

## 0.3.2

- remove abstract class status_code_name.dart
- refactor gits exceptions include status_code_name
- refactor gits failure include statusCode and jsonBody

## 0.3.1

- fix export gits_inspector just show GitsInspector class

## 0.3.0

- update dependency gits_inspector
- export gits_inspector
- fix request body with nested map

## 0.2.1

- add dartdoc
- add example

## 0.2.0

- add auth token option
- add refresh token option
- remove setToken from gits_http.dart

## 0.1.0

- add documentation in readme.
- add authors.
- fix link repository.

## 0.0.1

- Initial Open Source release.
