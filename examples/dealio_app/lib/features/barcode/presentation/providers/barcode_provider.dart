import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/features/barcode/data/repositories/barcode_repository_impl.dart';
import 'package:untitled5/features/barcode/domain/entities/barcode_result.dart';
import 'package:untitled5/features/barcode/domain/repositories/barcode_repository.dart';

final barcodeRepositoryProvider = Provider<BarcodeRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BarcodeRepositoryImpl(apiClient);
});

enum BarcodeStatus { idle, scanning, processing, success, emptyNotFound, error }

class BarcodeState {
  final BarcodeStatus status;
  final BarcodeResult? result;
  final String? errorMessage;
  final String? lastScannedCode;

  BarcodeState({
    this.status = BarcodeStatus.idle,
    this.result,
    this.errorMessage,
    this.lastScannedCode,
  });

  BarcodeState copyWith({
    BarcodeStatus? status,
    BarcodeResult? result,
    String? errorMessage,
    String? lastScannedCode,
  }) {
    return BarcodeState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
      lastScannedCode: lastScannedCode ?? this.lastScannedCode,
    );
  }
}

class BarcodeNotifier extends StateNotifier<BarcodeState> {
  final BarcodeRepository _repository;

  BarcodeNotifier(this._repository) : super(BarcodeState());

  Future<void> handleBarcodeScanned(String code, String type) async {
    // Sanitize
    final cleanCode = code.trim();
    if (cleanCode.length < 3) {
      state = state.copyWith(
        status: BarcodeStatus.error,
        errorMessage: 'Invalid barcode: too short',
      );
      return;
    }

    state = state.copyWith(
      status: BarcodeStatus.processing,
      lastScannedCode: cleanCode,
    );

    try {
      // Step 1: Process barcode (metadata lookup)
      await _repository.processBarcode(code: cleanCode, type: type);

      // Step 2: Find product by barcode (linking to internal product)
      final result = await _repository.getProductByBarcode(cleanCode);

      state = state.copyWith(status: BarcodeStatus.success, result: result);
    } catch (e) {
      if (e.toString().contains('404') || e.toString().contains('not found')) {
        state = state.copyWith(status: BarcodeStatus.emptyNotFound);
      } else {
        state = state.copyWith(
          status: BarcodeStatus.error,
          errorMessage: e.toString(),
        );
      }
    }
  }

  void reset() {
    state = BarcodeState();
  }
}

final barcodeProvider = StateNotifierProvider<BarcodeNotifier, BarcodeState>((
  ref,
) {
  final repository = ref.watch(barcodeRepositoryProvider);
  return BarcodeNotifier(repository);
});
