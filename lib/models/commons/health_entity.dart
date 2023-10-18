class HealthEntity {
  int? age;
  double? height;
  double? weight;

  HealthEntity({this.age, this.height, this.weight});

  HealthEntity.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['height'] = height;
    data['weight'] = weight;
    return data;
  }
}