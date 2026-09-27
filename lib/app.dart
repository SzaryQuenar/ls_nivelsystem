import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<
        ThemeMode>(
      valueListenable:
          themeModeNotifier,
      builder: (
        context,
        mode,
        child,
      ) {
        return MaterialApp(
          title: 'Niwelacja Terenu',
          debugShowCheckedModeBanner:
              false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: const HomeScreen(),
        );
      },
    );
  }
}