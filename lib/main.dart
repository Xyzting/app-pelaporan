import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masyarakat/masyarakat/buat.dart';
import 'package:masyarakat/pengaduan/buat_pengaduan.dart';
import 'package:masyarakat/pengaduan/edit_pengaduan.dart';
import 'package:masyarakat/pengaduan/show_pengaduan.dart';
import 'package:masyarakat/petugas/buat_petugas.dart';
import 'package:masyarakat/masyarakat/edit.dart';
import 'package:masyarakat/home.dart';
import 'package:masyarakat/petugas/edit_petugas.dart';
import 'package:masyarakat/masyarakat/show.dart';
import 'package:masyarakat/petugas/show_petugas.dart';
import 'package:masyarakat/tanggapan/buat_tanggapan.dart';
import 'package:masyarakat/tanggapan/edit_tanggapan.dart';
import 'package:masyarakat/tanggapan/show_tanggapan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pengadunan Masyarakat',
      debugShowCheckedModeBanner: false,
      getPages: [
          GetPage(name: "/masyarakat/create", page: () => const Buat()),
          GetPage(name: "/masyrakat/show", page: () => const Show()),
          GetPage(name: "/masyarakat/edit", page: () => const Edit()),
          GetPage(name: "/pengaduan/show", page: () => const ShowPengaduan()),
          GetPage(name: "/pengaduan/create", page: () => BuatPengaduan()),
          GetPage(name: "/pengaduan/edit", page: () => EditPengaduan()),
          GetPage(name: "/petugas/create", page: () => const BuatPetugas()),
          GetPage(name: "/petugas/show", page: () => const ShowPetugas()),
          GetPage(name: "/petugas/edit", page: () => const EditPetugas()),
          GetPage(name: "/tanggapan/create", page: () => const BuatTanggapan()),
          GetPage(name: "/tanggapan/show", page: () => const ShowTanggapan()),
          GetPage(name: "/tanggapan/edit", page: () => const EditTanggapan()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      home: const Home(),
    );
  }
}

