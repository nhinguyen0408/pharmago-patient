import 'package:intl/intl.dart';

// ignore: non_constant_identifier_names
String FormatCurrency(value) {
  final oCcy = NumberFormat('#,##0', 'vi_VN');
  return oCcy.format(value ?? 0);
}

String formatFixedDouble({required double value, int numberOfChar = 2}) {
  return value.toStringAsFixed(numberOfChar).toString();
}

int formatCurrencyString(String value) {
  final format = value.replaceAll('.', '');
  return int.parse(format);
}

bool isPhoneNumberValid(String phoneNumber) {
  // Biểu thức chính quy để kiểm tra số điện thoại
  final regex = RegExp(r'^(0|\+?84|84)?[98753]\d{8}$');

  // Kiểm tra khớp biểu thức chính quy
  return regex.hasMatch(phoneNumber);
}

bool isAlphabetic(String input) {
  final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
  return !regex.hasMatch(input);
}

bool noSpecialCharacters(String input) {
  final RegExp regex = RegExp(r'^[0-9a-zA-ZÀ-Ỹà-ỹ\s]+$');
  return !regex.hasMatch(input);
}

bool doesNotContainSpecialCharsOrSpaces(String input) {
  final RegExp regex = RegExp(r'^[a-zA-Z0-9]*$');
  return regex.hasMatch(input);
}

bool isEmailValid(String email) {
  // Biểu thức chính quy để kiểm tra email
  final regex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
  );

  // Kiểm tra khớp biểu thức chính quy
  return regex.hasMatch(email);
}

/// format dd/MM/y to DateTime String
String formatDateTimeString(String time) {
  return time.replaceAllMapped(RegExp(r'(\d{2})/(\d{2})/(\d{4})'), (Match m) {
    return '${m[3]}-${m[2]}-${m[1]}';
  });
}

String timeBetween({required DateTime startTime, required DateTime endTime}) {
  Duration difference = endTime.difference(startTime);
  // Lấy số tháng
  int months = (difference.inDays / 30).round();

  if (months != 0) {
    return '$months tháng';
  }

  // Lấy số ngày
  int days = difference.inDays;

  if (days != 0) {
    return '$days ngày';
  }

// Lấy số giờ
  int hours = difference.inHours;

  if (hours != 0) {
    return '$hours giờ';
  }

// Lấy số phút
  int minutes = difference.inMinutes % 60;

  if (minutes != 0) {
    return '$minutes phút';
  }

  // Lấy số giây
  int seccond = difference.inSeconds % 60;
  return '$seccond giây';
}

/// Convert String [Hà Nội] to [ha noi]
///
/// Can use anothor String
String convertToUnsigned(String input) {
  // Bảng chữ cái có dấu và bảng chữ cái tương ứng không dấu
  final List<String> accentedCharacters = [
    'àáảãạâầấẩẫậăằắẳẵặ',
    'èéẻẽẹêềếểễệ',
    'ìíỉĩị',
    'òóỏõọôồốổỗộơờớởỡợ',
    'ùúủũụưừứửữự',
    'ỳýỷỹỵ',
    'đ',
  ];
  final List<String> unaccentedCharacters = [
    'aaaaaaaaaaaaaaa',
    'eeeeeeeeeeeeeee',
    'iiiiii',
    'oooooooooooooooo',
    'uuuuuuuuuuuuuuu',
    'yyyyy',
    'd',
  ];

  String result = input.toLowerCase();

  // Loại bỏ dấu trong chuỗi
  for (int i = 0; i < accentedCharacters.length; i++) {
    for (int j = 0; j < accentedCharacters[i].length; j++) {
      result = result.replaceAll(
        accentedCharacters[i][j],
        unaccentedCharacters[i][0],
      );
    }
  }

  result = result.replaceAll(' ', '');
  result = result.replaceAll('-', '');

  return result;
}

String replaceStringAddress(String input) {
  var rerult = input.toLowerCase();
  rerult = rerult.replaceAll('thanh pho ', '');
  rerult = rerult.replaceAll('tp ', '');
  rerult = rerult.replaceAll('quan ', '');
  rerult = rerult.replaceAll('q. ', '');
  rerult = rerult.replaceAll('huyen ', '');
  rerult = rerult.replaceAll('h. ', '');
  rerult = rerult.replaceAll('thi xa ', '');
  rerult = rerult.replaceAll('tx. ', '');
  rerult = rerult.replaceAll('thi tran ', '');
  rerult = rerult.replaceAll('tt. ', '');
  rerult = rerult.replaceAll('xa ', '');
  rerult = rerult.replaceAll('x. ', '');
  rerult = rerult.replaceAll('phuong ', '');
  rerult = rerult.replaceAll('p. ', '');
  rerult = rerult.replaceAll('district', '');
  rerult = rerult.replaceAll('ward', '');
  rerult = rerult.replaceAll('city', '');
  rerult = rerult.replaceAll(' ', '');
  rerult = rerult.replaceAll('-', '');
  rerult = rerult.replaceAll(RegExp(r'\d'), '');
  return rerult.toLowerCase();
}


