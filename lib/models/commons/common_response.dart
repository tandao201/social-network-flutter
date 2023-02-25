class CommonResponse {
  String? errorCode;
  dynamic data;

  CommonResponse({this.errorCode, this.data});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['data'] = this.data;
    return data;
  }
}
