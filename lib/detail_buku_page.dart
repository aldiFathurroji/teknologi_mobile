import 'package:flutter/material.dart';
import 'book.dart';

class DetailBukuPage extends StatelessWidget {
  final Buku book;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;
  final Function(Buku)? onAddToCart;
  const DetailBukuPage({
    Key? key,
    required this.book,
    this.isFavorite = false,
    this.onToggleFavorite,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.judul),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: onToggleFavorite,
            tooltip: 'Favorit',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  book.gambar,
                  height: 180,
                  width: 130,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 180,
                        width: 130,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              book.judul,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              'Penulis: ${book.penulis}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Penerbit: ${book.penerbit}',
              style: const TextStyle(fontSize: 16),
            ),
            Text('Tahun: ${book.tahun}', style: const TextStyle(fontSize: 16)),
            Text(
              'ISBN: ${book.isbn}',
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              'Rp${book.harga.toString()}',
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6, bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color:
                    book.tipe == 'Baru'
                        ? Colors.green[600]
                        : Colors.orange[600],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                book.tipe,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Text(
              'Pendahuluan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
            Text(book.pendahuluan, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            Text(
              'Isi Buku',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
            Text(book.isi, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            Text(
              'Penutup',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
            Text(book.penutup, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text('Beli Buku'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Pembelian Buku'),
                              content: Text(
                                'Terima kasih telah membeli buku "${book.judul}"!',
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
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Masukkan ke Keranjang'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onAddToCart != null
                        ? () {
                            onAddToCart!(book);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Buku dimasukkan ke keranjang!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
