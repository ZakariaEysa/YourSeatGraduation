import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../../../utils/app_logs.dart';
import '../../../../../../widgets/button/button_builder.dart';
import 'contract_file_info.dart';
import 'contract_buttons.dart';

class ContractBody extends StatefulWidget {
  const ContractBody({super.key});

  @override
  State<ContractBody> createState() => _ContractBodyState();
}

class _ContractBodyState extends State<ContractBody> {
  String? cinemaId;
  PlatformFile? selectedFile;
  PlatformFile? previousFile;
  PlatformFile? uploadedFile;
  bool isLoading = false;
  bool isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    cinemaId = extractUsername(LocalStorageService.getUserData() ?? "");
    fetchUploadedContract();
  }

  String extractUsername(String email) {
    AppLogs.errorLog(email.toString());
    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  Future<void> fetchUploadedContract() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('contracts')
          .where('cinemaId', isEqualTo: cinemaId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final sortedDocs = querySnapshot.docs.toList()
          ..sort((a, b) {
            final aTime = a['timestamp'] as Timestamp?;
            final bTime = b['timestamp'] as Timestamp?;
            return bTime?.compareTo(aTime ?? Timestamp(0, 0)) ?? 0;
          });

        final data = sortedDocs.first.data();
        final String base64Content = data['fileContent'];
        final String fileName = data['fileName'];
        final int fileSize = data['fileSize'];

        final Uint8List fileBytes = base64Decode(base64Content);

        setState(() {
          uploadedFile = PlatformFile(
            name: fileName,
            size: fileSize,
            bytes: fileBytes,
          );
        });

        print("📥 تم تحميل الملف من Firestore.");
      } else {
        print("🚫 لا يوجد ملف مرفوع لهذا المستخدم.");
      }
    } catch (e) {
      print("❌ فشل تحميل الملف: $e");
    } finally {
      setState(() {
        isInitialLoading = false;
      });
    }
  }

  Future<void> uploadToFirestoreWeb() async {
    if (selectedFile == null || selectedFile!.bytes == null) {
      print("⚠️ لا يوجد ملف PDF.");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      String base64Content = base64Encode(selectedFile!.bytes!);
      final fileInfo = {
        'fileName': selectedFile!.name,
        'fileSize': selectedFile!.size,
        'fileContent': base64Content,
        'timestamp': FieldValue.serverTimestamp(),
        'cinemaId': cinemaId,
      };

      await FirebaseFirestore.instance.collection('contracts').add(fileInfo);
      print("✅ تم رفع الملف بنجاح إلى Firestore!");
    } catch (e) {
      print("❌ فشل رفع الملف.");
      print("🛠️ الخطأ: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> uploadContract(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        previousFile = selectedFile;
        selectedFile = result.files.single;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📄 تم اختيار الملف: ${selectedFile!.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم اختيار أي ملف.')),
      );
    }
  }

  void cancelChanges() {
    if (selectedFile != previousFile) {
      setState(() {
        selectedFile = previousFile;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الإلغاء ❌')),
      );
    }
  }

  void saveChanges() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار ملف أولًا ❗')),
      );
      return;
    }

    await uploadToFirestoreWeb();
    await fetchUploadedContract();

    setState(() {
      previousFile = selectedFile;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم الحفظ ورفع الملف ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isInitialLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Container(
        width: 300.w,
        height: 700.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contract info",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.sp,
                  ),
                ),
                Text(
                  "Update your Contract info here",
                  style:
                      TextStyle(color: const Color(0xFF625C5C), fontSize: 5.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonBuilder(
                      text: 'Download Contract',
                      onTap: () {
                        if (uploadedFile != null &&
                            uploadedFile!.bytes != null) {
                          final blob = html.Blob([uploadedFile!.bytes]);
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          final anchor = html.AnchorElement(href: url)
                            ..setAttribute("download", uploadedFile!.name)
                            ..click();
                          html.Url.revokeObjectUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('لا يوجد ملف للتحميل')),
                          );
                        }
                      },
                      width: 86.w,
                      height: 78.h,
                      buttonColor: const Color(0xFFF3F3F3),
                      frameColor: const Color(0xFFEB68E3),
                      borderShape: BorderRadius.circular(10.r),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.sp,
                      ),
                    ),
                    SizedBox(width: 40.w),
                    ButtonBuilder(
                      text: selectedFile == null
                          ? 'Upload Contract'
                          : 'Change File',
                      onTap: () => uploadContract(context),
                      width: 86.w,
                      height: 78.h,
                      buttonColor: const Color(0xFFF3F3F3),
                      frameColor: const Color(0xFFEB68E3),
                      borderShape: BorderRadius.circular(10.r),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (selectedFile != null)
                  ContractFileInfo(file: selectedFile!)
                else if (uploadedFile != null)
                  ContractFileInfo(file: uploadedFile!),
                ContractButtons(
                  onSave: saveChanges,
                  onCancel: cancelChanges,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
