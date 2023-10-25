import 'dart:ffi';
import 'package:flutter/material.dart';

import '../shared/enums.dart';

extension DoubleBmiEx on double {
  Color getColor() {
    if (this <= 18.5) return Colors.lightBlue;
    if (this < 25) return Colors.green;
    if (this < 30) return Colors.yellow;
    if (this < 35) return Colors.orange;
    return Colors.red;
  }

  String getBodyShapeString() {
    if (this <= 18.5) return "Nhẹ cân";
    if (this < 25) return "Cân nặng bình thường";
    if (this < 30) return "Thừa cân";
    if (this < 35) return "Béo phì độ I";
    return "Béo phì độ II trở lên";
  }

  bool needRisk() {
    return !(this >= 18.5 && this <= 25);
  }

  String getRiskString() {
    if (this <= 18.5) {
      return "· Thiếu dinh dưỡng: Thiếu cân có thể chỉ ra rằng cơ thể không nhận đủ dưỡng chất cần thiết để duy trì sức khỏe. Điều này có thể dẫn đến suy dinh dưỡng, yếu đề kháng và suy giảm sức khỏe tổng quát."
          "\n· Rối loạn kinh nguyệt: Thiếu cân nghiêm trọng có thể gây rối loạn kinh nguyệt hoặc ngừng kinh."
          "\n· Yếu đề kháng: Thiếu cân có thể làm giảm hệ thống miễn dịch của cơ thể, làm tăng nguy cơ mắc các bệnh nhiễm trùng và bệnh tật khác.";
    }
    if (this < 25) {
      return "· Thường thì nguy cơ sức khỏe thấp: Trong khoảng BMI này, nguy cơ mắc các bệnh liên quan đến cân nặng cao hoặc thấp hơn thường thấp hơn so với các khoảng BMI khác. Tuy nhiên, lối sống, chế độ ăn uống và mức độ hoạt động thể chất vẫn có thể ảnh hưởng đến sức khỏe.";
    }
    if (this < 30) {
      return "· Tăng nguy cơ bệnh tim mạch: Người thừa cân có nguy cơ cao hơn mắc các vấn đề về tim mạch, bao gồm bệnh mạch vành, nhồi máu cơ tim và đột quỵ."
          "\n· Tiểu đường: Thừa cân tăng nguy cơ mắc tiểu đường type 2, do cơ thể kháng insulin hoặc không sản xuất đủ insulin."
          "\n· Huyết áp cao: Thừa cân có thể dẫn đến tăng huyết áp, tăng nguy cơ mắc bệnh huyết áp cao và các vấn đề liên quan đến tim mạch."
          "\n· Béo phì: Thừa cân là một bước tiến tiềm năng đến béo phì, điều này tăng nguy cơ mắc các bệnh như bệnh mật, bệnh thận, bệnh xương khớp và một số loại ung thư.";
    }

    return "· Tăng nguy cơ mắc bệnh tim mạch: Béo phì là một yếu tố nguy cơ quan trọng cho các bệnh tim mạch, bao gồm bệnh mạch vành, nhồi máu cơ tim và đột quỵ."
        "\n· Tiểu đường: Béo phì tăng nguy cơ mắc tiểu đường type 2, do cơ thể kháng insulin hoặc không sản xuất đủ insulin."
        "\n· Huyết áp cao: Béo phì gắn liền với tăng huyết áp, tăng nguy cơ mắc bệnh huyết áp cao và các vấn đề liên quan đến tim mạch."
        "\n· Bệnh mật: Béo phì tăng nguy cơ mắc bệnh mật bao gồm bệnh gan nhiễm mỡ không cồn, viêm gan và xơ gan.";
  }

