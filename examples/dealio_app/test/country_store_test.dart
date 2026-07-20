import 'package:flutter_test/flutter_test.dart';
import 'package:untitled5/core/models/search_models.dart';

void main() {
  group('Country and Store Models', () {
    test('Country.fromJson handles backend contract', () {
      final json = {
        "code": "UZ",
        "name": "Uzbekistan",
        "gl": "uz",
        "hl": "uz",
        "location": "Tashkent",
      };
      final country = Country.fromJson(json);
      expect(country.code, "UZ");
      expect(country.name, "Uzbekistan");
    });

    test('Store.fromJson handles backend contract', () {
      final json = {
        "name": "Uzum",
        "domains": ["uzum.uz"],
        "countryCode": "UZ",
      };
      final store = Store.fromJson(json);
      expect(store.name, "Uzum");
      expect(store.countryCode, "UZ");
    });
  });

  group('SearchRequest Builder', () {
    test('SearchRequest includes selected country', () {
      const request = SearchRequest(
        query: "iphone",
        country: "UZ",
        location: "Tashkent",
      );

      final json = request.toJson();
      expect(json['country'], "UZ");
      expect(json['storeScope'], "global");
    });
  });
}
