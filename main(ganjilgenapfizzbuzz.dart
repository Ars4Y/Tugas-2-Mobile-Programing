import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum Dart',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  String hasil = "";
  Color warna = Colors.black;

  String mode = "Ganjil Genap";

  String cekGanjilGenap(int angka) {
    if (angka % 2 == 0) {
      return "Genap";
    } else {
      return "Ganjil";
    }
  }

  String fizzBuzz(int n) {
    if (n % 3 == 0 && n % 5 == 0) {
      return "FizzBuzz";
    } else if (n % 3 == 0) {
      return "Fizz";
    } else if (n % 5 == 0) {
      return "Buzz";
    } else {
      return "$n";
    }
  }

  void proses() {
    setState(() {
      if (controller.text.isEmpty) {
        hasil = "Input tidak boleh kosong";
        warna = Colors.red;
        return;
      }

      int? angka = int.tryParse(controller.text);

      if (angka == null) {
        hasil = "Masukkan angka valid";
        warna = Colors.red;
        return;
      }

      if (mode == "Ganjil Genap") {
        hasil = cekGanjilGenap(angka);
      } else {
        hasil = fizzBuzz(angka);
      }

      warna = Colors.green;
    });
  }

  List<String> deretFizzBuzz() {
    List<String> data = [];

    for (int i = 1; i <= 20; i++) {
      data.add(fizzBuzz(i));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = deretFizzBuzz();

    return Scaffold(
      appBar: AppBar(
        title: Text("Praktikum Dart"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            DropdownButton(
              value: mode,
              items: [
                DropdownMenuItem(
                  child: Text("Ganjil Genap"),
                  value: "Ganjil Genap",
                ),
                DropdownMenuItem(
                  child: Text("FizzBuzz"),
                  value: "FizzBuzz",
                ),
              ],
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan angka",
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: proses,
              child: Text("Proses"),
            ),

            SizedBox(height: 15),

            Text(
              hasil,
              style: TextStyle(
                fontSize: 22,
                color: warna,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Deret FizzBuzz 1 - 20",
              style: TextStyle(fontSize: 18),
            ),

            Expanded(
              child: ListView.separated(
                itemCount: list.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(list[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}