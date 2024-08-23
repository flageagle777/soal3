import 'package:flutter/material.dart';

void main() {
  runApp(NilaiSiswaApp());
}

class NilaiSiswaApp extends StatefulWidget {
  @override
  _NilaiSiswaAppState createState() => _NilaiSiswaAppState();
}

class _NilaiSiswaAppState extends State<NilaiSiswaApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelompokan Nilai Siswa',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: NilaiSiswaHomePage(
        isDarkMode: _isDarkMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }
}

class NilaiSiswaHomePage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  NilaiSiswaHomePage({required this.isDarkMode, required this.toggleTheme});

  @override
  _NilaiSiswaHomePageState createState() => _NilaiSiswaHomePageState();
}

class _NilaiSiswaHomePageState extends State<NilaiSiswaHomePage> {
  final TextEditingController _nilaiController1 = TextEditingController();
  final TextEditingController _nilaiController2 = TextEditingController();
  final TextEditingController _nilaiController3 = TextEditingController();
  final TextEditingController _nilaiController4 = TextEditingController();
  String _hasilKategori = '';
  String _rataRata = '';

  void _hitungKategori() {
    setState(() {
      final nilai1 = int.tryParse(_nilaiController1.text);
      final nilai2 = int.tryParse(_nilaiController2.text);
      final nilai3 = int.tryParse(_nilaiController3.text);
      final nilai4 = int.tryParse(_nilaiController4.text);

      if (_nilaiController1.text.isEmpty || _nilaiController2.text.isEmpty || _nilaiController3.text.isEmpty || _nilaiController4.text.isEmpty) {
        _hasilKategori = 'Tidak ada nilai. Masukkan nilai antara 0-100.';
        _rataRata = '';
      } else if (nilai1 == null || nilai2 == null || nilai3 == null || nilai4 == null ||
                 nilai1 < 0 || nilai2 < 0 || nilai3 < 0 || nilai4 < 0 ||
                 nilai1 > 100 || nilai2 > 100 || nilai3 > 100 || nilai4 > 100) {
        _hasilKategori = 'Nilai tidak valid. Masukkan nilai antara 0 - 100.';
        _rataRata = '';
      } else {
        final rataRataNilai = (nilai1 + nilai2 + nilai3 + nilai4) / 4;
        _rataRata = 'Rata-rata: ${rataRataNilai.toStringAsFixed(2)}';

        if (rataRataNilai >= 85 && rataRataNilai <= 100) {
          _hasilKategori = 'Kategori A';
        } else if (rataRataNilai >= 70 && rataRataNilai <= 84) {
          _hasilKategori = 'Kategori B';
        } else if (rataRataNilai >= 55 && rataRataNilai <= 69) {
          _hasilKategori = 'Kategori C';
        } else {
          _hasilKategori = 'Kategori D';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelompokan Nilai Siswa'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.toggleTheme,
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nilaiController1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Siswa 1',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nilaiController2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Siswa 2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nilaiController3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Siswa 3',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nilaiController4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Siswa 4',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _hitungKategori,
              child: Text('Hitung'),
            ),
            SizedBox(height: 30),
            Text(
              _hasilKategori,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _rataRata,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}