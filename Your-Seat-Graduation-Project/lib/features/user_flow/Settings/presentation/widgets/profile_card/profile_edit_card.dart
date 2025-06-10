import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../data/hive_keys.dart';
import '../../../../../../data/hive_storage.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/navigation.dart';
import '../../../../../../utils/permissions_manager.dart';
import '../../../../../../widgets/loading_indicator.dart';
import '../../../../../../widgets/scaffold/scaffold_f.dart';
import '../../../../auth/data/model/user_model.dart';
import '../../../../auth/presentation/widgets/BirthDateDropdown.dart';
import 'info_container.dart';

class ProfileEditCard extends StatefulWidget {
  const ProfileEditCard({super.key});

  @override
  State<ProfileEditCard> createState() => _ProfileEditCardState();
}

class _ProfileEditCardState extends State<ProfileEditCard> {
  bool isLoading = false;
  final List<int> days = List<int>.generate(31, (index) => index + 1);
  final List<int> years =
      List<int>.generate(80, (index) => DateTime.now().year - index);
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  final List<String> gender = ["Male", "Female"];

  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String? selectedMonth;
  int? selectedDay;
  int? selectedYear;
  String? selectedGender;
  var currentUser;
  List<String> splitDate = [];
  String? selectedImageBase64;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    if (HiveStorage.get(HiveKeys.role) == Role.google.toString()) {
      currentUser = HiveStorage.getGoogleUser();
    } else {
      currentUser = HiveStorage.getDefaultUser();
      // AppLogs.successLog(currentUser.toString()); // Removed: was used for logging default user
    }

    String date = currentUser.dateOfBirth;
    splitDate = date.split("/");

    try {
      selectedDay = days.contains(int.parse(splitDate[0]))
          ? int.parse(splitDate[0])
          : null;
      selectedMonth = months.contains(splitDate[1]) ? splitDate[1] : null;
      selectedYear = years.contains(int.parse(splitDate[2]))
          ? int.parse(splitDate[2])
          : null;

      // AppLogs.successLog("Date parsed successfully"); // Removed: was used for logging date parsing success
    } catch (e) {
      // AppLogs.errorLog("Date parsing failed: $e"); // Removed: was used for logging date parsing failure
    }

