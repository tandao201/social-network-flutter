import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/health_prediction/issue_entity.dart';
import 'package:chat_app_flutter/pages/home/health_prediction/health_prediction_repo.dart';
import 'package:chat_app_flutter/utils/extensions/string_extension.dart';
import 'package:chat_app_flutter/utils/shared/enums.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:translator/translator.dart';

import '../../../models/commons/health_entity.dart';
import '../../../models/health_prediction/diagnosis_entity.dart';
import '../../../models/health_prediction/symptom_disease_entity.dart';
import 'items/issue_detail_widget.dart';

class HealthPredictionCtl extends BaseCtl<HealthPredictionRepo> {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  RxList<SymptomDiseaseEntity> symptoms = <SymptomDiseaseEntity>[].obs;
  RxList<DiagnosisEntity> predictionsList = <DiagnosisEntity>[].obs;
  RxList<int> selectedSymptoms = <int>[].obs;
  HealthEntity? healthEntity;
  Rx<Gender> gender = Gender.male.obs;
  Rx<IssueEntity> issueEntity = IssueEntity().obs;
  RxBool isLoadingIssue = false.obs;
  RxBool isLoadingPredict = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    healthEntity = globalController?.userInfo.value.healthEntity;
    initData();
  }

  Future initData() async {
    return Future.wait([
      symptomSearch(),
    ]);
  }

  Future login() async {
    try {
      var response = await api.loginApi();
      print('Data login: $response');
    } catch (e) {
      isLoading.value = false;
      print('Exception');
    }
  }

  Future symptomSearch() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        "token": globalController?.healthApiToken,
        "language": "en-gb"
      };
      SymptomListResponse? symptomDiseaseEntity = await api.symptomSearch(body: body);
      symptoms.value = symptomDiseaseEntity?.data ?? [];
      for (int i=0 ; i<symptoms.length ; i++) {
        symptoms[i].name = await (symptoms[i].name ?? "").translateToVi(globalController?.translator ?? GoogleTranslator());
      }
    } catch (e) {
      isLoading.value = false;
      print('Exception in here');
    } finally {
      isLoading.value = false;
    }
  }

  Future healthPrediction() async {
    isLoadingPredict.value = true;
    try {
      Map<String, dynamic> body = {
        "token": globalController?.healthApiToken,
        "language": "en-gb",
        "year_of_birth": healthEntity?.age ?? 0,
        "gender": gender.value.name,
        "symptoms": selectedSymptoms
      };
      DiagnosisListResponse? diagnosisListResponse = await api.predictHealth(body: body);
      predictionsList.value = [];
      predictionsList.value = diagnosisListResponse?.data ?? [];
      await translatePrediction();
    } catch (e) {
      print('Exception: ${e.toString()}');
    } finally {
      isLoadingPredict.value = false;
      btnController.stop();
    }
  }

  Future translatePrediction() async {
    for (var item in predictionsList) {
      item.Issue?.Name = await (item.Issue?.Name ?? "").translateToVi(globalController?.translator ?? GoogleTranslator());
      item.Issue?.IcdName = await (item.Issue?.IcdName ?? "").translateToVi(globalController?.translator ?? GoogleTranslator());
    }
  }

  Future issueInfo(int issueId) async {
    isLoadingIssue.value = true;
    try {
      Map<String, dynamic> body = {
        "token": globalController?.healthApiToken,
        "language": "en-gb",
      };
      IssueEntity? issue = await api.issueInfo(body: body, issueId: issueId);
      issueEntity.value = issue ?? IssueEntity();
      await translateIssue();
    } catch (e) {
      print('Exception: ${e.toString()}');
    } finally {
      isLoadingIssue.value = false;
    }
  }

  Future translateIssue() async {
    issueEntity.value.description = await issueEntity.value.description?.translateToVi(globalController?.translator ?? GoogleTranslator());
    issueEntity.value.medicalCondition = await issueEntity.value.medicalCondition?.translateToVi(globalController?.translator ?? GoogleTranslator());
    issueEntity.value.name = await issueEntity.value.name?.translateToVi(globalController?.translator ?? GoogleTranslator());
    issueEntity.value.treatmentDescription = await issueEntity.value.treatmentDescription?.translateToVi(globalController?.translator ?? GoogleTranslator());
  }

  void onPressedSymptom(int symptomId) {
    if (selectedSymptoms.contains(symptomId)) {
      selectedSymptoms.remove(symptomId);
    } else {
      selectedSymptoms.add(symptomId);
    }
  }

  void onPressedIssue(int issueId) {
    issueInfo(issueId);
    showBarModalBottomSheet(
        context: Get.context!,
        builder: (context) {
          return IssueDetailBottomSheet();
        }
    );
  }
}