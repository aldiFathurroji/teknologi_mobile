import 'package:flutter/material.dart';

// ...

import 'dart:async';
import '../book.dart';
import '../detail_buku_page.dart';

class HomePage extends StatefulWidget {
  final List<Buku> books;
  final List<Map<String, dynamic>> categories;
  final Set<String> favoriteIsbns;
  final Function(String) onToggleFavorite;
  final Function(Map<String, dynamic>) onCategoryTap;
  final Function(Buku) onAddToCart;
  final Function(Buku) onDeleteBuku;
  const HomePage({
    Key? key,
    required this.books,
    required this.categories,
    required this.favoriteIsbns,
    required this.onToggleFavorite,
    required this.onCategoryTap,
    required this.onAddToCart,
    required this.onDeleteBuku,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  int _currentPromo = 0;
  late final PageController _promoController;
  Timer? _promoTimer;

  final List<Map<String, String>> promos = [];

  @override
  void initState() {
    super.initState();
    _promoController = PageController();
    if (widget.books.length >= 3) {
      promos.addAll([
        {
          'title': 'Promo Spesial! Diskon hingga 50%',
          'desc': 'Beli buku "${widget.books[0].judul}" dengan harga spesial minggu ini!',
          'img': widget.books[0].gambar,
        },
        {
          'title': 'Flash Sale Buku Terlaris',
          'desc': 'Dapatkan "${widget.books[1].judul}" dengan diskon 40% hanya hari ini!',
          'img': widget.books[1].gambar,
        },
        {
          'title': 'Buku Pilihan Editor',
          'desc': 'Rekomendasi: "${widget.books[2].judul}" untuk inspirasi harian Anda.',
          'img': widget.books[2].gambar,
        },
      ]);
    } else if (widget.books.isNotEmpty) {
      for (var i = 0; i < widget.books.length; i++) {
        promos.add({
          'title': 'Promo Buku',
          'desc': 'Beli buku "${widget.books[i].judul}" dengan harga spesial!',
          'img': widget.books[i].gambar,
        });
      }
    } else {
      promos.add({
        'title': 'Belum ada buku',
        'desc': 'Silakan tambahkan buku terlebih dahulu.',
        'img': '', // atau gambar default
      });
    }
    _promoTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_promoController.hasClients && promos.isNotEmpty) {
        int next = (_currentPromo + 1) % promos.length;
        _promoController.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _promoController.dispose();
    _promoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final filteredBooks =
        _searchQuery.isEmpty
            ? widget.books
            : widget.books.where((b) {
              final query = _searchQuery.toLowerCase();
              final kategoriList = b.kategori
                  .toLowerCase()
                  .split(',')
                  .map((e) => e.trim());
              return b.judul.toLowerCase().contains(query) ||
                  b.penulis.toLowerCase().contains(query) ||
                  b.penerbit.toLowerCase().contains(query) ||
                  kategoriList.any((k) => k.contains(query));
            }).toList();
    return CustomScrollView(
      slivers: [
        // Search Bar Fungsional
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari buku, penulis, atau kategori',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple[100]!, Colors.purple[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: size.height * 0.22,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _promoController,
                      itemCount: promos.length,
                      onPageChanged: (i) {
                        setState(() {
                          _currentPromo = i;
                        });
                      },
                      itemBuilder: (context, idx) {
                        final promo = promos[idx];
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      promo['title']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      promo['desc']!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                promo['img']!,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.broken_image,
                                      size: 48,
                                      color: Colors.deepPurple,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          promos.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPromo == i ? 18 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color:
                                  _currentPromo == i
                                      ? Colors.deepPurple
                                      : Colors.deepPurple[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Kategori horizontal kekinian
        SliverToBoxAdapter(
          child: SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: widget.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, idx) {
                final cat = widget.categories[idx];
                return GestureDetector(
                  onTap: () => widget.onCategoryTap(cat),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.purpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Icon(cat['icon'], color: Colors.white, size: 36),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          cat['label'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        // Grid Daftar Buku
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, idx) {
              final buku = filteredBooks[idx];
              final isFavorite = widget.favoriteIsbns.contains(buku.isbn);
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => DetailBukuPage(
                              book: buku,
                              isFavorite: isFavorite,
                              onToggleFavorite:
                                  () => widget.onToggleFavorite(buku.isbn),
                              onAddToCart: widget.onAddToCart,
                            ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            buku.gambar,
                            width: 80,
                            height: 110,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 80,
                                height: 110,
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder:
                                (c, e, s) => Container(
                                  width: 80,
                                  height: 110,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 36,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      buku.judul,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed:
                                        () =>
                                            widget.onToggleFavorite(buku.isbn),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Penulis: ${buku.penulis}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Penerbit: ${buku.penerbit}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 2,
                                children:
                                    buku.kategori
                                        .split(',')
                                        .map(
                                          (k) => Chip(
                                            label: Text(
                                              k.trim(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            backgroundColor:
                                                Colors.deepPurple[50],
                                            labelStyle: const TextStyle(
                                              color: Colors.deepPurple,
                                            ),
                                            visualDensity:
                                                VisualDensity.compact,
                                            padding: EdgeInsets.zero,
                                          ),
                                        )
                                        .toList(),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    'Rp${buku.harga}',
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          buku.tipe == 'Baru'
                                              ? Colors.green[600]
                                              : Colors.orange[600],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      buku.tipe,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Hapus Buku',
                                    onPressed: () {
                                      widget.onDeleteBuku(buku);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: filteredBooks.length),
          ),
        ),
      ],
    );
  }
}
