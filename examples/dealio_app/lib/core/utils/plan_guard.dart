import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/features/billing/presentation/providers/subscription_provider.dart';

class PlanGuard {
  final PlanCapabilities? capabilities;
  final QuotaInfo? quota;

  PlanGuard({this.capabilities, this.quota});

  bool get canSearch => quota?.search.allowed ?? false;

  bool get canUseAiAnalysis => capabilities?.aiAnalysis ?? false;

  bool get canUseDeepSeekChat => capabilities?.deepSeekChat ?? false;

  bool get canScanBarcode => capabilities?.barcode ?? false;

  bool get canSeeReviews => capabilities?.reviews ?? false;

  bool get canUseSelectedStoreSearch =>
      capabilities?.selectedStoreSearch ?? false;

  int get maxSelectedStores => capabilities?.maxSelectedStores ?? 0;

  bool get canUseSuperAlerts => capabilities?.superAlerts ?? false;

  bool isFeatureAvailable(String feature) {
    if (capabilities == null) return false;
    switch (feature) {
      case 'search':
        return canSearch;
      case 'aiAnalysis':
        return canUseAiAnalysis;
      case 'chat':
        return canUseDeepSeekChat;
      case 'barcode':
        return canScanBarcode;
      case 'reviews':
        return canSeeReviews;
      case 'selectedStoreSearch':
        return canUseSelectedStoreSearch;
      case 'superAlerts':
        return canUseSuperAlerts;
      default:
        return false;
    }
  }
}

final planGuardProvider = Provider<PlanGuard>((ref) {
  final billingState = ref.watch(billingStatusProvider);
  return billingState.when(
    data: (data) =>
        PlanGuard(capabilities: data.capabilities, quota: data.quota),
    loading: () => PlanGuard(),
    error: (_, _) => PlanGuard(),
  );
});
