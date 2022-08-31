import 'dart:developer';

import 'package:example/mapper.dart';
import 'package:example/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:gits_http/gits_http.dart';
import 'package:gits_strapi/gits_strapi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final GitsStrapi strapi = GitsStrapi(
      timeout: 30000,
      showLog: true,
      gitsInspector: GitsInspector(),
    );

    AuthResponse loginResponse = await strapi.login(
        endpoint: Uri.parse("http://10.0.2.2:1337/api/auth/local"),
        body: {"identifier": "test@gits.id", "password": "12345678"});
    log("LoginResponse : $loginResponse");

    AuthEntity loginEntity = loginResponse.toEntity();
    log("LoginEntity : $loginEntity");

    AuthResponse registerResponse = await strapi.register(
        endpoint: Uri.parse("http://10.0.2.2:1337/api/auth/local/register"),
        body: {
          "username": "akukamu",
          "email": "akukamu@gmail.com",
          "password": "12345678"
        });
    log("RegisterResponse : $registerResponse");

    AuthEntity registerEntity = registerResponse.toEntity();
    log("RegisterhEntity : $registerEntity");

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

    log("SingleResponse : $singleResponse");
    var singleEntity = singleResponse.toEntity((data) => (data as DataResponse)
        .toEntity((attr) => (attr as ProductResponse).toEntity()));
    log("SingleEntity : $singleEntity");

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
    log("CollectionResponse : $collectionResponse");

    var collectionEntity = collectionResponse.toEntity(
      (data) => data
          .map((item) => (item as DataResponse)
              .toEntity((attr) => (attr as ProductResponse).toEntity()))
          .toList(),
    );
    log("CollectionEntity : $collectionEntity");

    Response select = await strapi.select(endpoint: Uri.parse("endpoint"));
    log("SelectResponse : ${select.body}");

    var insertBody = {
      "data": {
        "name": "test",
        "description": "test description",
        "price": 10000,
        "stock": 5,
      }
    };
    Response insert = await strapi.create(
        endpoint: Uri.parse("http://10.0.2.2:1337/api/products"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjYxMjM2OTgwLCJleHAiOjE2NjM4Mjg5ODB9.Cb-wP8EUPUcwp76VD_IWqsw5nvi9xv0QqH0Ng4EB1UI'
        },
        body: insertBody);
    log("CreateResponse : ${insert.body}");

    var updateBody = {
      "data": {
        "name": "test1",
        "description": "test description1",
        "price": 50000,
        "stock": 3,
      }
    };
    Response updateResponse = await strapi.update(
        id: "1",
        endpoint: Uri.parse("http://10.0.2.2:1337/api/products"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjYxMjM2OTgwLCJleHAiOjE2NjM4Mjg5ODB9.Cb-wP8EUPUcwp76VD_IWqsw5nvi9xv0QqH0Ng4EB1UI'
        },
        body: updateBody);
    log("UpdateResponse : ${updateResponse.body}");

    Response deleteResponse = await strapi.delete(headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjYxMjM2OTgwLCJleHAiOjE2NjM4Mjg5ODB9.Cb-wP8EUPUcwp76VD_IWqsw5nvi9xv0QqH0Ng4EB1UI'
    }, endpoint: Uri.parse("http://10.0.2.2:1337/api/products"), id: "9");
    log("DeleteResponse : ${deleteResponse.body}");
  } on GitsException catch (e) {
    log("GitsException : $e");
  } catch (e) {
    log("Error : $e");
  }
}
