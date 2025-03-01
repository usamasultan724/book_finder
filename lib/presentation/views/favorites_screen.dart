import 'package:book_finder/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FavoritesController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ValueListenableBuilder<List<FavoriteBook>>(
        valueListenable: controller,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final book = favorites[index];
              return ListTile(
                leading: book.thumbnail != null
                    ? Image.network(book.thumbnail!, width: 50)
                    : const Icon(Icons.book),
                title: Text(book.title ?? 'No title'),
                subtitle: Text(book.authors ?? 'Unknown Author'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite),
                  color: controller.value.any((b) => b.id == book.id)
                      ? Colors.red
                      : Colors.grey,
                  onPressed: () => controller.toggleFavorite(BookModel(
                      id: book.id,
                      title: book.title,
                      authors: [book.authors ?? "Unknown"],
                      thumbnail: book.thumbnail)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
