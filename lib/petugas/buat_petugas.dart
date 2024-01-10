import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masyarakat/controllers/petugasController.dart';
import 'package:masyarakat/home.dart';

class BuatPetugas extends StatelessWidget {
  const BuatPetugas({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'admin',
      'petugas',
    ];
    
    TextEditingController nama_petugas = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController telp = TextEditingController();
    RxString level = RxString("");
    PetugasController petugasController = Get.put(PetugasController());

    var hasil = "";
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
              controller:nama_petugas,
              decoration:const InputDecoration(
                label:Text("Nama Petugas"),
              ),
            ),
            TextField(
              controller:username,
              decoration:const InputDecoration(
                label:Text("Username"),
              ),
            ),
            TextField(
              controller:password,
              decoration:const InputDecoration(
                label:Text("Password"),
              ),
            ),
            TextField(
              controller:telp,
              decoration:const InputDecoration(
                label:Text("telp"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Obx( () =>
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Pilih Level',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black26),
                        color: Colors.red,
                      ),
                      elevation: 2,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.red,
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: level.value == "" ? null : level.value,
                    onChanged: (String? value) => level.value = value!,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                hasil = await petugasController.createData(nama_petugas.text,username.text,password.text,telp.text, level.value);
                if(hasil != "success") {
                  Get.snackbar("Error",hasil);
                  return;
                };
                Get.to(const Home());
              },
              child:const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
