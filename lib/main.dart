import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Appbar());
}

class Appbar extends StatelessWidget {
  const Appbar({super.key});

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
        body: const TimerApp(),
      ),
    );
  }
}

class TimerApp extends StatefulWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  bool showTextField = false; // untuk menganti jam ke mode input dan read
  bool isStarted = false; // untuk mengubah text button start atau stop
  bool isSetting = false; // untuk mengubah text atur waktu atau reset
  late Timer _timer; // variabel _timer untuk implementasi durasi bisa berjalan 
  int seconds = 0; // variabel detik
  int minutes = 0; // vaariabel menit
  int hours = 0; // variabel jam

  void startCountdown() { // function untuk menghitung mundur 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() { // untuk refresh setiap 1 detik
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

  void toggleButtonSetting() { // function untuk mengganti text di button atur waktu dan untuk reset variabel kembali 0
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
  }

  void toggleButtonStart() { // function untuk memulai perhitungan
    if (!isStarted) { // dengan memanggil function startCouuntdown
      startCountdown();
    } else {
      _timer.cancel(); // menghentikan perhitungan 
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
        body: Container(
          color: const Color.fromARGB(255, 156, 175, 170),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Row(  // berisi text penjelas waktu 
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
                  showTextField // berisi input angka dan read angka inputan
                      ? Expanded(
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            textAlign: TextAlign.center,
                            onChanged: (value) { // memasukan inputan ke variabel
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
                          "$seconds", // pemanggilan variabel 
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
                      toggleButtonSetting(); // ketika button di pencet maka akan melakukan eksekusi function
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 19),
                      backgroundColor: Color.fromARGB(255, 253, 164, 3),
                    ),
                    child: Text(
                      isSetting ? "Reset" : "Atur waktu", // teks berganti tergantung variabel bool 
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
                      toggleButtonStart(); // ketika button di pencet maka akan melakukan eksekusi function
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 15),
                      backgroundColor: isStarted ? Colors.red : Colors.green,
                    ),
                    child: Text(
                      isStarted ? "Stop" : "Start", // teks berganti tergantung variabel bool
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
