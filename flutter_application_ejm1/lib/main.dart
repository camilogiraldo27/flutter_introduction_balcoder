import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'COVID-19 prueba'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(IconData(62906, fontFamily: 'MaterialIcons')),
              title: Text("Inicio"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(IconData(0xe755, fontFamily: 'MaterialIcons')),
              title: Text("Añadir tareas"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(IconData(0xf560, fontFamily: 'MaterialIcons')),
              title: Text("Tareas"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons')),
              title: Text("Cerrar sesion"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              height: 120,
              width: 400,
              color: Colors.blue,
              child: Icon(Icons.home, color: Colors.deepOrange),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