  String getThingShouldDo() {
    if (this <= 18.5) {
      return "· Tăng cường ăn uống: Tăng lượng calo tiêu thụ bằng cách tăng khẩu phần ăn và chọn các thực phẩm giàu calo như các nguồn chất béo lành mạnh, protein chất lượng và carbohydrate phức tạp."
          "\n· Tập thể dục: Tập trung vào tập luyện để tăng cường sức mạnh và tăng cơ để cải thiện sức khỏe chung."
          "\n· Kiểm tra y tế: Nếu bạn gặp tình trạng thiếu cân kéo dài, hãy tham khảo ý kiến của bác sĩ để đảm bảo rằng không có vấn đề sức khỏe nghiêm trọng.";
    }
    if (this < 25) {
      return "· Duy trì lối sống lành mạnh: Tiếp tục duy trì chế độ ăn lành mạnh và thường xuyên vận động để duy trì trạng thái BMI bình thường."
          "\n· Kiểm soát cân nặng: Đảm bảo bạn duy trì cân nặng ổn định bằng cách theo dõi khẩu phần ăn và thực hiện tập luyện thường xuyên.";
    }
    if (this < 30) {
      return "· Chế độ ăn lành mạnh: Tăng cường việc ăn các loại thực phẩm giàu chất xơ và chất dinh dưỡng, giảm tiêu thụ thực phẩm chứa nhiều calo không có giá trị dinh dưỡng như đồ ngọt, thức ăn nhanh và thức uống có ga."
          "\n· Tăng cường hoạt động thể chất: Tăng cường lượng hoạt động thể chất hàng ngày và thực hiện các bài tập cardio như chạy bộ, đi bộ nhanh, hoặc bơi lội để đốt cháy calo và giảm mỡ cơ thể."
          "\n· Giảm cân hợp lý: Đặt mục tiêu giảm cân từ 0,5-1kg mỗi tuần bằng cách kết hợp chế độ ăn và tập luyện.";
    }
    if (this < 35) {
      return "· Giảm cân kiểm soát: Đặt mục tiêu giảm cân từ 0,5-1kg mỗi tuần bằng cách tạo hiệu thận năng lượng tiêu thụ cao hơn so với lượng calo tiêu thụ."
          "\n· Chế độ ăn: Tăng cường việc ăn thực phẩm giàu chất xơ và chất dinh dưỡng như rau, quả, ngũ cốc nguyên hạt, protein chất lượng và giảm tiêu thụ đồ ngọt, thức ăn nhanh và thức uống có ga."
          "\n· Tập thể dục: Kết hợp các bài tập cardio và tập luyện sức mạnh để đốt cháy calo và tăng cường cơ bắp.";
    }

    return "· Hỗ trợ y tế: Khi BMI vượt quá 35.0, hãy tham khảo ý kiến của bác sĩ hoặc chuyên gia dinh dCải thiện BMI trong trường hợp béo phì cấp độ 2 trở lên thường đòi hỏi sự hỗ trợ y tế chuyên sâu, bao gồm giảm cân an toàn và hiệu quả thông qua chế độ ăn kiểm soát và quản lý tập luyện."
        "\n· Chế độ ăn kiểm soát calo: Điều chỉnh khẩu phần ăn để tạo ra hiệu thiệu âm (tiêu thụ calo ít hơn so với calo tiêu thụ). Điều này thường đòi hỏi giảm lượng calo tiêu thụ từ thực phẩm và đồ uống, ưu tiên ăn các thực phẩm giàu chất xơ và chất dinh dưỡng, giảm tiêu thụ đường và chất béo không lành mạnh."
        "\n· Quản lý tập luyện: Tăng cường hoạt động thể chất và tập luyện đều đặn. Kết hợp các hoạt động cardio như chạy, bơi lội hoặc đạp xe với tập luyện sức mạnh để tăng cường cơ bắp và đốt cháy mỡ cơ thể."
        "\n· Hỗ trợ tâm lý: Béo phì cấp độ 2 và cao hơn thường liên quan đến các yếu tố tâm lý và hành vi phức tạp hơn. Hỗ trợ tâm lý và tư vấn có thể được cung cấp bởi các chuyên gia như nhà tâm lý học, nhà tư vấn dinh dưỡng hoặc nhóm hỗ trợ để giúp bạn đối mặt với các thách thức và duy trì lối sống lành mạnh.";
  }
}