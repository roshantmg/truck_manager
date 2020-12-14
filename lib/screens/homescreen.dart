import 'package:flutter/material.dart';
import 'package:tipper_system/screens/about_screen.dart';
import 'package:tipper_system/widgets/category_widget.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HOME SCREEN';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipper Manager'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('CompanyName'),
                accountEmail: Text('e-mail'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share App'),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Rate App'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AboutScreen();
                  }));
                },
                leading: Icon(Icons.new_releases),
                title: Text('About App'),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/tipperpic.jpg'),
              height: MediaQuery.of(context).size.height / 3.2,
              fit: BoxFit.contain,
            ),
            CategoryWidget(),
            Card(
                color: Colors.blue[100],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.mail,
                          size: 50.0,
                        ),
                        Text('Mail'),
                      ],
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_activity,
                          size: 50.0,
                        ),
                        Text('Sales Activity'),
                      ],
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.view_week,
                          size: 50.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('The detail summary of the company.')
                          ],
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
