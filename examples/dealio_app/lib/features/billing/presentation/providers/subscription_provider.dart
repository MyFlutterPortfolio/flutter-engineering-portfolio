import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/features/product/data/repositories/product_repository.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

final billingStatusProvider =
    StateNotifierProvider<
      SubscriptionNotifier,
      AsyncValue<BillingStatusResponse>
    >((ref) {
      final repository = ref.watch(productRepositoryProvider);
      return SubscriptionNotifier(repository, ref);
    });

class SubscriptionNotifier
    extends StateNotifier<AsyncValue<BillingStatusResponse>>
    with WidgetsBindingObserver {
  final ProductRepository _repository;
  final Ref _ref;

  SubscriptionNotifier(this._repository, this._ref)
    : super(const AsyncValue.loading()) {
    WidgetsBinding.instance.addObserver(this);
    refreshStatus();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshStatus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  BillingStatusResponse _buildLocalFreeStatus() {
    return const BillingStatusResponse(
      subscription: Subscription(
        userId: '',
        plan: SubscriptionPlan.FREE,
        status: SubscriptionStatus.NONE,
      ),
      capabilities: PlanCapabilities(),
      quota: QuotaInfo(
        search: SearchQuota(
          used: 0,
          limit: 10,
          remaining: 10,
          resetAt: '',
          allowed: true,
        ),
      ),
    );
  }

  Future<void> refreshStatus() async {
    final authState = _ref.read(authProvider);
    if (authState.status != AuthStatus.authenticated) {
      state = AsyncValue.data(_buildLocalFreeStatus());
      return;
    }

    final previousState = state;
    if (previousState is! AsyncData) {
      state = const AsyncValue.loading();
    }

    try {
      final status = await _repository.getBillingStatus();
      state = AsyncValue.data(status);
    } catch (e) {
      // Graceful fallback: keep app usable even when billing endpoint fails.
      state = AsyncValue.data(_buildLocalFreeStatus());
    }
  }

  Future<void> activateGooglePlay({
    required String subscriptionId,
    required String purchaseToken,
    required String orderId,
    required String packageName,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.activateGooglePlayPurchase(
        ActivateGooglePlayRequest(
          subscriptionId: subscriptionId,
          purchaseToken: purchaseToken,
          orderId: orderId,
          packageName: packageName,
        ),
      );
      await refreshStatus();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
