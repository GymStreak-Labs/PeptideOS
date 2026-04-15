import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/theme.dart';
import 'app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait — peptide tracking is a focused, one-hand experience.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Dark status bar icons on dark background.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const PeptideOSApp());
}

class PeptideOSApp extends StatelessWidget {
  const PeptideOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeptideOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const AppShell(),
    );
  }
}
