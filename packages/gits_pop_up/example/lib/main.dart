import 'package:flutter/material.dart';
import 'package:gits_pop_up/gits_pop_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gits Pop Up Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      builder: (context, child) {
        GitsPopUpSettings(
          blackColor: const Color(0xFF000000),
          whiteColor: const Color(0xFFFFFFFF),
        );
        return gitsPopUpInit(context, child);
      },
      navigatorObservers: [GitsPopUpNavigatorObserver()],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Gits Pop Up Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Show Notif"),
                onPressed: () => GitsPopUp.showNotif(
                      title: "Title",
                    )),
          ),
          Center(
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Show Success Notif"),
                onPressed: () => GitsPopUp.showSuccessNotif(
                      title: "Title Success",
                      subtitle: "Subtitle Success",
                    )),
          ),
          Center(
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Show Info Notif"),
                onPressed: () => GitsPopUp.showInfoNotif(
                      title: "Test Info",
                      subtitle: "Subtitle Info",
                    )),
          ),
          Center(
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Show Warning Notif"),
                onPressed: () => GitsPopUp.showWarningNotif(
                      title: "Test Warning",
                      subtitle: "Subtitle Warning",
                    )),
          ),
          Center(
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Show Danger Notif"),
                onPressed: () => GitsPopUp.showDangerNotif(
                      title: "Test Danger",
                      subtitle: "Subtitle Danger",
                    )),
          ),
          Center(
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child:
                    const Text("Show Danger Notif (Hide Leading And Trailing)"),
                onPressed: () => GitsPopUp.showDangerNotif(
                    title: "Test Danger",
                    subtitle: "Subtitle Danger",
                    showLeading: false,
                    showTrailing: false)),
          ),
        ],
      ),
    );
  }
}
