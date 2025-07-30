import 'package:flutter/material.dart';
import 'upload_barang_page.dart';
import '../book.dart';
import '../pesanan.dart';

// --- PAGE TAMBAHAN ---
class AlamatPage extends StatelessWidget {
  const AlamatPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alamat Saya'), backgroundColor: Colors.deepPurple),
      body: const Center(child: Text('Fitur alamat akan tersedia di update berikutnya.')),
    );
  }
}

class PesananPage extends StatelessWidget {
  const PesananPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pesanan = getPesananList();
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Saya'), backgroundColor: Colors.deepPurple),
      body: pesanan.isEmpty
          ? const Center(child: Text('Belum ada pesanan.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pesanan.length,
              itemBuilder: (context, idx) {
                final p = pesanan[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(Icons.receipt_long, color: Colors.deepPurple, size: 36),
                    title: Text(p.judulBuku, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alamat: ${p.alamat}', maxLines: 2, overflow: TextOverflow.ellipsis),
                        Text('Metode: ${p.metode}'),
                        Text('Waktu: ${p.waktu.toLocal().toString().substring(0, 16)}'),
                        Text('Status: ${p.status}', style: const TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class WishlistPage extends StatelessWidget {
  final List<Buku> wishlist;
  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist / Favorit'), backgroundColor: Colors.deepPurple),
      body: wishlist.isEmpty
          ? const Center(child: Text('Belum ada buku favorit.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlist.length,
              itemBuilder: (context, idx) {
                final buku = wishlist[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        buku.gambar,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
                      ),
                    ),
                    title: Text(buku.judul, maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text('Penulis: ${buku.penulis}\nRp${buku.harga}'),
                  ),
                );
              },
            ),
    );
  }
}

class UlasanPage extends StatelessWidget {
  const UlasanPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ulasan Saya'), backgroundColor: Colors.deepPurple),
      body: const Center(child: Text('Belum ada ulasan.')),
    );
  }
}

class DashboardTokoPage extends StatelessWidget {
  const DashboardTokoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dasbor Toko'), backgroundColor: Colors.deepPurple),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Statistik Toko', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Flexible(child: _StatCard(title: 'Buku\nDijual', value: '12')),
                    SizedBox(width: 8),
                    Flexible(child: _StatCard(title: 'Terjual', value: '5')),
                    SizedBox(width: 8),
                    Flexible(child: _StatCard(title: 'Ulasan', value: '3')),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.add_box_rounded),
                    label: const Text('Upload Buku Baru', style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(
                              title: const Text('Upload Buku Baru'),
                              backgroundColor: Colors.deepPurple,
                              leading: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            body: const UploadBarangPage(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                const Text('Info Toko', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Nama Toko: BukuMart Official'),
                const Text('Status: Aktif'),
                const Text('Bergabung: Jan 2024'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        width: 90,
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple)),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// --- END PAGE TAMBAHAN ---

class AkunPage extends StatelessWidget {
  final VoidCallback? onWishlistTap;
  const AkunPage({Key? key, this.onWishlistTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.location_on,
        'color': Colors.green,
        'title': 'Alamat',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlamatPage())),
      },
      {
        'icon': Icons.history,
        'color': Colors.orange,
        'title': 'Pesanan',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PesananPage())),
      },
      {
        'icon': Icons.favorite,
        'color': Colors.pink,
        'title': 'Wishlist',
        'onTap': onWishlistTap ?? () {},
      },
      {
        'icon': Icons.reviews,
        'color': Colors.blue,
        'title': 'Ulasan',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UlasanPage())),
      },
      {
        'icon': Icons.store,
        'color': Colors.deepPurple,
        'title': 'Dasbor Toko',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardTokoPage())),
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Profil
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Aldi Ripki SUPARMAN',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'kalopsia@email.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Menu Akun
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 18),
              itemBuilder: (context, idx) {
                final item = items[idx];
                final Color color = item['color'] as Color;
                final icon = item['icon'] as IconData;
                final String title = item['title'] as String;
                final VoidCallback onTap = item['onTap'] as VoidCallback;
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: onTap,
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.13),
                          color.withOpacity(0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: color.withOpacity(0.18),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.07),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withOpacity(0.18),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(icon, color: color, size: 32),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: color,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.deepPurple,
                          size: 20,
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
