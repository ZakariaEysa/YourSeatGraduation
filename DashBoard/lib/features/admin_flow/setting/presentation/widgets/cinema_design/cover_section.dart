import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../widgets/button/button_builder.dart';

class CoverSection extends StatelessWidget {
  final PlatformFile? pickedCover;
  final Function(PlatformFile?) onPick;
  final VoidCallback onDelete;

  const CoverSection({
    super.key,
    required this.pickedCover,
    required this.onPick,
    required this.onDelete,
  });

  Future<void> pickCover() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      onPick(result.files.single);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text("upload cover",
                style:
                    TextStyle(color: const Color(0xFF6A6767), fontSize: 5.sp)),
            SizedBox(height: 10.h),
            Container(
              width: 65.w,
              height: 130.84.h,
              color: Colors.grey[300],
              child: pickedCover != null
                  ? Image.memory(pickedCover!.bytes!, fit: BoxFit.cover)
                  : Image.asset("assets/icons/cinema.png", fit: BoxFit.cover),
            ),
            SizedBox(height: 10.h),
            Text("*Cover size (342×120) pixels , max 1 MB",
                style:
                    TextStyle(fontSize: 3.sp, color: const Color(0xFF6A6767))),
          ],
        ),
        SizedBox(width: 5.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ButtonBuilder(
                  text: pickedCover == null ? 'Upload' : 'Change',
                  onTap: () => pickCover(),
                  width: 30.w,
                  height: 51.h,
                  buttonColor: const Color(0xFF292D32),
                  frameColor: const Color(0xFF560B76),
                  borderShape: BorderRadius.circular(15.r),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 5.sp),
                ),
                SizedBox(width: 3.w),
                ButtonBuilder(
                  text: 'Delete',
                  onTap: onDelete,
                  width: 25.w,
                  height: 40.h,
                  buttonColor: const Color(0xFFFF0000),
                  borderShape: BorderRadius.circular(15.r),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 5.sp),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
