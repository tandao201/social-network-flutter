extension StringExtension on String {
  String timeAgo() {
    print('String format: $this');
    String timeMain = DateTime.parse(this).toLocal().toString();
    final year = int.parse(timeMain.substring(0, 4));
    final month = int.parse(timeMain.substring(5, 7));
    final day = int.parse(timeMain.substring(8, 10));
    final hour = int.parse(timeMain.substring(11, 13));
    final minute = int.parse(timeMain.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'phút';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'giờ';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'ngày';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'tuần';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'tháng';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'năm';
    }

    timeAgo = '$timeValue $timeUnit';

    return '$timeAgo trước';
  }
}