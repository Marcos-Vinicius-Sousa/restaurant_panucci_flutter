import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:panucci_ristorante/firebase_messaging/custom_firebase_messaging.dart';
import 'package:panucci_ristorante/remote_config/custom_remote_config.dart';
import 'package:panucci_ristorante/remote_config/custom_visible_widget.dart';
import 'package:panucci_ristorante/screens/highlights.dart';
import 'package:panucci_ristorante/screens/home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CustomFirebaseMessaging().inicialize();
  await CustomFirebaseMessaging().getTokenFirebase();
  await Firebase.initializeApp();
  await CustomRemoteConfig().initialize();
  runApp(PanucciRistorante());
}

class PanucciRistorante extends StatefulWidget {
  @override
  _PanucciRistoranteState createState() => _PanucciRistoranteState();
}

class _PanucciRistoranteState extends State<PanucciRistorante> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    CustomRemoteConfig().forceFetch();
    fetchRemoteConfig();
    print(isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Panucci Ristorante",
      navigatorKey: navigatorKey,
      theme: ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true),
      darkTheme: isDarkTheme
          ? ThemeData.dark()
          : ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true),
      initialRoute: '/myhome',
      routes: {
        '/home': (_) => const Home(),
        '/menu': (_) => const HighLights(),
        '/myhome': (_) => const MyHomePage()
      },
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }

  Future<bool> fetchRemoteConfig() async {
    setState(() {
      isDarkTheme = CustomRemoteConfig().getValueOrDefault(
        key: 'isActiveThemeDark',
        defaultValue: false,
      );
    });
    return isDarkTheme;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  void _incrementCounter() async {
    setState(() => isLoading = true);
    await CustomRemoteConfig().forceFetch();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote"),
        backgroundColor: CustomRemoteConfig().getValueOrDefault(
          key: 'isActiveThemeDark',
          defaultValue: false,
        )
            ? Colors.blue
            : Colors.red,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomVisibleRCWidget(
                      rmKey: 'show_container',
                      defaultValue: false,
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.indigo,
                      ),
                    )
                  ]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
