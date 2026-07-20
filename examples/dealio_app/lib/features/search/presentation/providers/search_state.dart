import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/models/subscription_model.dart';

part 'search_state.freezed.dart';

enum SearchStatus {
  idle,
  loadingStage1, // "Searching..."
  stage1Ready, // Partial results, "Fetching exact prices..."
  stage1ReadyAiPending, // Results ready, AI analysis in progress
  stage2Ready, // Enriched results, "AI is analyzing fit..."
  stage3Ready, // Full results
  error,
  quotaExceeded,
}

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.idle) SearchStatus status,
    @Default([]) List<Product> results,
    @Default([]) List<StoreOffer> storeOffers,
    String? requestId,
    String? aiSummaryRequestId,
    String? errorMessage,
    SearchRequest? lastRequest,

    // Quota and Plan info from Stage 1
    SubscriptionPlan? plan,
    String? searchProvider,
    QuotaInfo? quota,

    // Progressive tracking
    @Default(false) bool stage2Error,
    @Default(false) bool stage3Error,
    @Default('') String stage1Source,
  }) = _SearchState;
}
