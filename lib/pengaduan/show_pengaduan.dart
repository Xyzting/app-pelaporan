import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masyarakat/controllers/pengaduanController.dart';
import 'package:masyarakat/home.dart';

class ShowPengaduan extends StatelessWidget {
  const ShowPengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    PengaduanController pengaduanController = Get.put(PengaduanController());
    final index = Get.arguments["index"];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Pengaduan Masyarakat",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(pengaduanController.data[index].url.toString(), width: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Nik :"),
                Text("${pengaduanController.data[index].nik}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Isi Laporan :"),
                Text("${pengaduanController.data[index].isiLaporan}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Status :"),
                Text("${pengaduanController.data[index].status}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tanggal Pengaduan :"),
                Text("${pengaduanController.data[index].tglPengaduan}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("CreatedAt :"),
                Text("${pengaduanController.data[index].createdAt}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("UpdatedAt :"),
                Text("${pengaduanController.data[index].updatedAt}"),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/pengaduan/edit",arguments: {"index":index});
                },
                child:const Text("Edit")
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  pengaduanController.destroyData(pengaduanController.data[index].idPengaduan);
                  Get.to(const Home());
                },
                child:const Text("Hapus")
            ),
          ],
        ),
      ),
    );
  }
}
