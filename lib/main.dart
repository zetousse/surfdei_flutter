import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surfdei',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;

  void getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    if (!await Geolocator.isLocationServiceEnabled()) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("From Current position, $position");

    //posicion ejemplo location (Zarautz)
    var beach = "Zarautz";
    var latitudeForCalculation = 43.3019;
    var longitudeForCalculation = -2.1264;
    print(" to $beach , Latitude: $latitudeForCalculation , Longitude: $longitudeForCalculation");

    var distanceInMeters = await Geolocator.distanceBetween(
        latitudeForCalculation,
        longitudeForCalculation,
        position.latitude,
        position.longitude);

    var distance = distanceInMeters.toStringAsFixed(2);

    if (distanceInMeters < 2500) {
      print("Distance: $distance meters");
    } else {
      var distanceInKms = (distanceInMeters / 1000).toStringAsFixed(2);
      print("Distance: $distanceInKms Kilometers");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Hola Mundo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCurrentLocation,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
