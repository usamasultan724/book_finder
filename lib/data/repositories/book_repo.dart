import 'dart:convert';
import 'dart:developer';

import 'package:book_finder/constants/api_constants.dart';
import 'package:book_finder/data/models/book_model.dart';
import 'package:http/http.dart' as http;

class BookRepository {
  Future<List<BookModel>> searchBooks(String query) async {
    if (query.isEmpty) return [];

    final response = await http.get(
      Uri.parse(ApiConstants.searchBooks(query)),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString(), name: 'searchBooks');

      final items = data['items'] as List<dynamic>?;
      if (items == null) return [];

      return items
          .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load books: ${response.statusCode}');
  }
}