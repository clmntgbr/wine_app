import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wine_app/model/get_bottles.dart';
import 'constants.dart';
import 'model/get_cellars.dart';
import 'globals.dart' as globals;

class ApiService {
  Future<Cellars> getCellars() async {
    debugPrint('GET${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}');

    Response response = await get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cellarsEndpoint),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
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
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        });

    if (response.statusCode == 200) {
      Bottles model = bottlesFromJson(response.body.toString());
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
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
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
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
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
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        },
        body: json.encode(body));
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
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        },
        body: json.encode(body));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
