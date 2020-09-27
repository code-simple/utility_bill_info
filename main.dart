import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(MaterialApp(
    home: FutureProvider<Txtclass>(
      initialData: Txtclass(mytxt: 'new data'),
      create: (context) => callmyclass(),
      child: Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var cntxt = Provider.of<Txtclass>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(cntxt.mytxt),
          FlatButton(onPressed: () => cntxt.sometext(), child: Text('Press'))
        ],
      ),
    ));
  }
}

class Txtclass with ChangeNotifier {
  String mytxt;
  Txtclass({this.mytxt});
  Future<void> sometext() async {
    await Future.delayed(Duration(seconds: 3), () {
      mytxt = 'my text after 3 seconds';
    });
  }
}

Future<Txtclass> callmyclass() async {
  return Txtclass(mytxt: 'my data');
}
