import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: KalkulatorPage(), // Halaman utama
    );
  }
}

// Halaman kalkulator menggunakan class kalkulatorpage extends StatefulWidget
class KalkulatorPage extends StatefulWidget {
  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {

  // Controller untuk mengambil input angka dari TextField
  TextEditingController angka1 = TextEditingController();
  TextEditingController angka2 = TextEditingController();

  // Variabel pilihan operasi secara default
  String operasi = "Tambah";

  // Variabel hasil output kalkulator
  String hasil = "";

  // Fungsi penjumlahan
  double tambah(double a, double b) => a + b;

  // Fungsi pengurangan
  double kurang(double a, double b) => a - b;

  // Fungsi perkalian
  double kali(double a, double b) => a * b;

  // Fungsi pembagian
  double bagi(double a, double b) => a / b;

  // Fungsi saat tombol Hitung ditekan
  void hitung() {
    setState(() {

      // Validasi jika input kosong
      if (angka1.text.isEmpty || angka2.text.isEmpty) {
        hasil = "Input tidak boleh kosong";
        return;
      }

      // Mengubah input text menjadi angka desimal
      double? a = double.tryParse(angka1.text);
      double? b = double.tryParse(angka2.text);

      // Validasi jika bukan angka yang diinput
      if (a == null || b == null) {
        hasil = "Input harus berupa angka";
        return;
      }

      double total = 0;

      // Mengecek operasi yang dipilih
      if (operasi == "Tambah") {
        total = tambah(a, b);
      }
      else if (operasi == "Kurang") {
        total = kurang(a, b);
      }
      else if (operasi == "Kali") {
        total = kali(a, b);
      }
      else if (operasi == "Bagi") {

        // Validasi pembagian dengan angka nol
        if (b == 0) {
          hasil = "Tidak dapat membagi dengan nol";
          return;
        }

        total = bagi(a, b);
      }

      // Menampilkan hasil perhitungan kalkulator
      hasil = "Hasil = $total";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator Sederhana"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            // Input angka pertama
            TextField(
              controller: angka1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan angka pertama",
              ),
            ),

            SizedBox(height: 10),

            // Input angka kedua
            TextField(
              controller: angka2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan angka kedua",
              ),
            ),

            SizedBox(height: 10),

            // Menu Dropdown pilihan operasi
            DropdownButton(
              value: operasi,
              items: [
                DropdownMenuItem(
                  value: "Tambah",
                  child: Text("Tambah"),
                ),
                DropdownMenuItem(
                  value: "Kurang",
                  child: Text("Kurang"),
                ),
                DropdownMenuItem(
                  value: "Kali",
                  child: Text("Kali"),
                ),
                DropdownMenuItem(
                  value: "Bagi",
                  child: Text("Bagi"),
                ),
              ],

              // Proses Saat user memilih operasi
              onChanged: (value) {
                setState(() {
                  operasi = value!;
                });
              },
            ),

            SizedBox(height: 10),

            // Code Tombol hitung
            ElevatedButton(
              onPressed: hitung,
              child: Text("Hitung"),
            ),

            SizedBox(height: 20),

            // Menampilkan hasil teks dengan font sizq 22 bold
            Text(
              hasil,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}