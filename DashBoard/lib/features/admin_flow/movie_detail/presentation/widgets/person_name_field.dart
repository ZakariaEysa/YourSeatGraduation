import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class PersonNameField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Uint8List? imageBytes;
  final VoidCallback? onUpload;
  final VoidCallback? onDeleteImage;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool isViewOnly;
  final VoidCallback? onAdd;
  final VoidCallback? onDelete;

  final bool isFirst;

  const PersonNameField({
    super.key,
    this.initialValue,
    required this.label,
    this.imageBytes,
    this.onUpload,
    this.onDeleteImage,
    this.controller,
    this.validator,
    this.errorText,
    this.onChanged,
    this.isViewOnly = false,
    this.onAdd,
    this.onDelete,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.sp),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                imageBytes != null ? MemoryImage(imageBytes!) : null,
                radius: 24.r,
                backgroundColor: Colors.grey[400],
                child: imageBytes == null
                    ? Icon(Icons.person, size: 34.r, color: Colors.white)
                    : null,
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (!isViewOnly) ...[
                if (onUpload != null)
                  IconButton(
                    icon: const Icon(Icons.upload, color: Colors.black),
                    tooltip: 'Upload Image',
                    onPressed: onUpload,
                  ),
                if (imageBytes != null && onDeleteImage != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Delete Image',
                    onPressed: onDeleteImage,
                  ),
              ],
              if (!isViewOnly && onDelete != null)
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                  tooltip: 'Remove',
                  onPressed: onDelete,
                ),
              if (!isViewOnly && isFirst && onAdd != null)
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  tooltip: 'Add',
                  onPressed: onAdd,
                ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
              width: 120.w,
              height: 70.h,
              child: NewTextField(
                initialValue: initialValue,
                controller: controller,
                keyboardType: TextInputType.text,
                borderColor: isViewOnly
                    ? Colors.grey[400]!
                    : (errorText != null ? Colors.red : Colors.black),
                errorText: isViewOnly ? null : errorText,
                onChanged: onChanged,
                validator: isViewOnly ? null : validator,
                enabled: true,
                readOnly: isViewOnly,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isViewOnly
                        ? Colors.black
                        : (errorText != null ? Colors.red : Colors.black),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isViewOnly
                        ? Colors.black
                        : (errorText != null ? Colors.red : Colors.black),
                    width: 1.5,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
