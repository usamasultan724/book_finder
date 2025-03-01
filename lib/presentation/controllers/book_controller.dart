import 'package:book_finder/data/api_response.dart';
import 'package:book_finder/data/repositories/book_repo.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/book_model.dart';

class BookController extends ValueNotifier<ApiResponse<List<BookModel>>> {
  final BookRepository repository;

  BookController(this.repository)
      : super(ApiResponse<List<BookModel>>.completed([]));

  Future<void> searchBooks(String query) async {
    value = ApiResponse.loading();

    try {
      final results = await repository.searchBooks(query);
      value = ApiResponse.completed(results);
    } catch (e) {
      value = ApiResponse.error(e.toString());
    }
  }
}
