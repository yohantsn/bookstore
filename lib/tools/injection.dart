import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';

class Injection {
  final IBookStoreApi bookStoreApi;
  final IBookStorePersistence bookStorePersistence;

  static final Map<String, Injection> _cache = <String, Injection>{};

  factory Injection({
    required IBookStoreApi bookStoreApi,
    required IBookStorePersistence bookStorePersistence,
  }) {
    if (_cache.containsKey("instance")) {
      return _cache["instance"]!;
    } else {
      final injection = Injection._internal(
        bookStoreApi: bookStoreApi,
        bookStorePersistence: bookStorePersistence,
      );
      _cache["instance"] = injection;
      return injection;
    }
  }

  Injection._internal({
    required this.bookStoreApi,
    required this.bookStorePersistence,
  });

  static Injection get instance {
    if (_cache["instance"] != null) {
      return _cache["instance"]!;
    } else {
      throw (Exception("You must create an instance of this object!"));
    }
  }
}
