import 'package:dio/dio.dart';

class AppErrorMapper {
  static String mapMessage(Object? error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map) {
        final message = (responseData['message'] ?? responseData['error'])
            ?.toString();
        if (message != null && message.isNotEmpty) {
          switch (message) {
            case 'Device ID is required':
              return 'Qurilma identifikatori talab qilinadi.';
            case 'This account is locked to another device':
              return "Bu akkaunt boshqa qurilmaga bog'langan.";
            case 'Device verification failed':
              return 'Qurilma tasdiqlanmadi. Qayta kiring.';
            case 'Invalid refresh token':
              return 'Sessiya tugagan, qayta login qiling.';
            default:
              return message;
          }
        }
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return "Tarmoq ulanishi sekin. Qayta urinib ko'ring.";
      }

      if (error.type == DioExceptionType.connectionError) {
        return 'Internetga ulanishda xatolik.';
      }
    }

    return 'Kutilmagan xatolik yuz berdi.';
  }
}
