import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../data/local_storage_service/local_storage_service.dart';

class RoomDropdownWidget extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const RoomDropdownWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<RoomDropdownWidget> createState() => RoomDropdownWidgetState();
}

class RoomDropdownWidgetState extends State<RoomDropdownWidget> {
  List<String> rooms = [];
  String? selectedRoom;
  String? lastSavedRoom;
  bool roomError = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoomsFromFirestore();
  }

  String extractUsername(String email) {
    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  Future<void> fetchRoomsFromFirestore() async {
    try {
      final String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");
      final doc = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(cinemaId)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final List<dynamic>? halls = data['halls'];

        if (halls != null) {
          rooms = halls
              .map((hall) => hall['hallName']?.toString())
              .where((name) => name != null && name.isNotEmpty)
              .cast<String>()
              .toList();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('⚠️ Error loading rooms: $e'),
            backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
        if (widget.initialValue != null &&
            rooms.contains(widget.initialValue)) {
          selectedRoom = widget.initialValue;
        }
      });
    }
  }

  bool validate() {
    setState(() {
      roomError = selectedRoom == null;
      if (!roomError) {
        lastSavedRoom = selectedRoom;
      }
    });
    return !roomError;
  }

  void resetToSaved() {
    setState(() {
      selectedRoom = lastSavedRoom;
      roomError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: Container(
        width: 35.w,
        height: 51.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: roomError ? Colors.red : Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const Center(child: CircularProgressIndicator(strokeWidth: 1.5))
            : DropdownButton<String>(
                value: selectedRoom,
                hint: Text(
                  'Room',
                  style: TextStyle(color: Colors.black, fontSize: 4.sp),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: rooms.map((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child:
                        Text(room, style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedRoom = value;
                    roomError = false;
                  });
                  widget.onChanged(value);
                },
                isExpanded: true,
                underline: const SizedBox.shrink(),
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black),
              ),
      ),
    );
  }
}
