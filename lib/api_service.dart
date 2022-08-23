import 'dart:async';

import 'package:http/http.dart';
import 'constants.dart';
import 'model/cellar_model.dart';

class ApiService {
  Future<GetCellars?> getCellars() async {
    Response response = await get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getCellarsEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NjExNzU2MTEsImV4cCI6MTY2MTc4MDQxMSwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImNsZW1lbnRAZ21haWwuY29tIn0.5c_DnXJ4sm0ZvBjqBGBOGKwVFo1cXlPmJZvg4YIfrKt3wXHLd-Z4Gy8Qju-2r-fMbn6DpsUONVDp8dK2gQk1cRfojzZnu7_Y4_zki0VNFii89lXHebKKHeRZxILNxPGxxndREA_AIJg2Ybk3b9iKL2bbXv3adHQ0bMXEmzPf50S7AJ_Hj03zqmal7cO18tFattpuBQUm2X-70-J_pKkaRu69DfBQR7wAlg6DX5aZRl6S2jGtDXlmpAHMk5W8GjepOJkV_3SnNi4PiK4rKqSnurrLd5cuA1UNhJwx1rkQg7_80Ote8zSEfE2dYZUXLeW9GqpFQrqkUte5RJSCRAFHBA'
        });

    if (response.statusCode == 200) {
      GetCellars model = getCellarsFromJson(response.body);
      return model;
    }

    return null;
  }
}
