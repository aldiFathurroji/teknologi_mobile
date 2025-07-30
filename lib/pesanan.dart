import 'package:flutter/material.dart';

class Pesanan {
  final String judulBuku;
  final String alamat;
  final String metode;
  final DateTime waktu;
  final String status;

  Pesanan({
    required this.judulBuku,
    required this.alamat,
    required this.metode,
    required this.waktu,
    this.status = 'Menunggu Konfirmasi',
  });

  Map<String, dynamic> toJson() => {
    'judulBuku': judulBuku,
    'alamat': alamat,
    'metode': metode,
    'waktu': waktu.toIso8601String(),
    'status': status,
  };

  factory Pesanan.fromJson(Map<String, dynamic> json) => Pesanan(
    judulBuku: json['judulBuku'],
    alamat: json['alamat'],
    metode: json['metode'],
    waktu: DateTime.parse(json['waktu']),
    status: json['status'] ?? 'Menunggu Konfirmasi',
  );
}

// Global list pesanan (sementara, bisa dikembangkan ke persistent storage)
final List<Pesanan> pesananList = [];

void tambahPesanan(Pesanan pesanan) {
  pesananList.insert(0, pesanan); // Insert di depan agar terbaru di atas
}

List<Pesanan> getPesananList() => pesananList; 