import 'package:flutter/material.dart';

class UploadBarangPage extends StatefulWidget {
  const UploadBarangPage({Key? key}) : super(key: key);

  @override
  State<UploadBarangPage> createState() => _UploadBarangPageState();
}

class _UploadBarangPageState extends State<UploadBarangPage> {
  final List<Map<String, dynamic>> _jualBuku = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penulisController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _addBuku() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _jualBuku.add({
          'judul': _judulController.text,
          'penulis': _penulisController.text,
          'harga': int.tryParse(_hargaController.text) ?? 0,
          'image': _imageController.text,
        });
        _judulController.clear();
        _penulisController.clear();
        _hargaController.clear();
        _imageController.clear();
      });
    }
  }

  void _deleteBuku(int index) {
    setState(() {
      _jualBuku.removeAt(index);
    });
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _hargaController.dispose();
    _imageController.dispose();
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
            'Jual Buku Anda',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Form upload kekinian
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
                      controller: _imageController,
                      decoration: const InputDecoration(
                        labelText: 'URL Gambar',
                        prefixIcon: Icon(Icons.image),
                        border: OutlineInputBorder(),
                      ),
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
          // List buku yang dijual kekinian
          if (_jualBuku.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daftar Buku Dijual',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                ..._jualBuku.asMap().entries.map((entry) {
                  final i = entry.key;
                  final buku = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            buku['image'] != null &&
                                    buku['image'].toString().isNotEmpty
                                ? Image.network(
                                  buku['image'],
                                  width: 50,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (c, e, s) => Container(
                                        width: 50,
                                        height: 70,
                                        color: Colors.grey[200],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      ),
                                )
                                : Container(
                                  width: 50,
                                  height: 70,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                ),
                      ),
                      title: Text(
                        buku['judul'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Penulis: ${buku['penulis']}\nRp${buku['harga']}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBuku(i),
                        tooltip: 'Hapus',
                      ),
                    ),
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }
}
