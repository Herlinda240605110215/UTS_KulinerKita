import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../data/cart_data.dart';
import 'cart_page.dart';

class DetailPage extends StatefulWidget {
  final Menu menu;

  const DetailPage({
    super.key,
    required this.menu,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int jumlah = 1;
  int levelDipilih = 1;

  @override
  void initState() {
    super.initState();

    final nama = widget.menu.nama.toLowerCase();

    if (nama.contains('lv 6-8') ||
        nama.contains('lv 6–8')) {
      levelDipilih = 6;
    } else if (nama.contains('lv 0-4') ||
        nama.contains('lv 0–4')) {
      levelDipilih = 0;
    } else {
      levelDipilih = 1;
    }
  }

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    )}';
  }

  bool get punyaPilihanLevel {
    final nama = widget.menu.nama.toLowerCase();

    return nama.contains('hompimpa') ||
        nama.contains('gacoan') ||
        nama.contains('setan');
  }

  List<int> get daftarLevel {
    final nama = widget.menu.nama.toLowerCase();

    if (nama.contains('lv 0-4') ||
        nama.contains('lv 0–4')) {
      return [0, 1, 2, 3, 4];
    }

    if (nama.contains('lv 1-4') ||
        nama.contains('lv 1–4')) {
      return [1, 2, 3, 4];
    }

    if (nama.contains('lv 6-8') ||
        nama.contains('lv 6–8')) {
      return [6, 7, 8];
    }

    return [];
  }

  void tambahKeKeranjang() {
    CartData.tambah(widget.menu, jumlah);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          punyaPilihanLevel && daftarLevel.isNotEmpty
              ? '${widget.menu.nama} Level $levelDipilih berhasil ditambahkan!'
              : '${widget.menu.nama} berhasil ditambahkan ke keranjang!',
        ),
        backgroundColor: const Color(0xFF397447),
        action: SnackBarAction(
          label: 'LIHAT',
          textColor: Colors.white,
          onPressed: bukaKeranjang,
        ),
      ),
    );
  }

  void bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menu = widget.menu;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text(
          'Detail Kuliner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: bukaKeranjang,
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Keranjang',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  menu.gambar,
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 260,
                      width: double.infinity,
                      color: const Color(0xFFFFE1CE),
                      child: const Icon(
                        Icons.restaurant,
                        size: 90,
                        color: Color(0xFFF26B38),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE1CE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      menu.kategori,
                      style: const TextStyle(
                        color: Color(0xFFB94C20),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    menu.nama,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF38291F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatRupiah(menu.harga),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF26B38),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Tentang Menu',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF38291F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    menu.deskripsi,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.black54,
                    ),
                  ),

                  // PILIHAN LEVEL PEDAS
                  if (punyaPilihanLevel &&
                      daftarLevel.isNotEmpty) ...[
                    const SizedBox(height: 26),
                    const Text(
                      'Pilih Level Pedas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF38291F),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Pilih tingkat kepedasan sesuai selera kamu.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: daftarLevel.map((level) {
                        final terpilih =
                            levelDipilih == level;

                        return ChoiceChip(
                          label: Text('Level $level'),
                          selected: terpilih,
                          selectedColor:
                          const Color(0xFFF26B38),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: terpilih
                                ? Colors.white
                                : const Color(0xFF38291F),
                            fontWeight: FontWeight.bold,
                          ),
                          side: const BorderSide(
                            color: Color(0xFFF26B38),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              levelDipilih = level;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 26),
                  const Text(
                    'Jumlah Pesanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF38291F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: jumlah > 1
                            ? () => setState(() => jumlah--)
                            : null,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                        iconSize: 30,
                      ),
                      Text(
                        '$jumlah',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            jumlah++;
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                        ),
                        iconSize: 30,
                        color: const Color(0xFFF26B38),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Text(
                          formatRupiah(menu.harga * jumlah),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF26B38),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: tambahKeKeranjang,
                      icon: const Icon(
                        Icons.add_shopping_cart,
                      ),
                      label: const Text(
                        'Tambah ke Keranjang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF26B38),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: bukaKeranjang,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                      label: const Text('Lihat Keranjang'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFF26B38),
                        side: const BorderSide(
                          color: Color(0xFFF26B38),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Kembali ke Menu'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
