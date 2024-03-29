import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masyarakat/controllers/pengaduanController.dart';
import 'package:masyarakat/controllers/petugasController.dart';
import 'package:masyarakat/controllers/tanggapanController.dart';


class BuatTanggapan extends StatelessWidget {
  const BuatTanggapan({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput = TextEditingController();
    PengaduanController pengaduanController = Get.put(PengaduanController());
    PetugasController petugasController = Get.put(PetugasController());
    TanggapanController tanggapanController = Get.put(TanggapanController());
    RxMap data = RxMap({
      "id_pengaduan" : null,
      "id_petugas" : null,
      "tgl_tanggapan" : null,
      "tanggapan" : null
    });
    var hasil;
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
            const SizedBox(height: 10),
            TextField(
              controller: dateinput, 
              decoration: const InputDecoration( 
                  icon: Icon(Icons.calendar_today),
                  labelText: "Enter Date"
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101)
                );
                
                if(pickedDate != null ){
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 

                    data["tgl_tanggapan"] = formattedDate;
                    dateinput.text = formattedDate;
                }else{
                    print("Date is not selected");
                }
              },
              onChanged: (value) => data["tgl_tanggapan"] = dateinput.text,
             ),
              const SizedBox(height: 10),
              TextField(
                decoration:const InputDecoration(
                  label:Text("Tanggapan"),
                ),
                onChanged: (value) => data["tanggapan"] = value,
              ),
              const SizedBox(height: 10),
              Obx(() => pengaduanController.loading.value || pengaduanController.loading.value ?
                const Center(
                  child: CircularProgressIndicator(),
                )
                : Column(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Expanded(
                              child: Text('Pilih Pengaduan',
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
                        items: pengaduanController.data.map((pengaduan) => DropdownMenuItem(
                          value: pengaduan.idPengaduan,
                          child: Text(pengaduan.isiLaporan.toString(),style: const TextStyle(fontSize: 14,color: Colors.white)),
                        )).toList(),
                        value: data["id_pengaduan"],
                        onChanged: (String? value) => data["id_pengaduan"] = value!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Expanded(
                              child: Text('Pilih Petugas',
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
                        items: petugasController.data.map((petugas) => DropdownMenuItem(
                          value: petugas.idPetugas,
                          child: Text(petugas.namaPetugas.toString(),style: const TextStyle(fontSize: 14,color: Colors.white)),
                        )).toList(),
                        value: data["id_petugas"],
                        onChanged: (String? value) => data["id_petugas"] = value!,
                      ),
                    ),
                  ],
                ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                hasil = await tanggapanController.createData(data);
                if(hasil != "success") {
                  Get.snackbar("Error",hasil.toString());
                  return;
                };
                Get.toNamed("/");
              },
              child:const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}