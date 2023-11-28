class DiagnosisListResponse {
  List<DiagnosisEntity>? data;

  DiagnosisListResponse.fromJson(List<dynamic> json) {
    var dataCreate = <DiagnosisEntity>[];
    for (var item in json) {
      dataCreate.add(DiagnosisEntity.fromJson(item));
    }
    data = dataCreate;
  }
}

class DiagnosisEntitySpecialisation {
  int? ID;
  String? Name;
  int? SpecialistID;

  DiagnosisEntitySpecialisation({
    this.ID,
    this.Name,
    this.SpecialistID,
  });
  DiagnosisEntitySpecialisation.fromJson(Map<String, dynamic> json) {
    ID = json['ID']?.toInt();
    Name = json['Name']?.toString();
    SpecialistID = json['SpecialistID']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ID'] = ID;
    data['Name'] = Name;
    data['SpecialistID'] = SpecialistID;
    return data;
  }
}

class DiagnosisEntityIssue {
/*
{
  "ID": 11,
  "Name": "Flu",
  "Accuracy": 90,
  "Icd": "J10;J11",
  "IcdName": "Influenza due to other identified influenza virus;Influenza, virus not identified",
  "ProfName": "Influenza",
  "Ranking": 1
}
*/

  int? ID;
  String? Name;
  double? Accuracy;
  String? Icd;
  String? IcdName;
  String? ProfName;
  int? Ranking;

  DiagnosisEntityIssue({
    this.ID,
    this.Name,
    this.Accuracy,
    this.Icd,
    this.IcdName,
    this.ProfName,
    this.Ranking,
  });
  DiagnosisEntityIssue.fromJson(Map<String, dynamic> json) {
    ID = json['ID']?.toInt();
    Name = json['Name']?.toString();
    Accuracy = json['Accuracy']?.toDouble();
    Icd = json['Icd']?.toString();
    IcdName = json['IcdName']?.toString();
    ProfName = json['ProfName']?.toString();
    Ranking = json['Ranking']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ID'] = ID;
    data['Name'] = Name;
    data['Accuracy'] = Accuracy;
    data['Icd'] = Icd;
    data['IcdName'] = IcdName;
    data['ProfName'] = ProfName;
    data['Ranking'] = Ranking;
    return data;
  }
}

class DiagnosisEntity {
/*
{
  "Issue": {
    "ID": 11,
    "Name": "Flu",
    "Accuracy": 90,
    "Icd": "J10;J11",
    "IcdName": "Influenza due to other identified influenza virus;Influenza, virus not identified",
    "ProfName": "Influenza",
    "Ranking": 1
  },
  "Specialisation": [
    {
      "ID": 15,
      "Name": "General practice",
      "SpecialistID": 0
    }
  ]
}
*/

  DiagnosisEntityIssue? Issue;
  List<DiagnosisEntitySpecialisation?>? Specialisation;

  DiagnosisEntity({
    this.Issue,
    this.Specialisation,
  });
  DiagnosisEntity.fromJson(Map<String, dynamic> json) {
    Issue = (json['Issue'] != null) ? DiagnosisEntityIssue.fromJson(json['Issue']) : null;
    if (json['Specialisation'] != null) {
      final v = json['Specialisation'];
      final arr0 = <DiagnosisEntitySpecialisation>[];
      v.forEach((v) {
        arr0.add(DiagnosisEntitySpecialisation.fromJson(v));
      });
      Specialisation = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (Issue != null) {
      data['Issue'] = Issue!.toJson();
    }
    if (Specialisation != null) {
      final v = Specialisation;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['Specialisation'] = arr0;
    }
    return data;
  }
}
