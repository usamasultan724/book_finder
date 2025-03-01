import '../../data/models/book_model.dart';
import '../local/database_helper.dart';

class FavoritesRepository {
  final DatabaseHelper _dbHelper;

  FavoritesRepository(this._dbHelper);

  Future<List<FavoriteBook>> getFavorites() async {
    return await _dbHelper.getFavorites();
  }

  Future<void> toggleFavorite(BookModel book) async {
    await _dbHelper.toggleFavorite(book);
  }
}