import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wine_app/model/get_bottle.dart';
import 'package:wine_app/model/get_bottles.dart';
import 'package:http/http.dart';
import 'constants.dart';
import 'model/get_cellars.dart';
import 'globals.dart' as globals;

class ApiService {
  static const String token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjE5NjAzMDYsImV4cCI6MTY2MjU2NTEwNiwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.JCPXOd3FbMrw9rb-6jak-DQYJU1aTSdX3EslgCLs4xTZ82ux2igf9eH95xWtQKlhFxNAET4tG9MduwH3KAsjhwKmxN8iMjgms5hcfgUsRFr0_BZo0-Yl0RcRMj5BsgoxtKGpu5wiuSJa0CWwihJSFVkUUp740yZYQ9PmeAXWJ6fSiPP4eGFj4kVUtP9wBfZMW_be96UM3OfhboJe6fMv4GqGXi_xYbOJm9zx4JVTfGSz6ZR4NT3k74_s0u1iNUQKyCDX_-sZmCMWO3hEE6jt3Yu_0joc67vlPrPNMRvPrRjfRht7RV7qvmwZLAkRBJ4YOwAIOYRoIe5o5vcgVoHSPw';

  Future<Cellars> getCellars() async {
    debugPrint('GET ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}');

    Response response = await get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cellarsEndpoint),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        });

    if (response.statusCode == 200) {
      Cellars model = cellarsFromJson(response.body.toString());
      return model;
    }

    throw Exception('Failed to load Cellars');
  }

  Future<Bottles> getBottles() async {
    String cellarIsActive = '&cellar.isActive=true';
    if (globals.cellarActiveId != 0) {
      cellarIsActive = '&cellar.id=${globals.cellarActiveId}';
    }

    debugPrint(
        'GET ${ApiConstants.baseUrl}${ApiConstants.bottlesEndpoint}?exists%5BemptyAt%5D=false$cellarIsActive');

    Response response = await get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.bottlesEndpoint}?exists%5BemptyAt%5D=false$cellarIsActive'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        });

    if (response.statusCode == 200) {
      Bottles model = bottlesFromJson(response.body.toString());
      return model;
    }

    throw Exception('Failed to load Bottles');
  }

  Future<Bottle> getBottle(int bottleId) async {
    debugPrint(
        'GET ${ApiConstants.baseUrl}${ApiConstants.bottlesEndpoint}/$bottleId');

    Response response = await get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.bottlesEndpoint}/$bottleId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        });

    if (response.statusCode == 200) {
      Bottle model = bottleFromJson(response.body.toString());
      debugPrint(model.toString());
      return model;
    }

    throw Exception('Failed to load Bottles');
  }

  Future<Bottles> getBottlesLiked() async {
    String cellarIsActive = '&cellar.isActive=true';
    if (globals.cellarActiveId != 0) {
      cellarIsActive = '&cellar.id=${globals.cellarActiveId}';
    }

    debugPrint(
        'GET ${ApiConstants.baseUrl}${ApiConstants.getBottlesLikedEndpoint}$cellarIsActive');

    Response response = await get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getBottlesLikedEndpoint}$cellarIsActive'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        });

    if (response.statusCode == 200) {
      Bottles model = bottlesFromJson(response.body.toString());
      return model;
    }

    throw Exception('Failed to load Bottles');
  }

  void putBottlesLiked(int bottleId, bool value) async {
    Map body = {'isLiked': value};

    debugPrint(
        'PUT ${ApiConstants.baseUrl}${ApiConstants.bottlesEndpoint}/$bottleId');
    debugPrint(json.encode(body));

    put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.bottlesEndpoint}/$bottleId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        },
        body: json.encode(body));
  }

  void putCellarsActive(int cellarId, bool value) async {
    Map body = {'isActive': value};

    debugPrint(
        'PUT ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId');
    debugPrint(json.encode(body));

    globals.cellarActiveId = cellarId;

    put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        },
        body: json.encode(body));
  }

  Future<bool> putCellar(int cellarId, String name, int column, int row) async {
    Map body = {'name': name.trim(), 'row': row, 'clmn': column};

    debugPrint(
        'PUT ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId');
    debugPrint(json.encode(body));

    Response response = await put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        },
        body: json.encode(body));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> deleteCellar(int cellarId) async {
    debugPrint(
        'DELETE ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId');

    Response response = await delete(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        });

    if (response.statusCode == 204) {
      globals.cellarActiveId = 0;
      return true;
    }

    return false;
  }

  Future<bool> postCellar(String name, int column, int row) async {
    Map body = {'name': name, 'row': row, 'clmn': column, 'isActive': false};

    debugPrint('POST ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}');
    debugPrint(json.encode(body));

    Response response = await post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        },
        body: json.encode(body));

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }
}
