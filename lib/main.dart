import 'package:flutter/material.dart';
import 'package:news_app_flutter/screens/home.screen.dart';
import 'package:news_app_flutter/store/NewsStore/NewsStore.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Provider<NewsStore>.value(value: NewsStore()),
        Provider(
          create: (_) => NewsStore()
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter News Example',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xff000a12),
            appBarTheme: AppBarTheme(
              color: Color(0xff102027),  
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white)
            )
          ),
          home: HomeScreen(),
      ),
    );
  }
}
