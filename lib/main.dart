import 'package:flutter/material.dart';
import 'package:shared_preferences_unit_tests_flutter/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferencesUtil? sharedPreferencesUtil;
  int? counter;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      sharedPreferencesUtil = SharedPreferencesUtil(sharedPreferences: value);
      setState(() {
        counter = sharedPreferencesUtil!.getCount();
      });
    });
  }

  bool get isLoading => sharedPreferencesUtil == null || counter == null;

  int getCounter() {
    return sharedPreferencesUtil!.getCount();
  }

  Future<void> _incrementCounter() async {
    final int newCounter = counter! + 1;
    await sharedPreferencesUtil!.setCount(newCounter);
    setState(() {
      counter = newCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${getCounter()}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
