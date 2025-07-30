const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors()); // Agar bisa diakses dari Flutter

const books = [
  {
    id: 1,
    judul: 'Dunia Sophie',
    kategori: 'Filsafat, Novel',
    penulis: 'Jostein Gaarder',
    penerbit: 'Mizan Pustaka',
    tahun: 1996,
    isbn: '978-979-433-125-9',
    harga: 99000,
    tipe: 'Baru',
    gambar: 'https://www.grobmart.com/image/cache/catalog/0produk0/201905/9786024410209-550x550h.jpg',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 2,
    judul: 'Bumi',
    kategori: 'Fantasi, Petualangan',
    penulis: 'Tere Liye',
    penerbit: 'Gramedia Pustaka Utama',
    tahun: 2014,
    isbn: '978-602-030-891-9',
    harga: 88000,
    tipe: 'Baru',
    gambar: 'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/img20220830_10560995.jpg',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 3,
    judul: 'Laskar Pelangi',
    kategori: 'Novel, Inspiratif',
    penulis: 'Andrea Hirata',
    penerbit: 'Bentang Pustaka',
    tahun: 2005,
    isbn: '979-3062-79-7',
    harga: 75000,
    tipe: 'Baru',
    gambar: 'https://upload.wikimedia.org/wikipedia/id/8/8e/Laskar_pelangi_sampul.jpg',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 4,
    judul: 'Cantik Itu Luka',
    kategori: 'Fiksi Sejarah, Sastra',
    penulis: 'Eka Kurniawan',
    penerbit: 'Gramedia Pustaka Utama',
    tahun: 2002,
    isbn: '978-602-032-470-4',
    harga: 115000,
    tipe: 'Baru',
    gambar: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 5,
    judul: 'Laut Bercerita',
    kategori: 'Fiksi Sejarah, Novel',
    penulis: 'Leila S. Chudori',
    penerbit: 'KPG (Kepustakaan Populer Gramedia)',
    tahun: 2017,
    isbn: '978-602-424-694-5',
    harga: 90000,
    tipe: 'Baru',
    gambar: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 6,
    judul: 'Gadis Kretek',
    kategori: 'Fiksi Sejarah, Roman',
    penulis: 'Ratih Kumala',
    penerbit: 'Gramedia Pustaka Utama',
    tahun: 2012,
    isbn: '978-979-228-141-5',
    harga: 92000,
    tipe: 'Baru',
    gambar: 'https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 7,
    judul: 'Pulang',
    kategori: 'Fiksi Sejarah, Novel',
    penulis: 'Leila S. Chudori',
    penerbit: 'KPG (Kepustakaan Populer Gramedia)',
    tahun: 2012,
    isbn: '978-979-91-0515-8',
    harga: 95000,
    tipe: 'Baru',
    gambar: 'https://inc.mizanstore.com/aassets/img/com_cart/produk/pulang-tere-liye.jpg',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 8,
    judul: 'Atomic Habits',
    kategori: 'Pengembangan Diri',
    penulis: 'James Clear',
    penerbit: 'Gramedia Pustaka Utama',
    tahun: 2019,
    isbn: '978-602-062-325-9',
    harga: 108000,
    tipe: 'Baru',
    gambar: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=400&q=80',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 9,
    judul: 'Sapiens: A Brief History of Humankind',
    kategori: 'Sejarah, Sains',
    penulis: 'Yuval Noah Harari',
    penerbit: 'KPG (Kepustakaan Populer Gramedia)',
    tahun: 2017,
    isbn: '978-602-424-416-3',
    harga: 125000,
    tipe: 'Baru',
    gambar: 'https://images-na.ssl-images-amazon.com/images/I/81WcnNQ-TBL.jpg',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
  {
    id: 10,
    judul: 'The Psychology of Money',
    kategori: 'Keuangan, Psikologi',
    penulis: 'Morgan Housel',
    penerbit: 'Baca',
    tahun: 2021,
    isbn: '978-602-6486-57-7',
    harga: 89000,
    tipe: 'Baru',
    gambar: 'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=400&q=80',
    pendahuluan: '',
    isi: '',
    penutup: ''
  },
];

app.get('/books', (req, res) => {
  res.json(books);
});

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});
