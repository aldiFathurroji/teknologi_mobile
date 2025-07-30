import 'package:flutter/material.dart';

class UploadBarangPage extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onAddBuku;
  const UploadBarangPage({Key? key, this.onAddBuku}) : super(key: key);

  @override
  State<UploadBarangPage> createState() => _UploadBarangPageState();
}

class _UploadBarangPageState extends State<UploadBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penulisController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _penerbitController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _tipeController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _pendahuluanController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  final TextEditingController _penutupController = TextEditingController();

  void _addBuku() {
    if (_formKey.currentState!.validate()) {
      final bukuBaru = {
        'gambar': _imageController.text,
        'judul': _judulController.text,
        'penulis': _penulisController.text,
        'penerbit': _penerbitController.text,
        'tahun': int.tryParse(_tahunController.text) ?? 0,
        'isbn': _isbnController.text,
        'harga': int.tryParse(_hargaController.text) ?? 0,
        'tipe': _tipeController.text,
        'kategori': _kategoriController.text,
        'pendahuluan': _pendahuluanController.text,
        'isi': _isiController.text,
        'penutup': _penutupController.text,
      };
      widget.onAddBuku?.call(bukuBaru);
      _judulController.clear();
      _penulisController.clear();
      _hargaController.clear();
      _imageController.clear();
      _penerbitController.clear();
      _tahunController.clear();
      _isbnController.clear();
      _tipeController.clear();
      _kategoriController.clear();
      _pendahuluanController.clear();
      _isiController.clear();
      _penutupController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buku berhasil ditambahkan!')),
      );
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _hargaController.dispose();
    _imageController.dispose();
    _penerbitController.dispose();
    _tahunController.dispose();
    _isbnController.dispose();
    _tipeController.dispose();
    _kategoriController.dispose();
    _pendahuluanController.dispose();
    _isiController.dispose();
    _penutupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Tambah Buku Baru',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _judulController,
                      decoration: const InputDecoration(
                        labelText: 'Judul Buku',
                        prefixIcon: Icon(Icons.menu_book),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Judul wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _penulisController,
                      decoration: const InputDecoration(
                        labelText: 'Penulis',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Penulis wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _penerbitController,
                      decoration: const InputDecoration(
                        labelText: 'Penerbit',
                        prefixIcon: Icon(Icons.business),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Penerbit wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _tahunController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Tahun',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Tahun wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _isbnController,
                      decoration: const InputDecoration(
                        labelText: 'ISBN',
                        prefixIcon: Icon(Icons.qr_code),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'ISBN wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _hargaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Harga wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _tipeController,
                      decoration: const InputDecoration(
                        labelText: 'Tipe (Baru/Bekas)',
                        prefixIcon: Icon(Icons.check_circle),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Tipe wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _kategoriController,
                      decoration: const InputDecoration(
                        labelText: 'Kategori (pisahkan dengan koma)',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Kategori wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _imageController,
                      decoration: const InputDecoration(
                        labelText: 'URL Gambar',
                        prefixIcon: Icon(Icons.image),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'URL gambar wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pendahuluanController,
                      decoration: const InputDecoration(
                        labelText: 'Pendahuluan',
                        prefixIcon: Icon(Icons.info_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Pendahuluan wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _isiController,
                      decoration: const InputDecoration(
                        labelText: 'Isi',
                        prefixIcon: Icon(Icons.notes),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty ? 'Isi wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _penutupController,
                      decoration: const InputDecoration(
                        labelText: 'Penutup',
                        prefixIcon: Icon(Icons.done_all),
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? 'Penutup wajib diisi'
                                  : null,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_box_rounded),
                        label: const Text('Tambah Buku'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _addBuku,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
