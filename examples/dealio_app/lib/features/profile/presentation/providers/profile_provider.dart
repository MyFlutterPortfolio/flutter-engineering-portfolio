import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:untitled5/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:untitled5/features/profile/domain/entities/profile_entity.dart';
import 'package:untitled5/features/profile/domain/repositories/profile_repository.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(apiClientProvider).dio;
  return ProfileRemoteDataSourceImpl(dio);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepositoryImpl(dataSource);
});

class ProfileState {
  final ProfileEntity? profile;
  final bool isLoading;
  final bool isUpdating;
  final String? errorMessage;
  static const _unset = Object();

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.isUpdating = false,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileEntity? profile,
    bool? isLoading,
    bool? isUpdating,
    Object? errorMessage = _unset,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const ProfileState()) {
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.getMyProfile();
      state = state.copyWith(
        profile: profile,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? avatar,
    String? language,
    String? currency,
    String? theme,
    bool? emailNotifications,
    bool? priceAlerts,
  }) async {
    state = state.copyWith(isUpdating: true, errorMessage: null);
    try {
      final profile = await _repository.updateMyProfile(
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
        language: language,
        currency: currency,
        theme: theme,
        emailNotifications: emailNotifications,
        priceAlerts: priceAlerts,
      );
      state = state.copyWith(
        profile: profile,
        isUpdating: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isUpdating: false, errorMessage: e.toString());
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository);
});
