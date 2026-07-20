import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/features/favorites/data/repositories/favorites_repository.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository(ref.watch(apiClientProvider));
});

final favoritesProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  return ref.watch(favoritesRepositoryProvider).getFavorites();
});

final favoriteIdsProvider = FutureProvider.autoDispose<Set<String>>((
  ref,
) async {
  final products = await ref.watch(favoritesProvider.future);
  return products
      .map((product) => product.id.trim())
      .where((productId) => productId.isNotEmpty)
      .toSet();
});
