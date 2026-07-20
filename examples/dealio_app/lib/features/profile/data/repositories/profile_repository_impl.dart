import 'package:dio/dio.dart';
import 'package:untitled5/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:untitled5/features/profile/domain/entities/profile_entity.dart';
import 'package:untitled5/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<ProfileEntity> getMyProfile() async {
    try {
      final dto = await _remoteDataSource.getMyProfile();
      return dto.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw 'Failed to load profile';
    }
  }

  @override
  Future<ProfileEntity> updateMyProfile({
    String? firstName,
    String? lastName,
    String? avatar,
    String? language,
    String? currency,
    String? theme,
    bool? emailNotifications,
    bool? priceAlerts,
  }) async {
    try {
      final dto = await _remoteDataSource.updateMyProfile(
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
        language: language,
        currency: currency,
        theme: theme,
        emailNotifications: emailNotifications,
        priceAlerts: priceAlerts,
      );
      return dto.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw 'Failed to update profile';
    }
  }

  String _handleDioError(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      final error = map['error'];
      final message = map['message'];
      if (error is String && error.trim().isNotEmpty) return error;
      if (message is String && message.trim().isNotEmpty) return message;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
