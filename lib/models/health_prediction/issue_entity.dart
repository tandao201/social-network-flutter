class IssueEntity {
  String? description;
  String? descriptionShort;
  String? medicalCondition;
  String? name;
  String? possibleSymptoms;
  String? profName;
  String? synonyms;
  String? treatmentDescription;

  IssueEntity({
    this.description,
    this.descriptionShort,
    this.medicalCondition,
    this.name,
    this.possibleSymptoms,
    this.profName,
    this.synonyms,
    this.treatmentDescription,
  });
  IssueEntity.fromJson(Map<String, dynamic> json) {
    description = json['Description']?.toString();
    descriptionShort = json['DescriptionShort']?.toString();
    medicalCondition = json['MedicalCondition']?.toString();
    name = json['Name']?.toString();
    possibleSymptoms = json['PossibleSymptoms']?.toString();
    profName = json['ProfName']?.toString();
    synonyms = json['Synonyms']?.toString();
    treatmentDescription = json['TreatmentDescription']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Description'] = description;
    data['DescriptionShort'] = descriptionShort;
    data['MedicalCondition'] = medicalCondition;
    data['Name'] = name;
    data['PossibleSymptoms'] = possibleSymptoms;
    data['ProfName'] = profName;
    data['Synonyms'] = synonyms;
    data['TreatmentDescription'] = treatmentDescription;
    return data;
  }
}
