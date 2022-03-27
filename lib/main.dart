import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:search/screens/screens.dart';
import 'package:search/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientesService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'cliente': (_) => ClienteScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.grey),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.grey, elevation: 0)),
    );
  }
}
