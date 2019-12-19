import 'dart:convert';

class FluroConvertUtils {
  static String cnParamsEncode(String data) {
    return jsonEncode(Utf8Encoder().convert(data));
  }

  static String cnParamsDecode(String data) {
    List list = List<int>();
    jsonDecode(data).forEach(list.add);
    return Utf8Decoder().convert(list);
  }

  static int string2int(String data) {
    return int.parse(data);
  }

  static double string2double(String data) {
    return double.parse(data);
  }

  static bool string2bool(String data) {
    return data == 'true' ? true : false;
  }

  static String encodeStringToBase64UrlSafeString(String data) {
    return Base64Codec.urlSafe().encode(utf8.encode(data));
  }

  static String decodeFromBase64UrlSafeEncodedString(String data) {
    return utf8.decode(Base64Codec.urlSafe().decode(data));
  }

}