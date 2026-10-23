import '../models/menu.dart';

class CartData {
  static final Map<Menu, int> items = {};

  static void tambah(Menu menu, int jumlah) {
    items[menu] = (items[menu] ?? 0) + jumlah;
  }

  static void ubahJumlah(Menu menu, int jumlah) {
    if (jumlah <= 0) {
      items.remove(menu);
    } else {
      items[menu] = jumlah;
    }
  }

  static int get totalItem =>
      items.values.fold(0, (total, jumlah) => total + jumlah);

  static int get totalHarga => items.entries.fold(
    0,
        (total, item) => total + item.key.harga * item.value,
  );

  static void kosongkan() {
    items.clear();
  }
}
