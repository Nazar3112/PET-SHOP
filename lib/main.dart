import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => OrderProvider(),
      child: const MyApp(),
    ),
  );
}

// --------------------------- MyApp ---------------------------
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petshop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

// --------------------------- Model & Provider ---------------------------

// Model Order untuk menyimpan data transaksi
class Order {
  final int id;
  final String petType;
  final String customerName;
  final String phone;
  final String email;
  final String address;
  final int quantity;
  final String notes;
  bool confirmed;

  Order({
    required this.id,
    required this.petType,
    required this.customerName,
    required this.phone,
    required this.email,
    required this.address,
    required this.quantity,
    required this.notes,
    this.confirmed = false,
  });
}

// Provider untuk mengelola list order secara lokal (in-memory)
class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];
  int _nextId = 1;

  List<Order> get orders => _orders;

  void addOrder({
    required String petType,
    required String customerName,
    required String phone,
    required String email,
    required String address,
    required int quantity,
    required String notes,
  }) {
    _orders.add(Order(
      id: _nextId++,
      petType: petType,
      customerName: customerName,
      phone: phone,
      email: email,
      address: address,
      quantity: quantity,
      notes: notes,
    ));
    notifyListeners();
  }

  void confirmOrder(int id) {
    final index = _orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      _orders[index].confirmed = true;
      notifyListeners();
    }
  }
}

// --------------------------- LoginPage ---------------------------
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petshop Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pilih peran untuk login:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Login sebagai User'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const UserHomePage()),
                  );
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Login sebagai Admin'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminHomePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------- DATA HEWAN (Dengan Gambar) ---------------------------
// Buat model sederhana untuk menampung data hewan (nama, path gambar)
class PetItem {
  final String name;
  final String imagePath;

  const PetItem({required this.name, required this.imagePath});
}

// --------------------------- UserHomePage ---------------------------
// Halaman User: Menampilkan daftar hewan dalam bentuk grid (2 kolom)
class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  // Contoh data hewan (silakan ganti gambar sesuai lokasi file Anda)
  final List<PetItem> petList = const [
    PetItem(name: 'Kucing', imagePath: 'assets/images/cat.png'),
    PetItem(name: 'Anjing', imagePath: 'assets/images/dog.png'),
    PetItem(name: 'Kelinci', imagePath: 'assets/images/kelinci.png'),
    PetItem(name: 'Hamster', imagePath: 'assets/images/hamster.png'),
    PetItem(name: 'Burung', imagePath: 'assets/images/burung.png'),
    PetItem(name: 'Marmut', imagePath: 'assets/images/marmut.png'),
    // Tambahkan sesuai kebutuhan...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User - Pilih Hewan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Kembali ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      // Gunakan GridView untuk menampilkan 2 kolom
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: petList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,       // 2 kolom
            mainAxisSpacing: 8.0,    // spasi vertikal
            crossAxisSpacing: 8.0,   // spasi horizontal
            childAspectRatio: 0.7,   // rasio lebar : tinggi (bisa disesuaikan)
          ),
          itemBuilder: (context, index) {
            final pet = petList[index];
            return Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gambar hewan
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // Ganti dengan Image.asset atau Image.network sesuai kebutuhan
                      child: Image.asset(
                        pet.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Nama hewan
                  Text(
                    pet.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tombol Pet Me
                  ElevatedButton(
                    onPressed: () {
                      // Arahkan ke form pemesanan
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserOrderFormPage(petType: pet.name),
                        ),
                      );
                    },
                    child: const Text('Pet Me'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --------------------------- UserOrderFormPage ---------------------------
// Halaman form pemesanan (setelah pilih hewan)
class UserOrderFormPage extends StatefulWidget {
  final String petType;
  const UserOrderFormPage({Key? key, required this.petType}) : super(key: key);

  @override
  State<UserOrderFormPage> createState() => _UserOrderFormPageState();
}

class _UserOrderFormPageState extends State<UserOrderFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      final petType = widget.petType;
      final customerName = _nameController.text;
      final phone = _phoneController.text;
      final email = _emailController.text;
      final address = _addressController.text;
      final quantity = int.tryParse(_quantityController.text) ?? 1;
      final notes = _notesController.text;

      Provider.of<OrderProvider>(context, listen: false).addOrder(
        petType: petType,
        customerName: customerName,
        phone: phone,
        email: email,
        address: address,
        quantity: quantity,
        notes: notes,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request berhasil dikirim!')),
      );

      // Kembali ke halaman UserHomePage
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan ${widget.petType}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama Lengkap
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama lengkap';
                  }
                  return null;
                },
              ),
              // Nomor Telepon
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'No. Telepon',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan no. telepon';
                  }
                  return null;
                },
              ),
              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan email';
                  }
                  // Contoh validasi email sederhana
                  if (!value.contains('@')) {
                    return 'Masukkan format email yang benar';
                  }
                  return null;
                },
              ),
              // Alamat
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan alamat';
                  }
                  return null;
                },
              ),
              // Jumlah
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jumlah';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              // Catatan
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Catatan',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Kirim Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------- AdminHomePage ---------------------------
class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Konfirmasi Pesanan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Kembali ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: orders.isEmpty
          ? const Center(child: Text('Belum ada Request'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      '${order.petType} (Jumlah: ${order.quantity}) - ${order.customerName}',
                    ),
                    subtitle: Text(
                      'No.Telp: ${order.phone}\n'
                      'Email: ${order.email}\n'
                      'Alamat: ${order.address}\n'
                      'Catatan: ${order.notes}\n'
                      'Status: ${order.confirmed ? "Terkonfirmasi" : "Pending"}',
                    ),
                    trailing: order.confirmed
                        ? const Icon(Icons.check, color: Colors.green)
                        : ElevatedButton(
                            child: const Text('Konfirmasi'),
                            onPressed: () {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .confirmOrder(order.id);
                            },
                          ),
                  ),
                );
              },
            ),
    );
  }
}
