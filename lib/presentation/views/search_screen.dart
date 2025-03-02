import 'package:book_finder/data/api_response.dart';
import 'package:book_finder/data/models/book_model.dart';
import 'package:book_finder/presentation/controllers/theme_controller.dart';
import 'package:book_finder/presentation/widgets/search_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/book_controller.dart';
import '../widgets/book_card.dart';
import '../widgets/loading_indicator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context);
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 50),
        SearchBarWithThemeToggle(
          controller: _controller,
          bookController: bookController,
          themeController: themeController,
        ),
        Expanded(
          child: ValueListenableBuilder<ApiResponse<List<BookModel>>>(
            valueListenable: bookController,
            builder: (context, response, _) {
              if (response.status == Status.loading) {
                return const LoadingIndicator();
              } else if (response.status == Status.error) {
                return Center(child: Text('Error: ${response.message}'));
              } else if (response.data == null || response.data!.isEmpty) {
                return const Center(child: Text('No data'));
              }

              return ListView.builder(
                itemCount: response.data!.length,
                itemBuilder: (context, index) =>
                    BookCard(book: response.data![index]),
              );
            },
          ),
        ),
      ],
    ));
  }
}
