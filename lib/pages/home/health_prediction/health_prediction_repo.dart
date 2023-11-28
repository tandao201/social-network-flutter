import 'dart:convert';

import 'package:chat_app_flutter/models/health_prediction/issue_entity.dart';
import 'package:chat_app_flutter/models/health_prediction/symptom_disease_entity.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../../../base/base_repo.dart';
import '../../../models/health_prediction/diagnosis_entity.dart';
import '../../../utils/shared/constants.dart';

class HealthPredictionRepo extends BaseRepo {
  Future loginApi() async {
    var key = utf8.encode(Constants.healthPassword);
    var bytes = utf8.encode(Constants.healthLoginApi);

    var hmacMd5 = Hmac(md5, key); // HMAC-MD5
    var digest = hmacMd5.convert(bytes);
    Map<String, dynamic> headers = {
      "Bearer ${Constants.healthUsername}" : digest.toString()
    };

    try {
      Response response = await requestSpecificUrl(
        url: "${Constants.healthLoginApi}${Constants.loginHealthApi}",
        method: Method.POST,
        headers: headers
      );
      print('Data: ${response.data}');
      return response.data;
    } catch (e) {
      print('Request failed: ${e.toString()}');
    }
  }

  Future symptomSearch({required Map<String, dynamic> body}) async {
    SymptomListResponse? symptomDiseaseEntity;
    try {
      Response response = await requestSpecificUrl(
          url: "${Constants.healthPredictionApi}${Constants.symptomSearch}",
          method: Method.GET,
          params: body,
      );
      symptomDiseaseEntity = SymptomListResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: ${e.toString()}');
    }
    return symptomDiseaseEntity;
  }

  Future predictHealth({required Map<String, dynamic> body}) async {
    DiagnosisListResponse? diagnosisListResponse;
    try {
      Response response = await requestSpecificUrl(
        url: "${Constants.healthPredictionApi}${Constants.diseasePrediction(body)}",
        method: Method.GET,
        // params: body,
      );
      diagnosisListResponse = DiagnosisListResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: ${e.toString()}');
    }
    return diagnosisListResponse;
  }

  Future issueInfo({required Map<String, dynamic> body, required int issueId}) async {
    IssueEntity? issueEntity;
    try {
      Response response = await requestSpecificUrl(
          url: "${Constants.healthPredictionApi}${Constants.issueInfo(issueId)}",
          method: Method.GET,
          params: body,
      );
      issueEntity = IssueEntity.fromJson(response.data);
    } catch (e) {
      print('Request failed: ${e.toString()}');
    }
    return issueEntity;
  }
}