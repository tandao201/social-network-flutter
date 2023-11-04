import 'package:chat_app_flutter/models/health_prediction/symptom_disease_entity.dart';
import 'package:dio/dio.dart';

import '../../../base/base_repo.dart';
import '../../../utils/shared/constants.dart';

class HealthPredictionRepo extends BaseRepo {
  Future symptomSearch({required Map<String, dynamic> bodyData}) async {
    SymptomDiseaseEntity? symptomDiseaseEntity;
    try {
      Response response = await requestSpecificUrl(
          url: "${Constants.healthPredictionApi}${Constants.symptomSearch}",
          method: Method.GET,
          params: bodyData,
          headers: Constants.predictionApiHeader
      );
      symptomDiseaseEntity = SymptomDiseaseEntity.fromJson(response.data);
    } catch (e) {
      print('Request failed: ${e.toString()}');
    }
    return symptomDiseaseEntity;
  }

  Future frequentSymptomSearch({required Map<String, dynamic> bodyData}) async {
    SymptomDiseaseEntity? symptomDiseaseEntity;
    try {
      Response response = await requestSpecificUrl(
          url: "${Constants.healthPredictionApi}${Constants.symptomSearch}",
          method: Method.GET,
          params: bodyData,
          headers: Constants.predictionApiHeader
      );
      symptomDiseaseEntity = SymptomDiseaseEntity.fromJson(response.data);
    } catch (e) {
      print('Request failed: ${e.toString()}');
    }
    return symptomDiseaseEntity;
  }
}