    userController.text = currentUser.name;
    selectedGender =
        gender.contains(currentUser.gender) ? currentUser.gender : null;
    selectedImageBase64 = currentUser.image;
  }

  // دالة للتحقق من صحة بيانات Base64
  bool _isValidBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return false;
    }
    try {
      base64Decode(base64String);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool changed = false;
      var userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser.email);

      Map<String, dynamic> updatedData = {};

      if (userController.text.isNotEmpty &&
          userController.text != currentUser.name) {
        updatedData['name'] = userController.text;
        changed = true;
      }

      if (selectedDay != null &&
          selectedMonth != null &&
          selectedYear != null) {
        String newDateOfBirth = '$selectedDay/$selectedMonth/$selectedYear';
        if (newDateOfBirth != currentUser.dateOfBirth) {
          updatedData['dateOfBirth'] = newDateOfBirth;
        }
      }

      if (selectedGender != null && selectedGender != currentUser.gender) {
        updatedData['gender'] = selectedGender;
      }

      if (!_isValidBase64(selectedImageBase64)) {
        selectedImageBase64 = "";
      }

      if (selectedImageBase64 != currentUser.image) {
        updatedData['image'] = selectedImageBase64 ?? "";
        changed = true;
      }

      if (updatedData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No changes detected")),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (changed == true) {
        await updateUserCommentsInAllCinemas(
            updatedData['name'] ?? currentUser.name,
            updatedData['image'] ?? currentUser.image);
      }

      await userDoc.update(updatedData);

      HiveStorage.saveDefaultUser(UserModel(
        name: updatedData['name'] ?? currentUser.name,
        email: currentUser.email,
        password: currentUser.password,
        dateOfBirth: updatedData['dateOfBirth'] ?? currentUser.dateOfBirth,
        gender: updatedData['gender'] ?? currentUser.gender,
        image: updatedData['image'] ?? currentUser.image,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data Updated Successfully")),
      );

      // AppLogs.infoLog(HiveStorage.getDefaultUser().toString()); // Removed: was used for logging default user
    } catch (e) {
      // AppLogs.errorLog("Update profile failed: $e"); // Removed: was used for logging update profile failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something Went Wrong")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var lang = S.of(context);
        var theme = Theme.of(context);
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text('Gallery',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                onTap: () async {
                  await PermissionsManager.requestCameraPermission();

                  Navigator.of(context).pop();
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    final bytes = await File(image.path).readAsBytes();
                    setState(() {
                      selectedImageBase64 = base64Encode(bytes);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateUserCommentsInAllCinemas(
      String newName, String newImage) async {
    try {
      // AppLogs.debugLog("start updating All comments "); // Removed: was used for logging start of updating comments

      final userName = currentUser.name;
      final firestore = FirebaseFirestore.instance;

      // ✅ جلب كل السينمات
      final cinemasSnapshot = await firestore.collection('Cinemas').get();

      // ✅ أنشئ Batch
      final batch = firestore.batch();
      int operationsCount = 0;

      for (var cinemaDoc in cinemasSnapshot.docs) {
        final cinemaId = cinemaDoc.id;

        // ✅ جلب كل تعليقات المستخدم داخل هذه السينما
        final commentsSnapshot = await firestore
            .collection('Cinemas')
            .doc(cinemaId)
            .collection('comments')
            .where('userName', isEqualTo: userName)
            .get();

        for (var commentDoc in commentsSnapshot.docs) {
          final commentRef = firestore
              .collection('Cinemas')
              .doc(cinemaId)
              .collection('comments')
              .doc(commentDoc.id);

          batch.update(commentRef, {
            'userName': newName,
            'image': newImage,
          });

          operationsCount++;

          // ✅ لو عدد العمليات قرب من 500 (الحد الأقصى للدفعة)، نرسلها ونبدأ جديدة
          if (operationsCount == 450) {
            await batch.commit();
            // AppLogs.debugLog("Committed 450 updates, starting new batch..."); // Removed: was used for logging batch commit
            operationsCount = 0;
          }
        }
      }

      // ✅ إرسال الدفعة النهائية إذا تبقى عمليات
      if (operationsCount > 0) {
        await batch.commit();
        // AppLogs.debugLog("Committed final batch of $operationsCount updates"); // Removed: was used for logging final batch commit
      }

      // AppLogs.debugLog("✅ All comments updated successfully"); // Removed: was used for logging comments update success
    } catch (e) {
      // AppLogs.errorLog("❌ Error updating user comments: $e"); // Removed: was used for logging comments update failure
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    var theme = Theme.of(context);

    return ScaffoldF(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 28.sp,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
              child: Container(
                margin: EdgeInsets.only(top: 40.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(51.r),
                    topRight: Radius.circular(51.r),
                    bottomLeft: Radius.circular(51.r),
                    bottomRight: Radius.circular(51.r),
                  ),
                  color: Theme.of(context).colorScheme.secondaryFixed,
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.5),
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 130.h, left: 10.w, right: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLabel(theme, lang.username),
                      SizedBox(height: 15.h),
                      InfoContainer(
                        onChanged: (value) => userController.text = value,
                        controller: userController,
                        type: TextInputType.text,
                        title: "",
                      ),
                      SizedBox(height: 15.h),
                      _buildLabel(theme, lang.emailAddress),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        padding: EdgeInsets.all(15.sp),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 55.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23.r),
                          color: theme.colorScheme.primary.withOpacity(0.7),
                        ),
                        child: Text(
                          currentUser.email,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      _buildLabel(theme, lang.birthDate),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildDropdown(
                                lang.month, selectedMonth, months,
                                (String? newValue) {
                              setState(() {
                                selectedMonth = newValue;
                              });
                            }),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _buildDropdown(lang.day, selectedDay, days,
                                (int? newValue) {
                              setState(() {
                                selectedDay = newValue;
                              });
                            }),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child:
                                _buildDropdown(lang.year, selectedYear, years,
                                    (int? newValue) {
                              setState(() {
                                selectedYear = newValue;
                              });
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      _buildLabel(theme, lang.gender),
                      SizedBox(height: 15.h),
                      _buildDropdown(lang.gender, selectedGender, gender,
                          (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      }),
                      SizedBox(height: 45.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => navigatePop(context: context),
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Color(0xff421aa3), // لون خلفية الزر
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                            ),
                            child: Text(
                              HiveStorage.get(HiveKeys.isArabic)
                                  ? 'إلغاء'
                                  : 'Cancel',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          TextButton(
                            onPressed: updateProfile,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Color(0xff421aa3), // لون خلفية الزر
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                            ),
                            child: Text(
                              HiveStorage.get(HiveKeys.isArabic)
                                  ? 'حفظ التغييرات'
                                  : 'Save Changes',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 115.w,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80.r,
                    backgroundImage: _isValidBase64(selectedImageBase64)
                        ? MemoryImage(base64Decode(selectedImageBase64!))
                        : const AssetImage("assets/images/account.png")
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Positioned(
                    left: 120.w,
                    top: 100.h,
                    bottom: 100.h,
                    child: Center(child: LoadingIndicator()))
                : Container(),
          ],
        )),
      ),
    );
  }

  Widget _buildLabel(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        text,
        style: theme.textTheme.labelLarge!.copyWith(fontSize: 16.sp),
      ),
    );
  }

  Widget _buildDropdown<T>(String hintText, T? selectedValue, List<T> items,
      ValueChanged<T?> onChanged) {
    return BirthDateDropdown<T>(
      hintText: hintText,
      selectedValue: selectedValue,
      itemsList: items,
      onChanged: onChanged,
    );
  }
}
