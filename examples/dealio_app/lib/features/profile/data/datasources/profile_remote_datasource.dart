import 'package:dio/dio.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/features/profile/data/models/profile_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDto> getMyProfile();

  Future<ProfileDto> updateMyProfile({
    String? firstName,
    String? lastName,
    String? avatar,
    String? language,
    String? currency,
    String? theme,
    bool? emailNotifications,
    bool? priceAlerts,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<ProfileDto> getMyProfile() async {
    final response = await _dio.get(ApiEndpoints.profileMe);
    return ProfileDto.fromJson(Map<String, dynamic>.from(response.data as Map));
  }

  @override
  Future<ProfileDto> updateMyProfile({
    String? firstName,
    String? lastName,
    String? avatar,
    String? language,
    String? currency,
    String? theme,
    bool? emailNotifications,
    bool? priceAlerts,
  }) async {
    final data = <String, dynamic>{};
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (avatar != null) data['avatar'] = avatar;
    if (language != null) data['language'] = language;
    if (currency != null) data['currency'] = currency;
    if (theme != null) data['theme'] = theme;
    if (emailNotifications != null) {
      data['emailNotifications'] = emailNotifications;
    }
    if (priceAlerts != null) data['priceAlerts'] = priceAlerts;

    final response = await _dio.patch(ApiEndpoints.profileMe, data: data);
    return ProfileDto.fromJson(Map<String, dynamic>.from(response.data as Map));
  }
}
