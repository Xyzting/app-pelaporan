import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masyarakat/controllers/masyarakatController.dart';
import 'package:masyarakat/controllers/pengaduanController.dart';
import 'package:masyarakat/controllers/petugasController.dart';
import 'package:masyarakat/controllers/tanggapanController.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    MasyarakatController masyarakatController = Get.put(MasyarakatController());
    PengaduanController pengaduanController = Get.put(PengaduanController());
    PetugasController petugasController = Get.put(PetugasController());
    TanggapanController tanggapanController = Get.put(TanggapanController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Pengaduan Masyarakat",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding:const EdgeInsets.only(right: 20, left: 20, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/masyarakat/create");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(0,0,0,10),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text("Create Masyarakat",
                    style: TextStyle(fontSize: 16,color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(() => masyarakatController.loading.value ?
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              : masyarakatController.data.isNotEmpty ?
              ListView.builder(
                shrinkWrap: true,
                itemCount: masyarakatController.data.length,
                itemBuilder: (context,i) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed("/masyrakat/show",arguments: {"index":i});
                    },
                    child: ListTile(
                      focusColor: Colors.green,
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text("${i + 1}"),
                      ),
                      title: Text("${masyarakatController.data[i].nama}"),
                      subtitle: Text("${masyarakatController.data[i].createdAt}"),
                    ),
                    );
                  }
                ): Column(
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("there is no data masyarakat"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/pengaduan/create");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(0,0,0,10),
                  decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text("Create Pengaduan",
                    style: TextStyle(fontSize: 16,color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(() => pengaduanController.loading.value ?
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                : masyarakatController.data.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: pengaduanController.data.length,
                    itemBuilder: (context,i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/pengaduan/show",arguments: {"index":i});
                        },
                        child: ListTile(
                          focusColor: Colors.green,
                          leading: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Image.network(
                                    pengaduanController.data[i].url.toString(),
                                    height: 100,
                                  ),
                                )
                              ),
                          title: Text("${pengaduanController.data[i].isiLaporan}"),
                          subtitle: Text("${pengaduanController.data[i].tglPengaduan}"),
                        ),
                      );
                    },
                  ): Column(
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("there is no data pengaduan"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/petugas/create");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(0,0,0,10),
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text("Create Petugas",
                    style: TextStyle(fontSize: 16,color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(() => petugasController.loading.value ?
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                    : petugasController.data.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: petugasController.data.length,
                    itemBuilder: (context,i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/petugas/show",arguments: {"index":i});
                        },
                        child: ListTile(
                          focusColor: Colors.green,
                          leading: CircleAvatar(
                              radius: 30,
                              child: Text("${i + 1}")
                          ),
                          title: Text("${petugasController.data[i].namaPetugas}"),
                          subtitle: Text("${petugasController.data[i].createdAt}"),
                        ),
                      );
                    },
                  ): Column(
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("there is no data petugas"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
                ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/tanggapan/create");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(0,0,0,10),
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text("Create Tanggapan",
                    style: TextStyle(fontSize: 16,color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(() => petugasController.loading.value ?
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                    : petugasController.data.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tanggapanController.data.length,
                    itemBuilder: (context,i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/tanggapan/show",arguments: {"index":i});
                        },
                        child: ListTile(
                          focusColor: Colors.green,
                          leading: CircleAvatar(
                              radius: 30,
                              child: Text("${i + 1}")
                          ),
                          title: Text("${tanggapanController.data[i].tanggapan}"),
                          subtitle: Text("${tanggapanController.data[i].createdAt}"),
                        ),
                      );
                    },
                  ): Column(
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("there is no data petugas"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
                ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
