import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatefulWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  bool showTextField = false;
  bool isStarted = false;
  bool isSetting = false;
  late Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds == 0) {
          if (minutes == 0) {
            if (hours == 0) {
              timer.cancel();
              return;
            }
            hours--;
            minutes = 59;
            seconds = 59;
          } else {
            minutes--;
            seconds = 59;
          }
        } else {
          seconds--;
        }
      });
    });
  }

  void toggleButtonSetting() {
    if (isSetting) {
      showTextField = false;
      isStarted = false;
      seconds = 0;
      minutes = 0;
      hours = 0;
    } else {
      setState(() {
        showTextField = true;
        isStarted = false;
      });
    }
    setState(() {
      isSetting = !isSetting;
    });
    ;
  }

  void toggleButtonStart() {
    if (!isStarted) {
      startCountdown();
    } else {
      _timer.cancel();
    }
    setState(() {
      isStarted = !isStarted;
      showTextField = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 44, 120, 101),
          centerTitle: true,
          title: const Text(
            "T I M E R",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.bold),
            selectionColor: Colors.white,
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 156, 175, 170),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Hours"),
                  Text(" "),
                  Text("Minutes"),
                  Text(""),
                  Text("Seconds"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  showTextField
                      ? Expanded(
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              hours = int.tryParse(value) ?? 00;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'HH',
                            ),
                          ),
                        )
                      : Text(
                          "$hours",
                          style: const TextStyle(
                              fontFamily: "DS-DIGIB",
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                  const Text(":"),
                  showTextField
                      ? Expanded(
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              minutes = int.tryParse(value) ?? 00;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'HH',
                            ),
                          ),
                        )
                      : Text(
                          "$minutes",
                          style: const TextStyle(
                              fontFamily: "DS-DIGIB",
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                  const Text(":"),
                  showTextField
                      ? Expanded(
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              seconds = int.tryParse(value) ?? 00;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'HH',
                            ),
                          ),
                        )
                      : Text(
                          "$seconds",
                          style: const TextStyle(
                              fontFamily: "DS-DIGIB",
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
              const SizedBox(
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      toggleButtonSetting();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 19),
                      backgroundColor: Color.fromARGB(255, 253, 164, 3),
                    ),
                    child: Text(
                      isSetting ? "Reset" : "Atur waktu",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      toggleButtonStart();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 15),
                      backgroundColor: isStarted ? Colors.red : Colors.green,
                    ),
                    child: Text(
                      isStarted ? "Stop" : "Start",
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
