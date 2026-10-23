import 'package:flutter/material.dart';
import '../data/cart_data.dart';
import '../models/menu.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    )}';
  }

  void konfirmasiPesanan() {
    if (CartData.items.isEmpty) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Pesanan'),
        content: Text(
          'Jumlah pesanan: ${CartData.totalItem} item\n'
              'Total harga: ${formatRupiah(CartData.totalHarga)}\n\n'
              'Apakah kamu yakin ingin memesan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              setState(() {
                CartData.kosongkan();
              });

              showDialog(
                context: context,
                builder: (successContext) => AlertDialog(
                  title: const Text('Pesanan Berhasil!'),
                  content: const Text(
                    'Pesanan kamu berhasil dikonfirmasi. '
                        'Terima kasih sudah memesan di KulinerKita!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(successContext);
                        Navigator.pop(context);
                      },
                      child: const Text('Selesai'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF26B38),
              foregroundColor: Colors.white,
            ),
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text(
          'Keranjang Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: CartData.items.isEmpty
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Color(0xFFF26B38),
            ),
            SizedBox(height: 16),
            Text(
              'Keranjang masih kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Yuk, pilih makanan favoritmu!'),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: CartData.items.entries.map((entry) {
                final Menu menu = entry.key;
                final int jumlah = entry.value;

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            menu.gambar,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const SizedBox(
                              width: 70,
                              height: 70,
                              child: Icon(Icons.restaurant),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(formatRupiah(menu.harga)),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        CartData.ubahJumlah(
                                          menu,
                                          jumlah - 1,
                                        );
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                  ),
                                  Text('$jumlah'),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        CartData.ubahJumlah(
                                          menu,
                                          jumlah + 1,
                                        );
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                    ),
                                    color: const Color(0xFFF26B38),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        formatRupiah(CartData.totalHarga),
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26B38),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: konfirmasiPesanan,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Konfirmasi Pesanan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF26B38),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
