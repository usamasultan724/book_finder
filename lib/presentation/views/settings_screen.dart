import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ValueListenableBuilder<bool>(
        valueListenable: controller,
        builder: (context, isDark, _) {
          return SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (value) => controller.toggleTheme(),
          );
        },
      ),
    );
  }
}