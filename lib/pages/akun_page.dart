import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          // Menu Akun mirip kategori (list tile horizontal)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(height: 18),
              itemBuilder: (context, idx) {
                final items = [
                  {
                    'icon': Icons.location_on,
                    'color': Colors.green,
                    'title': 'Alamat',
                    'image':
                        'https://cdn-icons-png.flaticon.com/512/684/684908.png',
                  },
                  {
                    'icon': Icons.history,
                    'color': Colors.orange,
                    'title': 'Pesanan',
                    'image':
                        'https://cdn-icons-png.flaticon.com/512/1250/1250615.png',
                  },
                  {
                    'icon': Icons.favorite,
                    'color': Colors.pink,
                    'title': 'Wishlist',
                    'image':
                        'https://cdn-icons-png.flaticon.com/512/833/833472.png',
                  },
                  {
                    'icon': Icons.reviews,
                    'color': Colors.blue,
                    'title': 'Ulasan',
                    'image':
                        'https://cdn-icons-png.flaticon.com/512/929/929564.png',
                  },
                  {
                    'icon': Icons.store,
                    'color': Colors.deepPurple,
                    'title': 'Dasbor Toko',
                    'image':
                        'https://cdn-icons-png.flaticon.com/512/1077/1077042.png',
                  },
                ];
                final item = items[idx];
                final Color color =
                    Colors.deepPurple; // Satu warna untuk semua menu
                final icon = item['icon'] as IconData;
                final String title = item['title'] as String;
                final String? imageUrl = item['image'] as String?;
                return Container(
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
                          child:
                              imageUrl != null && imageUrl.isNotEmpty
                                  ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        icon,
                                        color: color.withOpacity(0.25),
                                        size: 32,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(imageUrl),
                                        radius: 16,
                                        backgroundColor: Colors.transparent,
                                        onBackgroundImageError:
                                            (error, stackTrace) {},
                                      ),
                                    ],
                                  )
                                  : Icon(icon, color: color, size: 32),
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
