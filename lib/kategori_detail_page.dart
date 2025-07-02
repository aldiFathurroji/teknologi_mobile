import 'package:flutter/material.dart';
import 'book.dart';
import 'detail_buku_page.dart';

class KategoriDetailPage extends StatelessWidget {
  final Map<String, dynamic> category;
  final List<Buku> books;
  const KategoriDetailPage({
    Key? key,
    required this.category,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category['label']),
        backgroundColor: Colors.deepPurple,
      ),
      body:
          books.isEmpty
              ? const Center(child: Text('Tidak ada buku di kategori ini.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: books.length,
                itemBuilder: (context, idx) {
                  final buku = books[idx];
                  final isFavorite = false; // Favorit logic bisa diimprove
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => DetailBukuPage(
                                book: buku,
                                isFavorite: isFavorite,
                              ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                buku.gambar,
                                height: 120,
                                width: 90,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      height: 120,
                                      width: 90,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),
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
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
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
                                  const SizedBox(height: 4),
                                  Text(
                                    'Penulis: ${buku.penulis}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Penerbit: ${buku.penerbit}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Tahun: ${buku.tahun}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'ISBN: ${buku.isbn}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Rp${buku.harga.toString()}',
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
