import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/hive_keys.dart';
import '../../../data/hive_storage.dart';
import '../../../../../generated/l10n.dart';
import '../../../utils/dialog_utilits.dart';
import '../../../utils/navigation.dart';
import '../auth/presentation/views/sign_in.dart';
import '../home/presentation/views/home_screen.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double _rating = 1.0;
  final TextEditingController _commentController = TextEditingController();
  var currentUser;
  Future<void> addComment(
    String cinemaId,
    BuildContext context,
  ) async {
    if (HiveStorage.get(HiveKeys.role) == Role.guest.toString()) {
      DialogUtils.showMessage(
        context,
        "You Have To Sign In To Continue",
        isCancelable: false,
        posActionTitle: "signInText",
        negActionTitle: "cancelText",
        posAction: () {
          HiveStorage.set(HiveKeys.role, "");
          navigateAndRemoveUntil(context: context, screen: const SignIn());
        },
        negAction: () => navigatePop(context: context),
      );
    } else {
      currentUser = HiveStorage.get(HiveKeys.role) == Role.google.toString()
          ? HiveStorage.getGoogleUser()
          : HiveStorage.getDefaultUser();

      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(cinemaId)
          .collection('comments')
          .add({
        'text': _commentController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'userName': currentUser.name,
        'image': currentUser.image,
        "rating": _rating,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var lang = S.of(context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(20.sp),
        width: 300.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50.sp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              lang.pleaseRateTheCinema,
              style: theme.textTheme.bodyLarge!.copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 5.h),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                if (mounted) {
                  setState(() {
                    _rating = rating;
                  });
                }
              },
            ),
            SizedBox(height: 15.h),
            Align(
              child: Text(
                lang.canYouTellUsTheReason,
                style: theme.textTheme.bodySmall!.copyWith(fontSize: 19.sp),
              ),
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: _commentController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary,
                hintText: lang.yourEvaluationIsInterested,
                hintStyle: theme.textTheme.bodySmall!.copyWith(
                  fontSize: 13.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33.sp),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () async {
                String? hiveUserName;
                try {
                  hiveUserName = HiveStorage.get(HiveKeys.username);
                } catch (e) {
                  hiveUserName = null;
                }

                String? firebaseUserName =
                    FirebaseAuth.instance.currentUser?.displayName;
                String? email = FirebaseAuth.instance.currentUser?.email;

                String userName = hiveUserName?.isNotEmpty == true
                    ? hiveUserName!
                    : firebaseUserName?.isNotEmpty == true
                        ? firebaseUserName!
                        : email?.isNotEmpty == true
                            ? email!
                            : "Unknown User";

                if (_rating == 0.0 || _commentController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("يرجى إدخال تقييم وتعليق قبل المتابعة"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  String cinemaId =
                      "Plaza Cinema"; // يجب تمرير معرف السينما هنا
                  DocumentReference cinemaRef = FirebaseFirestore.instance
                      .collection("Cinemas")
                      .doc(cinemaId);
                  DocumentSnapshot cinemaSnapshot = await cinemaRef.get();

                  String cinemaName = cinemaSnapshot.exists
                      ? (cinemaSnapshot["name"] ?? "Unknown Cinema")
                      : "Unknown Cinema";

                  if (cinemaSnapshot.exists) {
                    double currentRating =
                        (cinemaSnapshot['rating'] ?? 0.0).toDouble();
                    int currentRatingCount =
                        (cinemaSnapshot['rating_count'] ?? 0);
                    double newRating =
                        ((currentRating * currentRatingCount) + _rating) /
                            (currentRatingCount + 1);

                    await cinemaRef.update({
                      "rating": newRating,
                      "rating_count": currentRatingCount + 1,
                    });
                  }
                  await addComment(cinemaId, context);

                  // await FirebaseFirestore.instance
                  //     .collection("Cinemas")
                  //     .doc(cinemaId)
                  //     .collection("comments")
                  //     .add({
                  //   "rating": _rating,
                  //   "comment": _commentController.text.trim(),
                  //   "name": userName,
                  //   "cinemaName": cinemaName,
                  //   "timestamp": FieldValue.serverTimestamp(),
                  // });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تم حفظ تقييمك بنجاح!"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  await Future.delayed(const Duration(milliseconds: 500));

                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("حدث خطأ أثناء الحفظ، يرجى المحاولة مرة أخرى"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF675e7d),
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    HiveStorage.get(HiveKeys.isArabic)
                        ? "assets/images/doneArabic.PNG"
                        : "assets/images/Done2.PNG",
                    width: 41,
                    height: 41,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
