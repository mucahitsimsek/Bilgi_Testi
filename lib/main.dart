import 'package:flutter/material.dart';
import 'constants.dart';
import 'test_veri.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SoruSayfasi(),
          ),
        ),
      ),
    );
  }
}

class SoruSayfasi extends StatefulWidget {
  const SoruSayfasi({Key? key}) : super(key: key);

  @override
  State<SoruSayfasi> createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];

  TestVeri test1 = TestVeri();

  void butonFonksiyonu(bool prmtr) {
    if (test1.testBitti() == true) {
      //alertDialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Testi Bitirdiniz!'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //index sıfırla
                      test1.testiSifirla();
                      //secimleri sıfırla
                      secimler = [];
                    },
                    child: const Text('Kapat'))
              ],
            );
          });
    }

    setState(() {
      test1.getSoruYaniti() == prmtr
          ? secimler.add(trueIcon)
          : secimler.add(falseIcon);
      test1.sonrakiSoru();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                test1.getSoruMetni(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 3,
          runSpacing: 3,
          children: secimler,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[400]),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12.0)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(color: Colors.white))),
                      onPressed: () {
                        butonFonksiyonu(false);
                      },
                      child: const Icon(
                        Icons.thumb_down,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[400]),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(12.0)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(color: Colors.white))),
                        onPressed: () {
                          butonFonksiyonu(true);
                        },
                        child: const Icon(
                          Icons.thumb_up,
                          size: 30.0,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
