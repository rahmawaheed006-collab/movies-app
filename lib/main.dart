import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ده الملف اللي flutterfire configure عمله تلقائيًا
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

Future<void> main() async {
  // لازم السطر ده قبل أي حاجة تانية علشان تقدر تستخدم Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // بيشغل الاتصال بمشروع Firebase بتاعك باستخدام الإعدادات
  // اللي اتولدت في firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}