## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Flutter Petshop App

Aplikasi **Pet Shop** adalah project Flutter sederhana yang dibuat untuk demonstrasi dan pembelajaran.  
Aplikasi ini mensimulasikan sebuah petshop dengan dua peran, yaitu **User** dan **Admin**.

## Fitur Utama

### User Side
- **Katalog Hewan:** Menampilkan daftar hewan dalam tampilan grid (2 kolom per baris) beserta gambar.
- **Pemesanan:** Pengguna dapat memilih hewan dengan menekan tombol **"Pet Me"** dan mengisi form pemesanan yang mencakup:
  - Nama lengkap
  - Nomor telepon
  - Email
  - Alamat
  - Jumlah pesanan
  - Catatan tambahan

### Admin Side
- **Daftar Pesanan:** Menampilkan semua pesanan yang masuk dari user.
- **Konfirmasi Pesanan:** Admin dapat mengonfirmasi pesanan sehingga statusnya berubah menjadi "Terkonfirmasi".

## Teknologi yang Digunakan

- **Flutter:** Framework untuk pengembangan aplikasi cross-platform.
- **Flutter Web:** Proyek ini dirancang untuk dijalankan melalui browser (Chrome, dsb.).
- **Provider:** Digunakan sebagai state management untuk mengelola data pesanan secara lokal (in-memory).

## Struktur Proyek

```plaintext
simple_aja/
├── assets/
│   └── images/
│       ├── cat.png
│       ├── dog.png
│       └── rabbit.png
├── lib/
│   └── main.dart         # File utama aplikasi
├── pubspec.yaml          # Konfigurasi dependency dan aset
├── README.md             # Dokumentasi proyek
└── .gitignore            # Mengabaikan file-file tertentu saat commit ke GitHub

