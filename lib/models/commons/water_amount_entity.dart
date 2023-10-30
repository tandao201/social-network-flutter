class WaterAmountEntity {
  String? date;
  double? inDayWaterAmount;
  double? waterAmount;

  WaterAmountEntity({
    this.date,
    this.inDayWaterAmount,
    this.waterAmount
  });

  WaterAmountEntity.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    inDayWaterAmount = json['inDayWaterAmount'];
    waterAmount = json['waterAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['inDayWaterAmount'] = inDayWaterAmount;
    data['waterAmount'] = waterAmount;
    return data;
  }
}