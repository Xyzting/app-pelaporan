import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masyarakat/controllers/masyarakatController.dart';
import 'package:masyarakat/home.dart';

class Edit extends StatelessWidget {
  const Edit({super.key});

  @override
  Widget build(BuildContext context) {
    int index = Get.arguments["index"];
    MasyarakatController masyarakatController = Get.put(MasyarakatController());
    TextEditingController nama = TextEditingController(text: masyarakatController.data[index].nama);
    TextEditingController username = TextEditingController(text: masyarakatController.data[index].username);
    TextEditingController telp = TextEditingController(text: masyarakatController.data[index].telp);
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Pengaduan Masyarakat",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child:Column(
            children: [
              TextField(
                controller:nama,
                decoration:const InputDecoration(
                  label:Text("nama"),
                ),

              ),TextField(
                controller:username,
                decoration:const InputDecoration(
                  label:Text("username"),
                ),

              ),TextField(
                controller:telp,
                decoration:const InputDecoration(
                  label:Text("telp"),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  masyarakatController.updateData(masyarakatController.data[index].nik,nama.text,username.text,telp.text);
                  Get.to(const Home());
                },
                child:const Text("Update"),
              ),

            ],
          ),
        ),
    );
  }
}
