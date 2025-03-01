import 'package:flutter/material.dart';
import '../../data/models/book_model.dart';
import 'package:provider/provider.dart';
import '../controllers/favorites_controller.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavoritesController>(context);

    return ListTile(
      leading: book.thumbnail != null
          ? Image.network(book.thumbnail!, width: 50)
          : const Icon(Icons.book),
      title: Text(book.title??'No title'),
      subtitle: Text(book.authors?.join(', ') ?? 'Unknown Author'),
      trailing: IconButton(
        icon: const Icon(Icons.favorite),
        color: favoritesController.value.any((b) => b.id == book.id)
            ? Colors.red
            : Colors.grey,
        onPressed: () => favoritesController.toggleFavorite(book),
      ),
    );
  }
}