import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/screens/homescreen.dart';

import 'data/DBHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataCollection>(
      create: (context)=>DataCollection(),
      child: MaterialApp(
 debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
      },
      ),
     
    );
  }
}
