import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masyarakat/home.dart';
import '../controllers/pengaduanController.dart';

class EditPengaduan extends StatelessWidget {
  const EditPengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    int index = Get.arguments["index"];
    PengaduanController pengaduanController = Get.put(PengaduanController());
    var pengaduan = pengaduanController.data[index];
    Map data = {
      "isi_laporan" : pengaduan.isiLaporan,
      "tgl_pengaduan" : pengaduan.tglPengaduan,
      "status" : pengaduan.status,
      "nik" : pengaduan.nik
    };
    final dataTime = DateTime.parse(pengaduan.tglPengaduan!);
    final dataFormat = DateFormat('yyyy-MM-dd').format(dataTime);
    TextEditingController dateinput = TextEditingController(text: dataFormat);
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
        child:SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: data["isi_laporan"]),
                decoration:const InputDecoration(
                  label:Text("Isi Laporan"),
                ),
                onChanged: (value) => data["isi_laporan"] = value,
              ),
              TextField(
                decoration:const InputDecoration(
                  label:Text("Status"),
                ),
                controller: TextEditingController(text: data["status"]),
                onChanged: (value) => data["status"] = value ,
              ),
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

                      data["tgl_pengaduan"] = formattedDate;
                      dateinput.text = formattedDate;
                  }else{
                      print("Date is not selected");
                  }
              },
              onChanged: (value) => data["tgl_pengaduan"] = dateinput.text,
             ),
              TextField(
                decoration:const InputDecoration(
                  label:Text("Nik"),
                ),
                controller: TextEditingController(text: data["nik"]),
                onChanged: (value) => data["nik"] = value,
              ),
              const SizedBox(height: 20),
              Obx(() => pengaduanController.fileWeb["file"] == ""  ?
                Column(
                  children: [
                    Image.network(pengaduanController.data[index].url.toString(),width: 200),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        pengaduanController.pickImage();
                      },
                      child:const Text("Update Image"),
                    ),
                  ],
                ) :
                GestureDetector(
                    onTap: () {
                      pengaduanController.pickImage();
                    },
                    child: Image.memory(pengaduanController.fileWeb["file"]!,width: 200)
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  hasil = await pengaduanController.updateData(data,pengaduan.idPengaduan);
                  if(hasil != "success") {
                    Get.snackbar("Error",hasil.toString());
                    return;
                  };
                  Get.to(const Home());
                },
                child:const Text("update"),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}