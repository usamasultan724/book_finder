import 'package:book_finder/constants/theme.dart';
import 'package:book_finder/data/local/prefs.dart';
import 'package:book_finder/data/repositories/book_repo.dart';
import 'package:book_finder/data/repositories/fav_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';
import 'data/local/database_helper.dart';
import 'presentation/controllers/book_controller.dart';
import 'presentation/controllers/favorites_controller.dart';
import 'presentation/controllers/theme_controller.dart';
import 'presentation/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper.instance;
  final bookRepo = BookRepository();
  final favoritesRepo = FavoritesRepository(dbHelper);

  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => BookController(bookRepo)),
        ChangeNotifierProvider(
            create: (_) => FavoritesController(favoritesRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Provider.of<ThemeController>(context),
      builder: (context, isDark, _) {
        return MaterialApp(
          title: AppConstants.appName,
          theme: isDark ? AppTheme.dark : AppTheme.light,
          home: const HomeScreen(),
        );
      },
    );
  }
}
