import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutlu_solar_application/control_panel/Services/auth_service.dart';
import 'package:kutlu_solar_application/control_panel/Screens/login_screen.dart';
import 'package:kutlu_solar_application/control_panel/Screens/product_list_screen.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure that plugin services are initialized
  // before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://yzhixdbgaoncimhahnvo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6aGl4ZGJnYW9uY2ltaGFobnZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0NzcxMTAsImV4cCI6MjA2MzA1MzExMH0.sKfUh-tzwXuUFyEVxvQOSZPOUSiwq8xPwJEnV69g5F0',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (_) => AuthService(),
    builder: (context, child) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              FlutterQuillLocalizations.delegate,
            ],
            title: 'Admin Panel',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.blue),
                titleTextStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
            home: StreamBuilder<AuthState>(
              stream: Provider.of<AuthService>(context).authStateChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasData && snapshot.data?.session != null) {
                  return const ProductListScreen();
                }

                return const LoginScreen();
              },
            ),
          );
        },
      );
    },
  );
}
}