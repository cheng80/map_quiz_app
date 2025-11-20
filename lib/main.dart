//main.dart

import 'package:flutter/material.dart';

import 'package:map_quiz_app/view/home.dart';
//import 'package:프로젝트명/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  
  changeThemeMode(ThemeMode themeMode){
    _themeMode = themeMode;
    
    setState(() {});
  }

  getTheme(){
    return _themeMode;
  } 
  

  static const Color seedColor = Colors.white;
  

  @override
  void initState() { //페이지가 새로 생성 될때 무조건 1번 사용 됨
    super.initState();
    
  }
  
  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: seedColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: seedColor,
      ),
      debugShowCheckedModeBanner: false, // 우측 상단 디버그 배너 제거
      home: Home(
        onChangeThemeMode: changeThemeMode,
        getTheme: getTheme,
      ),
      
    
    );

  }
}