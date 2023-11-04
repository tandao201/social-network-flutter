import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/health_prediction/health_prediction_repo.dart';

import '../../../models/health_prediction/symptom_disease_entity.dart';

class HealthPredictionCtl extends BaseCtl<HealthPredictionRepo> {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    symptomSearch();
  }

  Future symptomSearch() async {
    try {
      Map<String, dynamic> bodyData = {
        "period": '1m',
        "birth_sex": 'UNK',
        "specialization": 'general_practitioner',
        "age": '27'
      };
      SymptomDiseaseEntity? symptomDiseaseEntity = await api.frequentSymptomSearch(bodyData: bodyData);
      print('${symptomDiseaseEntity?.toJson()}');
    } catch (e) {
      isLoading.value = false;
      print('Exception');
    }
  }
}