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
      gambar: json['gambar'] as String? ?? '',
      judul: json['judul'] as String? ?? '',
      penulis: json['penulis'] as String? ?? '',
      penerbit: json['penerbit'] as String? ?? '',
      tahun: (json['tahun'] is int)
          ? json['tahun'] as int
          : int.tryParse(json['tahun']?.toString() ?? '') ?? 0,
      isbn: json['isbn'] as String? ?? '',
      harga: (json['harga'] is int)
          ? json['harga'] as int
          : int.tryParse(json['harga']?.toString() ?? '') ?? 0,
      tipe: json['tipe'] as String? ?? '',
      kategori: json['kategori'] as String? ?? '',
      pendahuluan: json['pendahuluan'] as String? ?? '',
      isi: json['isi'] as String? ?? '',
      penutup: json['penutup'] as String? ?? '',
    );
  }
}
