import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/kategori_page.dart';
import 'pages/upload_barang_page.dart';
import 'pages/akun_page.dart';
import 'book.dart';
import 'kategori_detail_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final Set<String> _favoriteIsbns = {};

  final List<Map<String, dynamic>> dataBuku = [
    {
      "image":
          "https://www.grobmart.com/image/cache/catalog/0produk0/201905/9786024410209-550x550h.jpg", // Dunia Sophie
      "title": "Dunia Sophie",
      "author": "Jostein Gaarder",
      "publisher": "Mizan Pustaka",
      "year": 1996,
      "isbn": "978-979-433-125-9",
      "price": 99000,
      "type": "Baru",
      "kategori": "Filsafat, Novel",
      "pendahuluan":
          "Sebuah novel pengantar filsafat yang dikemas dalam cerita misteri yang menarik.",
      "isi":
          "Mengisahkan tentang Sophie Amundsen, seorang gadis remaja yang tiba-tiba menerima surat-surat misterius berisi pertanyaan filosofis. Melalui surat-surat tersebut, ia memulai perjalanan menelusuri sejarah filsafat Barat.",
      "penutup":
          "Sangat direkomendasikan bagi yang ingin mulai belajar filsafat dengan cara yang menyenangkan.",
    },
    {
      "image":
          "https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/img20220830_10560995.jpg", // Bumi
      "title": "Bumi",
      "author": "Tere Liye",
      "publisher": "Gramedia Pustaka Utama",
      "year": 2014,
      "isbn": "978-602-030-891-9",
      "price": 88000,
      "type": "Baru",
      "kategori": "Fantasi, Petualangan",
      "pendahuluan":
          "Buku pertama dari serial fantasi populer 'Bumi' yang memperkenalkan dunia paralel yang menakjubkan.",
      "isi":
          "Menceritakan petualangan tiga remaja bernama Raib, Seli, dan Ali yang menemukan bahwa mereka memiliki kekuatan unik dan tanpa sengaja memasuki dunia paralel bernama Klan Bulan.",
      "penutup":
          "Pembuka seri yang mendebarkan, cocok untuk segala usia yang menyukai cerita fantasi dan persahabatan.",
    },
    {
      "image":
          "https://upload.wikimedia.org/wikipedia/id/8/8e/Laskar_pelangi_sampul.jpg", // Laskar Pelangi
      "title": "Laskar Pelangi",
      "author": "Andrea Hirata",
      "publisher": "Bentang Pustaka",
      "year": 2005,
      "isbn": "979-3062-79-7",
      "price": 75000,
      "type": "Baru",
      "kategori": "Novel, Inspiratif",
      "pendahuluan":
          "Kisah nyata yang mengharukan tentang perjuangan sekelompok anak di Belitung untuk mendapatkan pendidikan.",
      "isi":
          "Berlatar di sebuah sekolah Muhammadiyah di pulau Belitung yang terancam bubar. Kisah ini berpusat pada Ikal dan sembilan temannya, serta dua guru mereka yang berdedikasi tinggi demi terus bersekolah.",
      "penutup":
          "Novel inspiratif yang merayakan semangat, persahabatan, dan pentingnya pendidikan.",
    },
    {
      "image":
          "https://images-na.ssl-images-amazon.com/images/I/81WcnNQ-TBL.jpg", // Sapiens
      "title": "Sapiens: A Brief History of Humankind",
      "author": "Yuval Noah Harari",
      "publisher": "KPG (Kepustakaan Populer Gramedia)",
      "year": 2017,
      "isbn": "978-602-424-416-3",
      "price": 125000,
      "type": "Baru",
      "kategori": "Sejarah, Sains",
      "pendahuluan":
          "Sebuah buku ambisius yang merangkum keseluruhan sejarah manusia dalam satu narasi besar.",
      "isi":
          "Menjelajahi bagaimana Homo Sapiens berhasil mendominasi planet ini. Buku ini membahas revolusi kognitif, agrikultur, hingga revolusi ilmiah yang membentuk peradaban, masyarakat, dan dunia modern.",
      "penutup":
          "Buku yang provokatif dan mencerahkan, mengubah cara pandang kita terhadap sejarah umat manusia.",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=400&q=80", // Atomic Habits
      "title": "Atomic Habits",
      "author": "James Clear",
      "publisher": "Gramedia Pustaka Utama",
      "year": 2019,
      "isbn": "978-602-062-325-9",
      "price": 108000,
      "type": "Baru",
      "kategori": "Pengembangan Diri",
      "pendahuluan":
          "Panduan praktis tentang cara membangun kebiasaan baik dan menghilangkan kebiasaan buruk.",
      "isi":
          "James Clear menyajikan kerangka kerja berbasis bukti untuk perbaikan diri setiap hari. Buku ini mengajarkan bagaimana perubahan-perubahan kecil (sebesar atom) dapat menghasilkan dampak yang luar biasa dari waktu ke waktu.",
      "penutup":
          "Wajib dibaca bagi siapa pun yang ingin mencapai tujuannya melalui pembentukan kebiasaan positif.",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80", // Cantik Itu Luka
      "title": "Cantik Itu Luka",
      "author": "Eka Kurniawan",
      "publisher": "Gramedia Pustaka Utama",
      "year": 2002,
      "isbn": "978-602-032-470-4",
      "price": 115000,
      "type": "Baru",
      "kategori": "Fiksi Sejarah, Sastra",
      "pendahuluan":
          "Sebuah epik keluarga yang memadukan sejarah Indonesia dengan mitos, surealisme, dan tragedi.",
      "isi":
          "Kisah ini berpusat pada Dewi Ayu, seorang pelacur legendaris, dan anak-anaknya. Latar belakangnya adalah sejarah kelam Indonesia dari era kolonial Belanda hingga masa Orde Baru, diceritakan dengan gaya realisme magis.",
      "penutup":
          "Karya sastra Indonesia modern yang diakui secara internasional dan memukau pembacanya.",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80", // Laut Bercerita
      "title": "Laut Bercerita",
      "author": "Leila S. Chudori",
      "publisher": "KPG (Kepustakaan Populer Gramedia)",
      "year": 2017,
      "isbn": "978-602-424-694-5",
      "price": 90000,
      "type": "Baru",
      "kategori": "Fiksi Sejarah, Novel",
      "pendahuluan":
          "Novel yang menyuarakan kisah para aktivis yang hilang pada masa Orde Baru.",
      "isi":
          "Terbagi menjadi dua sudut pandang: Biru Laut, seorang mahasiswa aktivis yang diculik, dan Asmara, adik Laut yang mencari kebenaran. Novel ini menggambarkan kekejaman rezim, perjuangan, dan duka keluarga korban.",
      "penutup":
          "Kisah yang kuat dan menyentuh tentang sebuah periode gelap dalam sejarah Indonesia.",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80", // Gadis Kretek
      "title": "Gadis Kretek",
      "author": "Ratih Kumala",
      "publisher": "Gramedia Pustaka Utama",
      "year": 2012,
      "isbn": "978-979-228-141-5",
      "price": 92000,
      "type": "Baru",
      "kategori": "Fiksi Sejarah, Roman",
      "pendahuluan":
          "Kisah cinta dan persaingan bisnis yang berlatar belakang industri kretek di Indonesia.",
      "isi":
          "Soeraja, pemilik pabrik kretek Djagad Raja yang sekarat, memanggil nama 'Jeng Yah'. Ketiga anaknya berusaha mencari sosok misterius ini dan mengungkap rahasia bisnis serta kisah cinta masa lalu ayah mereka.",
      "penutup":
          "Novel yang kaya akan detail sejarah industri kretek dan dibalut dengan cerita yang memikat.",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=400&q=80", // The Psychology of Money
      "title": "The Psychology of Money",
      "author": "Morgan Housel",
      "publisher": "Baca",
      "year": 2021,
      "isbn": "978-602-6486-57-7",
      "price": 89000,
      "type": "Baru",
      "kategori": "Keuangan, Psikologi",
      "pendahuluan":
          "Buku yang membahas hubungan psikologis manusia dengan uang melalui cerita-cerita pendek.",
      "isi":
          "Morgan Housel menjelaskan bahwa mengelola uang tidak melulu soal apa yang Anda tahu, melainkan tentang bagaimana Anda berperilaku. Buku ini memberikan pelajaran abadi tentang kekayaan, ketamakan, dan kebahagiaan.",
      "penutup":
          "Wawasan penting tentang keuangan pribadi yang dapat diakses oleh semua kalangan.",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80", // Pulang
      "title": "Pulang",
      "author": "Leila S. Chudori",
      "publisher": "KPG (Kepustakaan Populer Gramedia)",
      "year": 2012,
      "isbn": "978-979-91-0515-8",
      "price": 95000,
      "type": "Baru",
      "kategori": "Fiksi Sejarah, Novel",
      "pendahuluan":
          "Kisah para eksil politik Indonesia pasca-peristiwa G30S yang terdampar di luar negeri.",
      "isi":
          "Dimas Suryo, seorang wartawan yang bertugas di luar negeri, tidak bisa pulang ke Indonesia setelah peristiwa 1965. Novel ini menyoroti kehidupan para eksil di Paris dan perjuangan anak-anak mereka memahami akar identitasnya.",
      "penutup":
          "Sebuah novel epik yang menyentuh tentang sejarah, cinta, keluarga, dan pencarian makna 'pulang'.",
    },
  ];

  late final List<Buku> daftarBuku =
      dataBuku.map((e) => Buku.fromJson(e)).toList();

  List<Map<String, dynamic>> get kategoriList {
    final Set<String> kategoriSet = {};
    for (final buku in daftarBuku) {
      final kategoriStr = buku.kategori;
      final kategoriList = kategoriStr.split(',').map((e) => e.trim());
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
    return kategoriSet.map((k) {
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
          MaterialPageRoute(
            builder:
                (_) => KategoriDetailPage(
                  category: cat,
                  books:
                      daftarBuku
                          .where(
                            (b) => b.kategori
                                .split(',')
                                .map((e) => e.trim())
                                .contains(cat['key']),
                          )
                          .toList(),
                ),
          ),
        );
      },
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
    const UploadBarangPage(),
    const AkunPage(),
  ];

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
          title:
              _selectedIndex == 0
                  ? Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari buku, penulis, atau kategori',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 16),
                      readOnly: true,
                      onTap: () {},
                    ),
                  )
                  : const Text(
                    'ReadCyle',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, size: 28),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Keranjang Belanja'),
                        content: const Text('Keranjang belanja kosong.'),
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
