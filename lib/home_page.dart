import 'package:flutter/material.dart';
import 'book.dart';

// Halaman Beranda BukuMart
class HomePage extends StatelessWidget {
  final List<Buku> books;
  final List<Map<String, dynamic>> categories;
  final Set<String> favoriteIsbns;
  final Function(String) onToggleFavorite;
  final Function(Map<String, dynamic>) onCategoryTap;
  final Function(Buku) onAddToCart;

  const HomePage({
    Key? key,
    required this.books,
    required this.categories,
    required this.favoriteIsbns,
    required this.onToggleFavorite,
    required this.onCategoryTap,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookCycle'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, idx) {
          final buku = books[idx];
          return ListTile(
            leading: Image.network(buku.gambar, width: 50, height: 70, fit: BoxFit.cover),
            title: Text(buku.judul),
            subtitle: Text(buku.penulis),
            onTap: () {
              // Tambahkan navigasi ke detail buku jika diinginkan
            },
          );
        },
      ),
    );
  }
}
