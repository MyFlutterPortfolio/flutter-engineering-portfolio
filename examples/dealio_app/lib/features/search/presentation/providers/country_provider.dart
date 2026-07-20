import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/features/search/presentation/providers/search_provider.dart';

final countriesProvider = FutureProvider<List<Country>>((ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.getCountries();
});

final selectedCountryProvider = StateProvider<Country?>((ref) => null);
