import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wine_app/model/get_bottles.dart';
import 'constants.dart';
import 'model/get_cellars.dart';

class ApiService {
  Future<Cellars> getCellars() async {
    debugPrint('getCellars');

    Response response = await get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getCellarsEndpoint),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        });

    if (response.statusCode == 200) {
      Cellars model = cellarsFromJson(response.body.toString());
      debugPrint(model.toString());
      return model;
    }

    throw Exception('Failed to load Cellars');
  }

  Future<Bottles> getBottles() async {
    debugPrint('getBottles');

    Response response = await get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getBottlesEndpoint}?exists%5BemptyAt%5D=false'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        });

    if (response.statusCode == 200) {
      Bottles model = bottlesFromJson(response.body.toString());
      debugPrint(model.toString());
      return model;
    }

    throw Exception('Failed to load Bottles');
  }

  Future<Bottles> getBottlesLiked() async {
    debugPrint('getBottlesLiked');

    Response response = await get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getBottlesLikedEndpoint),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        });

    if (response.statusCode == 200) {
      Bottles model = bottlesFromJson(response.body.toString());
      debugPrint(model.toString());
      return model;
    }

    throw Exception('Failed to load Bottles');
  }

  void putBottlesLiked(int bottleId, bool value) async {
    debugPrint('putBottlesLiked');
    debugPrint('$value');

    Map body = {'isLiked': value};

    put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getBottlesEndpoint}/$bottleId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        },
        body: json.encode(body));
  }

  void putCellarsActive(int cellarId, bool value) async {
    debugPrint('putCellarsActive');
    debugPrint('$value');

    Map body = {'isActive': value};

    put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getCellarsEndpoint}/$cellarId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        },
        body: json.encode(body));
  }
}
