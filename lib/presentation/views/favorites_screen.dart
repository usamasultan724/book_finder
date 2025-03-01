import 'package:book_finder/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/favorites_controller.dart';
import '../widgets/book_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FavoritesController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ValueListenableBuilder<List<BookModel>>(
        valueListenable: controller,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) => BookCard(book: favorites[index]),
          );
        },
      ),
    );
  }
}