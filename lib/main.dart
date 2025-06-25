import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

// =====================
// Halaman Beranda BukuMart
// =====================
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Dummy data kategori
  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.new_releases, 'label': 'Buku Baru'},
    {'icon': Icons.book, 'label': 'Buku Bekas'},
    {'icon': Icons.school, 'label': 'Pendidikan'},
    {'icon': Icons.menu_book, 'label': 'Novel'},
    {'icon': Icons.auto_stories, 'label': 'Komik'},
  ];

  // Dummy data buku
  final List<Map<String, dynamic>> books = const [
    {
      'image': 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
      'title': 'Flutter for Beginners',
      'price': 75000,
      'type': 'Baru',
    },
    {
      'image': 'https://images.unsplash.com/photo-1524985069026-dd778a71c7b4',
      'title': 'Dart in Action',
      'price': 50000,
      'type': 'Bekas',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Matematika SMA',
      'price': 40000,
      'type': 'Bekas',
    },
    {
      'image': 'https://images.unsplash.com/photo-1516979187457-637abb4f9353',
      'title': 'Komik Naruto',
      'price': 25000,
      'type': 'Baru',
    },
    {
      'image': 'https://images.unsplash.com/photo-1507842217343-583bb7270b66',
      'title': 'Novel Dilan',
      'price': 60000,
      'type': 'Baru',
    },
    {
      'image': 'https://images.unsplash.com/photo-1519681393784-d120267933ba',
      'title': 'Komik One Piece',
      'price': 20000,
      'type': 'Bekas',
    },
  ];

  // Widget untuk setiap halaman
  Widget _buildHome(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final crossAxisCount = isTablet ? 4 : 2;
    return CustomScrollView(
      slivers: [
        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari buku... ',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ),
        // Banner Promo
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.deepPurple[100],
                height: size.height * 0.18,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Promo Spesial!\nDiskon hingga 50%',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Beli buku baru & bekas dengan harga terbaik.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Kategori Buku
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple[50],
                        child: Icon(cat['icon'], color: Colors.deepPurple),
                        radius: 26,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat['label'],
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        // Grid Daftar Buku
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final book = books[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              book['image'],
                              height: isTablet ? 120 : 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: book['type'] == 'Baru'
                                    ? Colors.green[600]
                                    : Colors.orange[600],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                book['type'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          book['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Rp${book['price'].toString()}',
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                );
              },
              childCount: books.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKategori() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.category, size: 80, color: Colors.deepPurple),
          const SizedBox(height: 16),
          const Text('Kategori Buku', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            children: categories.map((cat) => Chip(label: Text(cat['label']))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildKeranjang() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart, size: 80, color: Colors.deepPurple),
          SizedBox(height: 16),
          Text('Keranjang Belanja Kosong', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Yuk, tambahkan buku ke keranjang!'),
        ],
      ),
    );
  }

  Widget _buildAkun() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person, size: 80, color: Colors.deepPurple),
          SizedBox(height: 16),
          Text('Profil Akun', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Nama Pengguna: Guest'),
        ],
      ),
    );
  }

  List<Widget> get _pages => [
    _buildHome(context),
    _buildKategori(),
    _buildKeranjang(),
    _buildAkun(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BukuMart'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
