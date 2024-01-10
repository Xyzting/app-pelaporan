import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masyarakat/controllers/pengaduanController.dart';


class BuatPengaduan extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BuatPengaduan();
  }
}

class _BuatPengaduan extends State<BuatPengaduan>{
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map data = {};
    var hasil;
    PengaduanController pengaduanController = Get.put(PengaduanController());
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
              decoration:const InputDecoration(
                label:Text("Isi Laporan"),
              ),
              onChanged: (value) => data["isi_laporan"] = value,
            ),
            TextField(
              decoration:const InputDecoration(
                label:Text("Status"),
              ),
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
              onChanged: (value) => data["nik"] = value,
            ),
            const SizedBox(height: 20),
            Obx(() => !pengaduanController.web.value  ?
              ElevatedButton(
                onPressed: () {
                  pengaduanController.pickImage();
                },
                child:const Text("File Image"),
              )
              :
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pengaduanController.pickImage();
                    },
                    child: Image.memory(pengaduanController.fileWeb["file"],width: 200)
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      pengaduanController.pickImage();
                    },
                    child:const Text("File Image"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                hasil = await pengaduanController.createData(data);
                if(hasil != "success") {
                  Get.snackbar("Error",hasil.toString());
                  return;
                }
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
