import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wine_app/model/get_bottles.dart';
import 'package:http/http.dart';
import 'constants.dart';
import 'model/get_cellars.dart';
import 'globals.dart' as globals;

class ApiService {
  static const String token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjE3ODA0NjgsImV4cCI6MTY2MjM4NTI2OCwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.Fi3khf_oMyNAntGNoXbO3Fl2AfuTJ67MChMjtrnZPQJMPV_Wq9bpSo_cEo_MFX8e39wX_ZA7zPF1IF7SlJffACeHSuyprOLi0QFabg0FQ7pbTdfLHSNREX7E4Duguay3wIhi39-Ng3LfkkwqJLrOMEffkRDfUR4EmPtJEdzFRTeAKG1G1gRGyJo1pAOmPEi-FpmHqJr4tyJab5PjPSk2Fc1kvoM75qvMUg9P13wLUTDGtNbxyFQRTpEDycniKoGws5ym9AUUpc4MPxrGfzS-VlfxFcJzW_-HpUsvlWgkNYYd401LMD4ZHVlVJM8fCd9adSaSNIfPD-z7HUGcibdQhQ';

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

  void putCellar(int cellarId, String name, int column, int row) async {
    Map body = {'name': name.trim(), 'row': row, 'clmn': column};

    debugPrint(
        'PUT ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId');
    debugPrint(json.encode(body));

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

  void deleteCellar(int cellarId) async {
    debugPrint(
        'DELETE ${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId');

    delete(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cellarsEndpoint}/$cellarId'),
        headers: {
          'Content-Type': 'application/ld+json',
          'Accept': 'application/ld+json',
          'Authorization': token
        });
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

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
