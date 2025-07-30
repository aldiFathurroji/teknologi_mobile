import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/kategori_page.dart';
import 'pages/upload_barang_page.dart';
import 'pages/akun_page.dart';
import 'book.dart';
import 'kategori_detail_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final Set<String> _favoriteIsbns = {};
  final List<Buku> _keranjang = [];

  List<Map<String, dynamic>> dataBuku = [];
  late List<Buku> daftarBuku = [];

  static const String _fileName = 'buku_data.json';

  @override
  void initState() {
    super.initState();
    _loadDataBuku();
  }

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  Future<void> _loadDataBuku() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonStr);
        setState(() {
          dataBuku = List<Map<String, dynamic>>.from(jsonList);
          daftarBuku = dataBuku.map((e) => Buku.fromJson(e)).toList();
        });
      } else {
        // Data default jika file belum ada
        dataBuku = [
          {
            "gambar": "https://www.grobmart.com/image/cache/catalog/0produk0/201905/9786024410209-550x550h.jpg",
            "judul": "Dunia Sophie",
            "penulis": "Jostein Gaarder",
            "penerbit": "Mizan Pustaka",
            "tahun": 1996,
            "isbn": "978-979-433-125-9",
            "harga": 99000,
            "tipe": "Baru",
            "kategori": "Filsafat, Novel",
            "pendahuluan": "Sebuah novel pengantar filsafat yang dikemas dalam cerita misteri yang menarik.",
            "isi": "Mengisahkan tentang Sophie Amundsen, seorang gadis remaja yang tiba-tiba menerima surat-surat misterius berisi pertanyaan filosofis. Melalui surat-surat tersebut, ia memulai perjalanan menelusuri sejarah filsafat Barat.",
            "penutup": "Sangat direkomendasikan bagi yang ingin mulai belajar filsafat dengan cara yang menyenangkan.",
          },
          {
            "gambar": "https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/img20220830_10560995.jpg",
            "judul": "Bumi",
            "penulis": "Tere Liye",
            "penerbit": "Gramedia Pustaka Utama",
            "tahun": 2014,
            "isbn": "978-602-030-891-9",
            "harga": 88000,
            "tipe": "Baru",
            "kategori": "Fantasi, Petualangan",
            "pendahuluan": "Buku pertama dari serial fantasi populer 'Bumi' yang memperkenalkan dunia paralel yang menakjubkan.",
            "isi": "Menceritakan petualangan tiga remaja bernama Raib, Seli, dan Ali yang menemukan bahwa mereka memiliki kekuatan unik dan tanpa sengaja memasuki dunia paralel bernama Klan Bulan.",
            "penutup": "Pembuka seri yang mendebarkan, cocok untuk segala usia yang menyukai cerita fantasi dan persahabatan.",
          },
          {
            "gambar": "https://upload.wikimedia.org/wikipedia/id/8/8e/Laskar_pelangi_sampul.jpg",
            "judul": "Laskar Pelangi",
            "penulis": "Andrea Hirata",
            "penerbit": "Bentang Pustaka",
            "tahun": 2005,
            "isbn": "979-3062-79-7",
            "harga": 75000,
            "tipe": "Baru",
            "kategori": "Novel, Inspiratif",
            "pendahuluan": "Kisah nyata yang mengharukan tentang perjuangan sekelompok anak di Belitung untuk mendapatkan pendidikan.",
            "isi": "Berlatar di sebuah sekolah Muhammadiyah di pulau Belitung yang terancam bubar. Kisah ini berpusat pada Ikal dan sembilan temannya, serta dua guru mereka yang berdedikasi tinggi demi terus bersekolah.",
            "penutup": "Novel inspiratif yang merayakan semangat, persahabatan, dan pentingnya pendidikan.",
          },
          {
            "gambar": "https://images-na.ssl-images-amazon.com/images/I/81WcnNQ-TBL.jpg",
            "judul": "Sapiens: A Brief History of Humankind",
            "penulis": "Yuval Noah Harari",
            "penerbit": "KPG (Kepustakaan Populer Gramedia)",
            "tahun": 2017,
            "isbn": "978-602-424-416-3",
            "harga": 125000,
            "tipe": "Baru",
            "kategori": "Sejarah, Sains",
            "pendahuluan": "Sebuah buku ambisius yang merangkum keseluruhan sejarah manusia dalam satu narasi besar.",
            "isi": "Menjelajahi bagaimana Homo Sapiens berhasil mendominasi planet ini. Buku ini membahas revolusi kognitif, agrikultur, hingga revolusi ilmiah yang membentuk peradaban, masyarakat, dan dunia modern.",
            "penutup": "Buku yang provokatif dan mencerahkan, mengubah cara pandang kita terhadap sejarah umat manusia.",
          },
          {
            "gambar": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=400&q=80",
            "judul": "Atomic Habits",
            "penulis": "James Clear",
            "penerbit": "Gramedia Pustaka Utama",
            "tahun": 2019,
            "isbn": "978-602-062-325-9",
            "harga": 108000,
            "tipe": "Baru",
            "kategori": "Pengembangan Diri",
            "pendahuluan": "Panduan praktis tentang cara membangun kebiasaan baik dan menghilangkan kebiasaan buruk.",
            "isi": "James Clear menyajikan kerangka kerja berbasis bukti untuk perbaikan diri setiap hari. Buku ini mengajarkan bagaimana perubahan-perubahan kecil (sebesar atom) dapat menghasilkan dampak yang luar biasa dari waktu ke waktu.",
            "penutup": "Wajib dibaca bagi siapa pun yang ingin mencapai tujuannya melalui pembentukan kebiasaan positif.",
          },
          {
            "gambar": "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80",
            "judul": "Cantik Itu Luka",
            "penulis": "Eka Kurniawan",
            "penerbit": "Gramedia Pustaka Utama",
            "tahun": 2002,
            "isbn": "978-602-032-470-4",
            "harga": 115000,
            "tipe": "Baru",
            "kategori": "Fiksi Sejarah, Sastra",
            "pendahuluan": "Sebuah epik keluarga yang memadukan sejarah Indonesia dengan mitos, surealisme, dan tragedi.",
            "isi": "Kisah ini berpusat pada Dewi Ayu, seorang pelacur legendaris, dan anak-anaknya. Latar belakangnya adalah sejarah kelam Indonesia dari era kolonial Belanda hingga masa Orde Baru, diceritakan dengan gaya realisme magis.",
            "penutup": "Karya sastra Indonesia modern yang diakui secara internasional dan memukau pembacanya.",
          },
          {
            "gambar": "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80",
            "judul": "Laut Bercerita",
            "penulis": "Leila S. Chudori",
            "penerbit": "KPG (Kepustakaan Populer Gramedia)",
            "tahun": 2017,
            "isbn": "978-602-424-694-5",
            "harga": 90000,
            "tipe": "Baru",
            "kategori": "Fiksi Sejarah, Novel",
            "pendahuluan": "Novel yang menyuarakan kisah para aktivis yang hilang pada masa Orde Baru.",
            "isi": "Terbagi menjadi dua sudut pandang: Biru Laut, seorang mahasiswa aktivis yang diculik, dan Asmara, adik Laut yang mencari kebenaran. Novel ini menggambarkan kekejaman rezim, perjuangan, dan duka keluarga korban.",
            "penutup": "Kisah yang kuat dan menyentuh tentang sebuah periode gelap dalam sejarah Indonesia.",
          },
          {
            "gambar": "https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80",
            "judul": "Gadis Kretek",
            "penulis": "Ratih Kumala",
            "penerbit": "Gramedia Pustaka Utama",
            "tahun": 2012,
            "isbn": "978-979-228-141-5",
            "harga": 92000,
            "tipe": "Baru",
            "kategori": "Fiksi Sejarah, Roman",
            "pendahuluan": "Kisah cinta dan persaingan bisnis yang berlatar belakang industri kretek di Indonesia.",
            "isi": "Soeraja, pemilik pabrik kretek Djagad Raja yang sekarat, memanggil nama 'Jeng Yah'. Ketiga anaknya berusaha mencari sosok misterius ini dan mengungkap rahasia bisnis serta kisah cinta masa lalu ayah mereka.",
            "penutup": "Novel yang kaya akan detail sejarah industri kretek dan dibalut dengan cerita yang memikat.",
          },
          {
            "gambar": "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=400&q=80",
            "judul": "The Psychology of Money",
            "penulis": "Morgan Housel",
            "penerbit": "Baca",
            "tahun": 2021,
            "isbn": "978-602-6486-57-7",
            "harga": 89000,
            "tipe": "Baru",
            "kategori": "Keuangan, Psikologi",
            "pendahuluan": "Buku yang membahas hubungan psikologis manusia dengan uang melalui cerita-cerita pendek.",
            "isi": "Morgan Housel menjelaskan bahwa mengelola uang tidak melulu soal apa yang Anda tahu, melainkan tentang bagaimana Anda berperilaku. Buku ini memberikan pelajaran abadi tentang kekayaan, ketamakan, dan kebahagiaan.",
            "penutup": "Wawasan penting tentang keuangan pribadi yang dapat diakses oleh semua kalangan.",
          },
          {
            "gambar": "https://inc.mizanstore.com/aassets/img/com_cart/produk/pulang-tere-liye.jpg",
            "judul": "Pulang",
            "penulis": "Leila S. Chudori",
            "penerbit": "KPG (Kepustakaan Populer Gramedia)",
            "tahun": 2012,
            "isbn": "978-979-91-0515-8",
            "harga": 95000,
            "tipe": "Baru",
            "kategori": "Fiksi Sejarah, Novel",
            "pendahuluan": "Kisah para eksil politik Indonesia pasca-peristiwa G30S yang terdampar di luar negeri.",
            "isi": "Dimas Suryo, seorang wartawan yang bertugas di luar negeri, tidak bisa pulang ke Indonesia setelah peristiwa 1965. Novel ini menyoroti kehidupan para eksil di Paris dan perjuangan anak-anak mereka memahami akar identitasnya.",
            "penutup": "Sebuah novel epik yang menyentuh tentang sejarah, cinta, keluarga, dan pencarian makna 'pulang'.",
          },
        ];
        daftarBuku = dataBuku.map((e) => Buku.fromJson(e)).toList();
        await _saveDataBuku();
        setState(() {});
      }
    } catch (e) {
      // Jika error, fallback ke data default
      dataBuku = [
        {
          "gambar": "https://www.grobmart.com/image/cache/catalog/0produk0/201905/9786024410209-550x550h.jpg",
          "judul": "Dunia Sophie",
          "penulis": "Jostein Gaarder",
          "penerbit": "Mizan Pustaka",
          "tahun": 1996,
      "isbn": "978-979-433-125-9",
          "harga": 99000,
          "tipe": "Baru",
      "kategori": "Filsafat, Novel",
          "pendahuluan": "Sebuah novel pengantar filsafat yang dikemas dalam cerita misteri yang menarik.",
          "isi": "Mengisahkan tentang Sophie Amundsen, seorang gadis remaja yang tiba-tiba menerima surat-surat misterius berisi pertanyaan filosofis. Melalui surat-surat tersebut, ia memulai perjalanan menelusuri sejarah filsafat Barat.",
          "penutup": "Sangat direkomendasikan bagi yang ingin mulai belajar filsafat dengan cara yang menyenangkan.",
        },
        {
          "gambar": "https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/img20220830_10560995.jpg",
          "judul": "Bumi",
          "penulis": "Tere Liye",
          "penerbit": "Gramedia Pustaka Utama",
          "tahun": 2014,
      "isbn": "978-602-030-891-9",
          "harga": 88000,
          "tipe": "Baru",
      "kategori": "Fantasi, Petualangan",
          "pendahuluan": "Buku pertama dari serial fantasi populer 'Bumi' yang memperkenalkan dunia paralel yang menakjubkan.",
          "isi": "Menceritakan petualangan tiga remaja bernama Raib, Seli, dan Ali yang menemukan bahwa mereka memiliki kekuatan unik dan tanpa sengaja memasuki dunia paralel bernama Klan Bulan.",
          "penutup": "Pembuka seri yang mendebarkan, cocok untuk segala usia yang menyukai cerita fantasi dan persahabatan.",
        },
        {
          "gambar": "https://upload.wikimedia.org/wikipedia/id/8/8e/Laskar_pelangi_sampul.jpg",
          "judul": "Laskar Pelangi",
          "penulis": "Andrea Hirata",
          "penerbit": "Bentang Pustaka",
          "tahun": 2005,
      "isbn": "979-3062-79-7",
          "harga": 75000,
          "tipe": "Baru",
      "kategori": "Novel, Inspiratif",
          "pendahuluan": "Kisah nyata yang mengharukan tentang perjuangan sekelompok anak di Belitung untuk mendapatkan pendidikan.",
          "isi": "Berlatar di sebuah sekolah Muhammadiyah di pulau Belitung yang terancam bubar. Kisah ini berpusat pada Ikal dan sembilan temannya, serta dua guru mereka yang berdedikasi tinggi demi terus bersekolah.",
          "penutup": "Novel inspiratif yang merayakan semangat, persahabatan, dan pentingnya pendidikan.",
        },
        {
          "gambar": "https://images-na.ssl-images-amazon.com/images/I/81WcnNQ-TBL.jpg",
          "judul": "Sapiens: A Brief History of Humankind",
          "penulis": "Yuval Noah Harari",
          "penerbit": "KPG (Kepustakaan Populer Gramedia)",
          "tahun": 2017,
      "isbn": "978-602-424-416-3",
          "harga": 125000,
          "tipe": "Baru",
      "kategori": "Sejarah, Sains",
          "pendahuluan": "Sebuah buku ambisius yang merangkum keseluruhan sejarah manusia dalam satu narasi besar.",
          "isi": "Menjelajahi bagaimana Homo Sapiens berhasil mendominasi planet ini. Buku ini membahas revolusi kognitif, agrikultur, hingga revolusi ilmiah yang membentuk peradaban, masyarakat, dan dunia modern.",
          "penutup": "Buku yang provokatif dan mencerahkan, mengubah cara pandang kita terhadap sejarah umat manusia.",
        },
        {
          "gambar": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=400&q=80",
          "judul": "Atomic Habits",
          "penulis": "James Clear",
          "penerbit": "Gramedia Pustaka Utama",
          "tahun": 2019,
      "isbn": "978-602-062-325-9",
          "harga": 108000,
          "tipe": "Baru",
      "kategori": "Pengembangan Diri",
          "pendahuluan": "Panduan praktis tentang cara membangun kebiasaan baik dan menghilangkan kebiasaan buruk.",
          "isi": "James Clear menyajikan kerangka kerja berbasis bukti untuk perbaikan diri setiap hari. Buku ini mengajarkan bagaimana perubahan-perubahan kecil (sebesar atom) dapat menghasilkan dampak yang luar biasa dari waktu ke waktu.",
          "penutup": "Wajib dibaca bagi siapa pun yang ingin mencapai tujuannya melalui pembentukan kebiasaan positif.",
        },
        {
          "gambar": "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80",
          "judul": "Cantik Itu Luka",
          "penulis": "Eka Kurniawan",
          "penerbit": "Gramedia Pustaka Utama",
          "tahun": 2002,
      "isbn": "978-602-032-470-4",
          "harga": 115000,
          "tipe": "Baru",
      "kategori": "Fiksi Sejarah, Sastra",
          "pendahuluan": "Sebuah epik keluarga yang memadukan sejarah Indonesia dengan mitos, surealisme, dan tragedi.",
          "isi": "Kisah ini berpusat pada Dewi Ayu, seorang pelacur legendaris, dan anak-anaknya. Latar belakangnya adalah sejarah kelam Indonesia dari era kolonial Belanda hingga masa Orde Baru, diceritakan dengan gaya realisme magis.",
          "penutup": "Karya sastra Indonesia modern yang diakui secara internasional dan memukau pembacanya.",
        },
        {
          "gambar": "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80",
          "judul": "Laut Bercerita",
          "penulis": "Leila S. Chudori",
          "penerbit": "KPG (Kepustakaan Populer Gramedia)",
          "tahun": 2017,
      "isbn": "978-602-424-694-5",
          "harga": 90000,
          "tipe": "Baru",
      "kategori": "Fiksi Sejarah, Novel",
          "pendahuluan": "Novel yang menyuarakan kisah para aktivis yang hilang pada masa Orde Baru.",
          "isi": "Terbagi menjadi dua sudut pandang: Biru Laut, seorang mahasiswa aktivis yang diculik, dan Asmara, adik Laut yang mencari kebenaran. Novel ini menggambarkan kekejaman rezim, perjuangan, dan duka keluarga korban.",
          "penutup": "Kisah yang kuat dan menyentuh tentang sebuah periode gelap dalam sejarah Indonesia.",
        },
        {
          "gambar": "https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80",
          "judul": "Gadis Kretek",
          "penulis": "Ratih Kumala",
          "penerbit": "Gramedia Pustaka Utama",
          "tahun": 2012,
      "isbn": "978-979-228-141-5",
          "harga": 92000,
          "tipe": "Baru",
      "kategori": "Fiksi Sejarah, Roman",
          "pendahuluan": "Kisah cinta dan persaingan bisnis yang berlatar belakang industri kretek di Indonesia.",
          "isi": "Soeraja, pemilik pabrik kretek Djagad Raja yang sekarat, memanggil nama 'Jeng Yah'. Ketiga anaknya berusaha mencari sosok misterius ini dan mengungkap rahasia bisnis serta kisah cinta masa lalu ayah mereka.",
          "penutup": "Novel yang kaya akan detail sejarah industri kretek dan dibalut dengan cerita yang memikat.",
        },
        {
          "gambar": "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=400&q=80",
          "judul": "The Psychology of Money",
          "penulis": "Morgan Housel",
          "penerbit": "Baca",
          "tahun": 2021,
      "isbn": "978-602-6486-57-7",
          "harga": 89000,
          "tipe": "Baru",
      "kategori": "Keuangan, Psikologi",
          "pendahuluan": "Buku yang membahas hubungan psikologis manusia dengan uang melalui cerita-cerita pendek.",
          "isi": "Morgan Housel menjelaskan bahwa mengelola uang tidak melulu soal apa yang Anda tahu, melainkan tentang bagaimana Anda berperilaku. Buku ini memberikan pelajaran abadi tentang kekayaan, ketamakan, dan kebahagiaan.",
          "penutup": "Wawasan penting tentang keuangan pribadi yang dapat diakses oleh semua kalangan.",
        },
        {
          "gambar": "https://inc.mizanstore.com/aassets/img/com_cart/produk/pulang-tere-liye.jpg",
          "judul": "Pulang",
          "penulis": "Leila S. Chudori",
          "penerbit": "KPG (Kepustakaan Populer Gramedia)",
          "tahun": 2012,
      "isbn": "978-979-91-0515-8",
          "harga": 95000,
          "tipe": "Baru",
      "kategori": "Fiksi Sejarah, Novel",
          "pendahuluan": "Kisah para eksil politik Indonesia pasca-peristiwa G30S yang terdampar di luar negeri.",
          "isi": "Dimas Suryo, seorang wartawan yang bertugas di luar negeri, tidak bisa pulang ke Indonesia setelah peristiwa 1965. Novel ini menyoroti kehidupan para eksil di Paris dan perjuangan anak-anak mereka memahami akar identitasnya.",
          "penutup": "Sebuah novel epik yang menyentuh tentang sejarah, cinta, keluarga, dan pencarian makna 'pulang'.",
        },
      ];
      daftarBuku = dataBuku.map((e) => Buku.fromJson(e)).toList();
      await _saveDataBuku();
      setState(() {});
    }
  }

  Future<void> _saveDataBuku() async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    final jsonStr = json.encode(dataBuku);
    await file.writeAsString(jsonStr);
  }

  void _tambahKeKeranjang(Buku buku) {
    setState(() {
      if (!_keranjang.any((b) => b.isbn == buku.isbn)) {
        _keranjang.add(buku);
      }
    });
  }

  void _hapusBuku(Buku buku) {
    setState(() {
      dataBuku.removeWhere((b) => b['isbn'] == buku.isbn);
      daftarBuku.removeWhere((b) => b.isbn == buku.isbn);
      _keranjang.removeWhere((b) => b.isbn == buku.isbn);
      _favoriteIsbns.remove(buku.isbn);
    });
    _saveDataBuku();
  }

  List<Map<String, dynamic>> get kategoriList {
    final Set<String> kategoriSet = {};
    for (final buku in daftarBuku) {
      final kategoriStr = buku.kategori;
      final kategoriList =
          kategoriStr
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toSet();
      kategoriSet.addAll(kategoriList);
    }
    final Map<String, Map<String, dynamic>> kategoriIconMap = {
      'Filsafat': {
        'icon': Icons.psychology,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Fantasi': {
        'icon': Icons.auto_awesome,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Novel': {
        'icon': Icons.menu_book,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Inspiratif': {
        'icon': Icons.emoji_objects,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Sejarah': {
        'icon': Icons.history_edu,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Sains': {
        'icon': Icons.science,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Pengembangan Diri': {
        'icon': Icons.trending_up,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Fiksi Sejarah': {
        'icon': Icons.menu_book_outlined,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Sastra': {
        'icon': Icons.edit,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Roman': {
        'icon': Icons.favorite,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Keuangan': {
        'icon': Icons.attach_money,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Psikologi': {
        'icon': Icons.psychology_alt,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
      'Petualangan': {
        'icon': Icons.travel_explore,
        'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      },
    };
    final List<String> kategoriSorted =
        kategoriSet.toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return kategoriSorted.map((k) {
      final iconData =
          kategoriIconMap[k] ??
          {
            'icon': Icons.category,
            'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
          };
      return {
        'icon': iconData['icon'],
        'label': k,
        'key': k,
        'image': iconData['image'],
      };
    }).toList();
  }

  List<Buku> get _wishlistBooks => daftarBuku.where((b) => _favoriteIsbns.contains(b.isbn)).toList();

  List<Widget> get _pages => [
    HomePage(
      books: daftarBuku,
      categories: kategoriList,
      favoriteIsbns: _favoriteIsbns,
      onToggleFavorite: (isbn) {
        setState(() {
          if (_favoriteIsbns.contains(isbn)) {
            _favoriteIsbns.remove(isbn);
          } else {
            _favoriteIsbns.add(isbn);
          }
        });
      },
      onCategoryTap: (cat) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => KategoriDetailPage(category: cat)),
        );
      },
      onAddToCart: _tambahKeKeranjang,
      onDeleteBuku: _hapusBuku,
    ),
    KategoriPage(
      categories: kategoriList,
      books: daftarBuku,
      favoriteIsbns: _favoriteIsbns,
      onToggleFavorite: (isbn) {
        setState(() {
          if (_favoriteIsbns.contains(isbn)) {
            _favoriteIsbns.remove(isbn);
          } else {
            _favoriteIsbns.add(isbn);
          }
        });
      },
    ),
    UploadBarangPage(
      onAddBuku: (bukuBaru) async {
        setState(() {
          dataBuku.add(bukuBaru);
          daftarBuku.add(Buku.fromJson(bukuBaru));
        });
        await _saveDataBuku();
      },
    ),
    AkunPage(
      onWishlistTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WishlistPage(wishlist: _wishlistBooks),
          ),
        );
      },
    ),
  ];

  // Ekspor data buku ke file eksternal
  Future<void> _exportDataBuku() async {
    bool dialogShown = false;
    try {
      Future.microtask(() async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
        dialogShown = true;
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/buku_data_export.json';
        final file = File(filePath);
        final jsonStr = json.encode(dataBuku);
        await file.writeAsString(jsonStr).timeout(const Duration(seconds: 5));
        if (mounted && dialogShown) Navigator.of(context).pop();
        dialogShown = false;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data berhasil diekspor ke: $filePath'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    } catch (e) {
      if (mounted && dialogShown) Navigator.of(context).pop();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal ekspor data: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Fungsi untuk decode JSON di isolate
  Future<List<Map<String, dynamic>>> _parseJson(String jsonStr) async {
    return await compute(_decodeJson, jsonStr);
  }

  List<Map<String, dynamic>> _decodeJson(String jsonStr) {
    final List<dynamic> jsonList = json.decode(jsonStr);
    return List<Map<String, dynamic>>.from(jsonList);
  }

  // Impor data buku dari file eksternal
  Future<void> _importDataBuku() async {
    bool dialogShown = false;
    try {
      Future.microtask(() async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
        dialogShown = true;
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/buku_data_export.json';
        final file = File(filePath);
        if (!await file.exists()) {
          throw Exception('File tidak ditemukan. Silakan ekspor data terlebih dahulu.');
        }
        final jsonStr = await file.readAsString().timeout(const Duration(seconds: 5));
        final List<Map<String, dynamic>> parsed = await _parseJson(jsonStr);
        setState(() {
          dataBuku = parsed;
          daftarBuku = dataBuku.map((e) => Buku.fromJson(e)).toList();
        });
        await _saveDataBuku();
        if (mounted && dialogShown) Navigator.of(context).pop();
        dialogShown = false;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data berhasil diimpor!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    } catch (e) {
      if (mounted && dialogShown) Navigator.of(context).pop();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal impor data: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.deepPurple,
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'ReadCyle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.upload_file, size: 26),
              tooltip: 'Ekspor Data Buku',
              onPressed: _exportDataBuku,
            ),
            IconButton(
              icon: const Icon(Icons.download, size: 26),
              tooltip: 'Impor Data Buku',
              onPressed: _importDataBuku,
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart, size: 28),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Keranjang Belanja'),
                        content:
                            _keranjang.isEmpty
                                ? const Text('Keranjang belanja kosong.')
                                : SizedBox(
                                  width: 300,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: _keranjang.length,
                                    separatorBuilder:
                                        (_, __) => const Divider(),
                                    itemBuilder: (context, idx) {
                                      final buku = _keranjang[idx];
                                      return ListTile(
                                        leading: SizedBox(
                                          width: 40,
                                          child: Image.network(
                                            buku.gambar,
                                            width: 60,
                                            height: 80,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 32, color: Colors.grey),
                                          ),
                                        ),
                                        title: Text(
                                          buku.judul,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text('Rp${buku.harga}'),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _keranjang.removeAt(idx);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Tutup'),
                          ),
                        ],
                      ),
                );
              },
              tooltip: 'Keranjang',
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFF3EFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: _pages[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 13),
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Kategori',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
