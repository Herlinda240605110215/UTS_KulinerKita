import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu.dart';
import 'catalog_page.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color oranye = Color(0xFFF26B38);
  static const Color krem = Color(0xFFFFF8F0);
  static const Color cokelat = Color(0xFF38291F);

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final List<Menu> rekomendasi = daftarMenu.take(4).toList();

    return Scaffold(
      backgroundColor: krem,
      appBar: AppBar(
        backgroundColor: krem,
        title: const Row(
          children: [
            Icon(Icons.restaurant_menu, color: oranye, size: 30),
            SizedBox(width: 8),
            Text(
              'KulinerKita',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cokelat,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yuk Pecinta Kuliner!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: cokelat,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'By Herlinda!',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 22),

            // Banner utama
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF26B38),
                    Color(0xFFE84D27),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 38,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'YUK GACORIN!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Jelajahi menu mie, dimsum,\ndan minuman favoritmu.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.ramen_dining,
                      color: Colors.white,
                      size: 65,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Kategori
            const Text(
              'Best Seller',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: cokelat,
              ),
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _kategoriCard(
                    icon: Icons.ramen_dining,
                    nama: 'Mie',
                    warna: const Color(0xFFFFE0D2),
                    onTap: () => bukaKatalog(context, 'Mie'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _kategoriCard(
                    icon: Icons.tapas,
                    nama: 'Dimsum',
                    warna: const Color(0xFFFFEBC4),
                    onTap: () => bukaKatalog(context, 'Dimsum'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _kategoriCard(
                    icon: Icons.local_cafe,
                    nama: 'Minuman',
                    warna: const Color(0xFFDDF0DE),
                    onTap: () => bukaKatalog(context, 'Minuman'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Menu Favorit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cokelat,
                  ),
                ),
                TextButton(
                  onPressed: () => bukaKatalog(context, null),
                  child: const Text('Lihat semua'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...rekomendasi.map((menu) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _menuCard(context, menu),
              );
            }),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => bukaKatalog(context, null),
                style: ElevatedButton.styleFrom(
                  backgroundColor: oranye,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Jelajahi Semua Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bukaKatalog(BuildContext context, String? kategori) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CatalogPage(kategoriAwal: kategori),
      ),
    );
  }

  Widget _kategoriCard({
    required IconData icon,
    required String nama,
    required Color warna,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
        decoration: BoxDecoration(
          color: warna,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: cokelat),
            const SizedBox(height: 8),
            Text(
              nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: cokelat,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, Menu menu) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(menu: menu),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                menu.gambar,
                width: 95,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 95,
                    height: 90,
                    color: const Color(0xFFFFE0D2),
                    child: const Icon(
                      Icons.restaurant,
                      color: oranye,
                      size: 35,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: cokelat,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    menu.kategori,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(menu.harga),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: oranye,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: oranye),
          ],
        ),
      ),
    );
  }
}
