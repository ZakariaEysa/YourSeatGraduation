import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../../../utils/app_logs.dart';

class DescriptionCinema extends StatefulWidget {
  final double width;
  final double height;
  final String hintText;

  const DescriptionCinema({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
  });

  @override
  DescriptionCinemaState createState() => DescriptionCinemaState();
}

class DescriptionCinemaState extends State<DescriptionCinema> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool _isLoading = true;

  void validate() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        _errorText = 'هذا الحقل مطلوب';
      } else {
        _errorText = null;
      }
    });
  }

  String get descriptionText => _controller.text.trim();

  @override
  void initState() {
    super.initState();
    _loadDescriptionFromFirestore();
  }

  Future<void> _loadDescriptionFromFirestore() async {
    try {
      String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(cinemaId)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String? description = data['description'];

        if (description != null) {
          _controller.text = description;
        }
      }
    } catch (e) {
      print("❌ فشل تحميل وصف السينما: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String extractUsername(String email) {
    AppLogs.errorLog(email.toString());

    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.width,
                height: widget.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
  }
}
