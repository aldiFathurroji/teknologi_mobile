import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book.dart';
import 'dart:developer';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<List<Buku>> fetchBooksByCategory(String kategori) async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      log('Kategori dicari: $kategori');
      log('Kategori buku ditemukan: ${decoded.map((json) => json['kategori']).toList().toString()}');
      if (decoded is! List) {
        throw Exception('Format data dari backend tidak sesuai (bukan List).');
      }
      return decoded
          .map((json) => Buku.fromJson(json))
          .where(
            (buku) => buku.kategori
                .split(',')
                .map((e) => e.trim().toLowerCase())
                .contains(kategori.toLowerCase().trim()),
          )
          .toList();
    } else {
      throw Exception('Gagal mengambil data buku: kode ${response.statusCode}');
    }
  }
}
