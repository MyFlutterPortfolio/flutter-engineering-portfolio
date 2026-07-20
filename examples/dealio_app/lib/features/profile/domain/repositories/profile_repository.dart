import 'package:untitled5/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getMyProfile();

  Future<ProfileEntity> updateMyProfile({
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
