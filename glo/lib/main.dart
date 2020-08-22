import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:torch_compat/torch_compat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
      theme: ThemeData(
        primaryColor: Colors.red,
        // fontFamily: 'Rowdies',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new MyPagetwo(),
        image: Image.asset(
            'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        loaderColor: Colors.black);
  }
}

class MyPagetwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

// ignore: must_be_immutable
class MyPageState extends State<MyPagetwo> {
  int isSelected = 0;

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    // Mandatory for Camera 1 on Android
    TorchCompat.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
              'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  elevation: 1.0,
                  child: Icon(Icons.flash_on,
                      size: 50.0,
                      color: isSelected == 1
                          ? Colors.yellow
                          : (isSelected == 0 ? Colors.white : Colors.yellow)),
                  padding: EdgeInsets.all(25.0),
                  shape: CircleBorder(),
                  fillColor: isSelected == 1
                      ? Colors.white
                      : (isSelected == 0 ? Colors.black : Colors.red),
                  // onPressed: () => setState(() => isSelected = !isSelected),
                  onPressed: () {
                    // Vibrate.vibrate();
                    setState(() {
                      isSelected++;
                      if (isSelected == 3) {
                        isSelected = 0;
                      }
                    });
                    if (isSelected == 1) {
                      TorchCompat.turnOn();
                    } else if (isSelected == 2) {
                      // while(1 != null)
                      // {
                      bool status = true;
                      Timer.periodic(Duration(milliseconds: 200), (timer) {
                        status = !status;
                        if (isSelected == 2) {
                          if (status)
                            TorchCompat.turnOn();
                          else
                            TorchCompat.turnOff();
                        } else
                          timer.cancel();
                      });
                      // }
                    } else if (isSelected == 0) {
                      TorchCompat.turnOff();
                    }
                  },
                )
              ]),
        ));
  }
}
//the end