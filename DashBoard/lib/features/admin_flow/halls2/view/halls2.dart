import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../utils/global_halls_data.dart';
import '../../../../widgets/button/button_builder.dart';
import '../widgets/basic_hall.dart';

class Halls2 extends StatefulWidget {
  const Halls2({super.key});

  @override
  State<Halls2> createState() => _Halls2State();
}

class _Halls2State extends State<Halls2> {
  final Set<int> selectedHalls = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedHalls.clear();
    fetchHallDataFromFirestore();
  }

  Future<void> fetchHallDataFromFirestore() async {
    try {
      final CollectionReference cinemas =
          FirebaseFirestore.instance.collection('Cinemas');
      final String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");

      final docSnapshot = await cinemas.doc(cinemaId).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final List<dynamic>? halls = data['halls'];

        if (halls != null && halls.isNotEmpty) {
          globalHallKeys.clear();
          for (var hall in halls) {
            final key = GlobalKey<BasicHallState>();
            globalHallKeys.add(key);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              final hallState = key.currentState;
              if (hallState != null) {
                hallState.setHallData({
                  'hallName': hall['hallName'] ?? '',
                  'vipSeats': hall['seats']
                      ?.firstWhere((seat) => seat['seatType'] == 'VIP',
                          orElse: () => {'seatCount': 0})['seatCount']
                      .toString(),
                  'premiumSeats': hall['seats']
                      ?.firstWhere((seat) => seat['seatType'] == 'Premium',
                          orElse: () => {'seatCount': 0})['seatCount']
                      .toString(),
                  'standardSeats': hall['seats']
                      ?.firstWhere((seat) => seat['seatType'] == 'Standard',
                          orElse: () => {'seatCount': 0})['seatCount']
                      .toString(),
                  'vipPrice': hall['seats']
                      ?.firstWhere((seat) => seat['seatType'] == 'VIP',
                          orElse: () => {'price': 0})['price']
                      .toString(),
                  'premiumPrice': hall['seats']
                      ?.firstWhere((seat) => seat['seatType'] == 'Premium',
                          orElse: () => {'price': 0})['price']
                      .toString(),
                  'standardPrice': hall['seats']
                      ?.firstWhere((seat) => seat['seatType'] == 'Standard',
                          orElse: () => {'price': 0})['price']
                      .toString(),
                });
              }
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ Error fetching hall data: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _validateAndSave() {
    bool allValid = true;
    for (var key in globalHallKeys) {
      if (key.currentState?.validate() != true) {
        allValid = false;
      }
    }
    if (allValid) {
      saveHallDataToFirestore();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Please fix all errors before saving.')),
      );
    }
  }

  Future<void> saveHallDataToFirestore() async {
    try {
      final CollectionReference cinemas =
          FirebaseFirestore.instance.collection('Cinemas');
      final String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");

      List<Map<String, dynamic>> allHalls = [];

      for (var key in globalHallKeys) {
        final hallState = key.currentState;
        if (hallState != null) {
          final hall = hallState.getHallData();
          allHalls.add({
            'hallName': hall['hallName'],
            'seats': [
              {
                'seatType': 'VIP',
                'seatCount': int.parse(hall['vipSeats']),
                'price': int.parse(hall['vipPrice']),
              },
              {
                'seatType': 'Premium',
                'seatCount': int.parse(hall['premiumSeats']),
                'price': int.parse(hall['premiumPrice']),
              },
              {
                'seatType': 'Standard',
                'seatCount': int.parse(hall['standardSeats']),
                'price': int.parse(hall['standardPrice']),
              },
            ]
          });
        }
      }

      await cinemas.doc(cinemaId).update({
        'halls': allHalls,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Hall Data Saved Successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  String extractUsername(String email) {
    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  void _confirmDeleteSelected() {
    if (selectedHalls.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Hall Selected'),
          content: const Text('Please select at least one hall to delete.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Delete'),
          content:
              const Text('Are you sure you want to delete selected halls?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final sorted = selectedHalls.toList()
                    ..sort((a, b) => b.compareTo(a));
                  for (var index in sorted) {
                    globalHallKeys.removeAt(index);
                  }
                  selectedHalls.clear();
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  void _confirmAddHall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Add'),
        content: const Text('Are you sure you want to add a new hall?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                globalHallKeys.add(GlobalKey<BasicHallState>());
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New hall added successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 270.w),
                    child: SizedBox(
                      width: 90.w,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: _confirmAddHall,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF560B76),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_circle_outline,
                                color: Colors.white, size: 7.sp),
                            SizedBox(width: 2.w),
                            Text(
                              'Add Hall',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 6.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: globalHallKeys.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            BasicHall(key: globalHallKeys[index]),
                            if (index != 0)
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Checkbox(
                                  value: selectedHalls.contains(index),
                                  onChanged: (bool? selected) {
                                    setState(() {
                                      if (selected == true) {
                                        selectedHalls.add(index);
                                      } else {
                                        selectedHalls.remove(index);
                                      }
                                    });
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonBuilder(
                          text: 'Save',
                          onTap: _validateAndSave,
                          width: 40.w,
                          height: 50.h,
                          buttonColor: const Color(0xFF560B76),
                          borderShape: BorderRadius.circular(10.r),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 7.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ButtonBuilder(
                          text: 'Cancel',
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          width: 40.w,
                          height: 50.h,
                          buttonColor: const Color(0xFF560B76),
                          borderShape: BorderRadius.circular(10.r),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 7.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton.icon(
                      onPressed: _confirmDeleteSelected,
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: const Text('Delete Selected',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
