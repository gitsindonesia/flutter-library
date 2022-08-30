<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
<div align="center">
<img src="https://www.gits.co.id/img/logo.png" height="100" alt="Gits Strapi" />
<p>This package is used to make it easier when you want to integrate with the strapi</p>
</div>

# Gits Strapi

<h2><a>#</a> Prerequisites</h2>

This library uses the [gits_http](https://pub.dev/packages/gits_http) package

<h2><a>#</a> Yout must know</h2>

<p>Requests return a response as an object which usually includes the following keys:</p>
<ul><li><p><code>data</code>: the response data itself, which could be:</p> <ul><li>a single entry, as an object with the following keys:
<ul><li><code>id</code> (number)</li> <li><code>attributes</code> (object)</li> <li><code>meta</code> (object)</li></ul></li> <li>a list of entries, as an array of objects</li> <li>a custom response</li></ul></li> <li><p><code>meta</code> (object): information about pagination, publication state, available locales, etc.</p></li> <li><p><code>error</code> (object, <em>optional</em>): information about any <a href="/developer-docs/latest/developer-resources/error-handling.html" class="">error</a> thrown by the request</p></li></ul>

<h2><a>#</a> Usage</h2>

First of all, initialize the gits_strapi in this way

```dart
 final GitsStrapi strapi = GitsStrapi(
      timeout: 30000,
      showLog: true,
      gitsInspector: GitsInspector(),
    );
```

after that we can use some main functions like

### Auth Login

Used for standard strapi login needs, if there is a need beyond that then use another function

```dart
AuthResponse loginResponse = await strapi.login(
        endpoint: Uri.parse("http://10.0.2.2:1337/api/auth/local"),
        body: {"identifier": "identifier", "password": "password"});
```

### Auth Register

Used for standard strapi register needs, if there is a need beyond that then use another function

```dart
AuthResponse registerResponse = await strapi.register(
        endpoint: Uri.parse("http://10.0.2.2:1337/api/auth/local/register"),
        body: {
          "username": "username",
          "email": "email",
          "password": "password"
        });
```

### Get Single Response

Used to retrieve data for a single object, if you need to retrieve a lot of data use `Get Collection Response`

```dart
 Uri endpointProductOne =
        Uri.parse("http://10.0.2.2:1337/api/products/1").withParam(
      const StrapiRequest(
        populate: ["images"],
      ),
    );

    SingleResponse<DataResponse<ProductResponse>> singleResponse =
        await strapi.getSingle(endpoint: endpointProductOne).then((value) {
      var attr = ProductResponse.fromMap(value.data?.attributes);
      var data = DataResponse(id: value.data?.id, attributes: attr);
      return SingleResponse(data: data, meta: value.meta, error: value.error);
    });
```

### Get Collection Response

Used to retrieve data based on a list of objects, if necessary retrieve single object data `Get Single Response`

```dart
 Uri endpointProducts = Uri.parse("http://10.0.2.2:1337/api/products")
        .withParam(
            const StrapiRequest(page: 1, pageSize: 3, sort: ['id:desc']));

    CollectionResponse<DataResponse<ProductResponse>> collectionResponse =
        await strapi.getCollection(endpoint: endpointProducts).then((value) {
      var data = <DataResponse<ProductResponse>>[];
      value.data?.forEach((item) {
        data.add(
          DataResponse(
            id: item.id,
            attributes: ProductResponse.fromMap(item.attributes),
          ),
        );
      });
      return CollectionResponse(
          data: data, meta: value.meta, error: value.error);
    });
```

### (Get) Select

Used for `GET` method requirements

```dart
Response select = await strapi.select(endpoint: Uri.parse("endpoint"));
```

### (POST) Create

Used for `POST` method requirements

```dart
var insertBody = {
      "data": {
        "name": "name",
        "description": "description",
        "price": 10000,
        "stock": 5,
      }
    };
    Response insert = await strapi.create(
        endpoint: Uri.parse("http://10.0.2.2:1337/api/products"),
        headers: {
          'Authorization':
              'Bearer eyJhxdcfOgJwUwI1NiIsInR5cCI6IkpXVCJ9.eyJaZcIvMiwfaWF0IjoxNjYxMjM2OTgwLCJleHAiOjE2NjM4Mjg5ODB9.Cb-wP8EUPUcwp76VD_IWqsw5nvi9xv0QqH0Ng4EB1UI'
        },
        body: insertBody);
```

### (PUT) Update

Used for `PUT` method requirements

```dart
var updateBody = {
      "data": {
        "name": "name",
        "description": "description",
        "price": 50000,
        "stock": 3,
      }
    };
    Response updateResponse = await strapi.update(
        id: "1",
        endpoint: Uri.parse("http://10.0.2.2:1337/api/products"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIazIwdivsPnRKDCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjYxMjM2OTUCLVJleHAiOjE2NjM4Mjg5ODB9.Cb-wP8EUPUcwp76VD_IWqsw5nvi9xv0QqH0Ng4EB1UI'
        },
        body: updateBody)
```

### Delete

Used for `DELETE` method requirement

```dart
 Response deleteResponse = await strapi.delete(headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInCX5FCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjYxMjM2OTgwLCJleHA_1OjE2NjM4Mjg5ODB9.Cb-wP8EUPUcwp76VD_IWWsC5GFvi9xv0QqH0Ng4EB1UI'
    }, endpoint: Uri.parse("http://10.0.2.2:1337/api/products"), id: "9");
```

<h2><a>#</a> Helper</h2>

### Strapi Request

we have provided some required parameter requests such as:

<ul>
<li>populate `List<String>`</li>
<li>fields `List<String>`</li>
<li>sort `List<String>`</li>
<li>withCount `bool`</li>
<li>pageSize `pageSize`</li>
<li>page `page`</li>
</ul>

for an example like this

```dart
    StrapiRequest(
      fields: ['id','name'],
      populate: ['images','transactions'],
      sort: ['id:desc'],
      page: 1,
      pageSize: 10,
      withCount: true,
    );
```

### Entity Mapper

As for the need to convert Response to `Entity` which has been provided for some `Base Response` below:

<ul>
<li>SingleResponse</li>
<li>CollectionResponse</li>
<li>DataResponse</li>
<li>MetaResponse</li>
<li>PaginationResponse</li>
<li>ErrorResponse</li>
<li>AuthResponse</li>
<li>UserResponse</li>
<li>ThumbnailResponse</li>
<li>FormatsResponse</li>
<li>ImageResponse</li>
</ul>

how to use it like this for responses which have generic class

```dart
var collectionEntity = collectionResponse.toEntity(
      (data) => data
          .map((item) => (item as DataResponse)
              .toEntity((attr) => (attr as ProductResponse).toEntity()))
          .toList(),
    );
```

if it doesn't have a generic class

```dart
    ProductResponse().toEntity();
```

### Additional information

For additional information we have several main response bases that will be used frequently

<ul>
<li>SingleResponse : to handle response {"data (single object)","meta","error"}</li>
<li>CollectionResponse : to handle response {"data (is an array object)","meta","error"}</li>
<li>DataResponse : to handle response {"id","attributes"}</li>
</ul>
