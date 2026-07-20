import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/features/image_analysis/data/repositories/image_analysis_repository_impl.dart';
import 'package:untitled5/features/image_analysis/domain/entities/image_analysis_result.dart';
import 'package:untitled5/features/image_analysis/domain/repositories/image_analysis_repository.dart';

final imageAnalysisRepositoryProvider = Provider<ImageAnalysisRepository>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return ImageAnalysisRepositoryImpl(apiClient);
});

enum ImageAnalysisStatus { idle, loading, success, error }

class ImageAnalysisState {
  final ImageAnalysisStatus status;
  final ImageAnalysisResult? result;
  final String? errorMessage;
  final File? selectedImage;

  ImageAnalysisState({
    this.status = ImageAnalysisStatus.idle,
    this.result,
    this.errorMessage,
    this.selectedImage,
  });

  ImageAnalysisState copyWith({
    ImageAnalysisStatus? status,
    ImageAnalysisResult? result,
    String? errorMessage,
    File? selectedImage,
  }) {
    return ImageAnalysisState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

class ImageAnalysisNotifier extends StateNotifier<ImageAnalysisState> {
  final ImageAnalysisRepository _repository;

  ImageAnalysisNotifier(this._repository) : super(ImageAnalysisState());

  Future<void> analyzeImage(File imageFile) async {
    state = state.copyWith(
      status: ImageAnalysisStatus.loading,
      selectedImage: imageFile,
    );

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final result = await _repository.analyzeImage(imageBase64: base64Image);
      state = state.copyWith(
        status: ImageAnalysisStatus.success,
        result: result,
      );
    } catch (e) {
      state = state.copyWith(
        status: ImageAnalysisStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = ImageAnalysisState();
  }
}

final imageAnalysisProvider =
    StateNotifierProvider<ImageAnalysisNotifier, ImageAnalysisState>((ref) {
      final repository = ref.watch(imageAnalysisRepositoryProvider);
      return ImageAnalysisNotifier(repository);
    });
