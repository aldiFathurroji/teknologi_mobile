class Buku {
  final String gambar;
  final String judul;
  final String penulis;
  final String penerbit;
  final int tahun;
  final String isbn;
  final int harga;
  final String tipe;
  final String kategori;
  final String pendahuluan;
  final String isi;
  final String penutup;

  Buku({
    required this.gambar,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.tahun,
    required this.isbn,
    required this.harga,
    required this.tipe,
    required this.kategori,
    required this.pendahuluan,
    required this.isi,
    required this.penutup,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      gambar: json['image'] as String,
      judul: json['title'] as String,
      penulis: json['author'] as String,
      penerbit: json['publisher'] as String,
      tahun:
          json['year'] is int
              ? json['year'] as int
              : int.parse(json['year'].toString()),
      isbn: json['isbn'] as String,
      harga:
          json['price'] is int
              ? json['price'] as int
              : int.parse(json['price'].toString()),
      tipe: json['type'] as String,
      kategori: json['kategori'] as String,
      pendahuluan: json['pendahuluan'] as String,
      isi: json['isi'] as String,
      penutup: json['penutup'] as String,
    );
  }
}
