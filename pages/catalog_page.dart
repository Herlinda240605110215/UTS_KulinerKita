import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu.dart';
import 'detail_page.dart';

class CatalogPage extends StatefulWidget {
  final String? kategoriAwal;

  const CatalogPage({
    super.key,
    this.kategoriAwal,
  });

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String kategoriDipilih = 'Semua';

  @override
  void initState() {
    super.initState();
    kategoriDipilih = widget.kategoriAwal ?? 'Semua';
  }

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final List<Menu> menuTampil = daftarMenu.where((menu) {
      return kategoriDipilih == 'Semua' ||
          menu.kategori == kategoriDipilih;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        title: const Text(
          'Katalog Kuliner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Text(
              'Pilih menu favoritmu!',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),

          // Filter kategori
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _tombolKategori('Semua'),
                _tombolKategori('Mie'),
                _tombolKategori('Dimsum'),
                _tombolKategori('Minuman'),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${menuTampil.length} menu tersedia',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF38291F),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: menuTampil.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final menu = menuTampil[index];
                return _kartuMenu(menu);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tombolKategori(String nama) {
    final bool aktif = kategoriDipilih == nama;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(nama),
        selected: aktif,
        selectedColor: const Color(0xFFF26B38),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: aktif ? Colors.white : const Color(0xFF38291F),
          fontWeight: FontWeight.w600,
        ),
        onSelected: (selected) {
          setState(() {
            kategoriDipilih = nama;
          });
        },
      ),
    );
  }

  Widget _kartuMenu(Menu menu) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(menu: menu),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  menu.gambar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFFFE0D2),
                      child: const Center(
                        child: Icon(
                          Icons.restaurant,
                          color: Color(0xFFF26B38),
                          size: 45,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF38291F),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    menu.kategori,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    formatRupiah(menu.harga),
                    style: const TextStyle(
                      color: Color(0xFFF26B38),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
