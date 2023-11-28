class SymptomListResponse {
  List<SymptomDiseaseEntity>? data;

  SymptomListResponse.fromJson(List<dynamic> json) {
    var dataCreate = <SymptomDiseaseEntity>[];
    for (var item in json) {
      dataCreate.add(SymptomDiseaseEntity.fromJson(item));
    }
    data = dataCreate;
  }
}

class SymptomDiseaseEntity {
  int? id;
  String? name;

  SymptomDiseaseEntity({
    this.id,
    this.name,
  });
  SymptomDiseaseEntity.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    return data;
  }
}