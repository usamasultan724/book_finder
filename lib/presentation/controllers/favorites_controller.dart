import 'package:book_finder/data/repositories/fav_repo.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/book_model.dart';

class FavoritesController extends ValueNotifier<List<BookModel>> {
  final FavoritesRepository repository;

  FavoritesController(this.repository) : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    value = await repository.getFavorites();
  }

  Future<void> toggleFavorite(BookModel book) async {
    await repository.toggleFavorite(book);
    await loadFavorites();
  }
}