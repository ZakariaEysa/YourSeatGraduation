// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/data/hive_keys.dart';
import 'package:yourseatgraduationproject/data/hive_storage.dart';
import 'package:yourseatgraduationproject/features/user_flow/movie_details/data/model/movies_details_model/movies_details_model.dart';
import 'package:yourseatgraduationproject/features/user_flow/payment/presentation/views/payment_successful.dart';
import 'package:yourseatgraduationproject/utils/navigation.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/notifications_manager.dart';

class PayMobPayment {
  Dio dio = Dio(BaseOptions(
    validateStatus: (status) => true, // يقبل أي status code
  ));
}

class PaymentScreen extends StatefulWidget {
  final String paymentToken;
  final MoviesDetailsModel model;
  final List<String> seats;
  final String seatCategory;

  final num price;
  final String location;
  final String date;
  final String time;
  final String hall;
  final String cinemaId;
  final String orderId;
  const PaymentScreen({
    super.key,
    required this.paymentToken,
    required this.model,
    required this.seats,
    required this.seatCategory,
    required this.price,
    required this.location,
    required this.date,
    required this.time,
    required this.cinemaId,
    required this.hall,
    required this.orderId,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final InAppWebViewController _controller;
  var currentUser;

  @override
  void initState() {
    super.initState();
  }

  void startPayment() {
    _controller.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
            "https://accept.paymob.com/api/acceptance/iframes/901395?payment_token=${widget.paymentToken}"),
      ),
    );
  }

  void injectScript() {
    _controller.evaluateJavascript(source: """
      function clickSubmitButton() {
        console.log("Checking for submit button...");
        if (document.body.innerText.includes("Payment Information")) {
          console.log("Payment information found, script will not execute.");
          return;
        }
        
        let submitButton = document.querySelector("button[name='Submit']") || 
                           document.getElementById("Submit") || 
                           document.getElementsByName("Submit")[0] || 
                           document.querySelector("button[type='submit']") || 
                           document.querySelector("input[type='submit']") || 
                           document.querySelector("button");

        if (submitButton) {
          console.log("Submit button found!");
          if (!submitButton.disabled) {
            submitButton.focus();
            submitButton.click();
            submitButton.dispatchEvent(new Event('click', { bubbles: true }));
            console.log("Submit button clicked");
          } else {
            console.log("Submit button is disabled, retrying...");
            setTimeout(clickSubmitButton, 300);
          }
        } else {
          console.log("Submit button not found, retrying...");
          setTimeout(clickSubmitButton, 300);
        }
      }
      
      function monitorPageChanges() {
        console.log("Monitoring page for submit button...");
        let observer = new MutationObserver((mutations, obs) => {
          if (document.body.innerText.includes("payment information")) {
            console.log("Payment information found, stopping observer.");
            obs.disconnect();
            return;
          }
          
          let submitButton = document.querySelector("button[name='Submit']") || 
                             document.getElementById("Submit") || 
                             document.getElementsByName("Submit")[0] || 
                             document.querySelector("button[type='submit']") || 
                             document.querySelector("input[type='submit']") || 
                             document.querySelector("button");
          
          if (submitButton) {
            console.log("Submit button detected in DOM!");
            if (!submitButton.disabled) {
              submitButton.focus();
              submitButton.click();
              submitButton.dispatchEvent(new Event('click', { bubbles: true }));
              console.log("Submit button clicked from observer");
              obs.disconnect();
            } else {
              console.log("Submit button is disabled, waiting...");
            }
          }
        });
        
        observer.observe(document.body, { childList: true, subtree: true });
      }
      
      document.addEventListener("DOMContentLoaded", function() {
        console.log("DOM fully loaded, attempting to click submit button");
        setTimeout(clickSubmitButton, 300);
        monitorPageChanges();
      });

      window.onload = function () {
        console.log("Page fully loaded, attempting to click submit button");
        setTimeout(clickSubmitButton, 300);
        monitorPageChanges();
      };

      setTimeout(clickSubmitButton, 600); // محاولة الضغط بعد 1.5 ثانية لضمان تحميل الصفحة
    """);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Center(
          child: Text(
            lang.Checkout,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 25.sp,
            ),
          ),
        ),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
          startPayment();
        },
        onLoadStop: (controller, url) async {
          injectScript();
          if (url != null &&
              url.queryParameters.containsKey("success") &&
              url.queryParameters["success"] == "true") {
            await _handlePaymentSuccess(lang.Booked_successfully,
                lang.The_ticket_has_been_booked_successfully_Enjoy_watching_the_movie);
          } else if (url != null &&
              url.queryParameters.containsKey("success") &&
              url.queryParameters["success"] == "false") {
            // AppLogs.debugLog("❌ فشل في الدفع!");
          }
        },
        onReceivedError: (controller, request, error) {
          // AppLogs.errorLog(error.toString());
        },
      ),
    );
  }

  Future<void> updateReservedSeatsAndSaveTicket({
    required String cinemaId,
    required String movieName,
    required String selectedTime,
    required String selectedDate,
    required List<String> newSelectedSeats, // المقاعد الجديدة المختارة
  }) async {
    try {
      // 🔹 مرجع السينما في Firestore
      DocumentReference cinemaRef =
          FirebaseFirestore.instance.collection('Cinemas').doc(cinemaId);

      // 🔹 جلب بيانات السينما
      DocumentSnapshot cinemaSnapshot = await cinemaRef.get();

      if (cinemaSnapshot.exists) {
        Map<String, dynamic>? cinemaData =
            cinemaSnapshot.data() as Map<String, dynamic>?;

        if (cinemaData != null && cinemaData.containsKey('movies')) {
          List<dynamic> moviesList = List.from(cinemaData['movies']);

          // 🔹 البحث عن الفيلم المحدد
          int movieIndex =
              moviesList.indexWhere((movie) => movie['name'] == movieName);

          if (movieIndex != -1) {
            List<dynamic> timesList =
                List.from(moviesList[movieIndex]['times']);

            int timeIndex = timesList.indexWhere((timeEntry) {
              if (timeEntry['date'] != selectedDate) return false;

              List<dynamic> availableTimes = List.from(timeEntry['time']);
              return availableTimes
                  .any((t) => t['time'].toString() == selectedTime);
            });

            if (timeIndex != -1) {
              List<dynamic> availableTimes =
                  List.from(timesList[timeIndex]['time']);

              int specificTimeIndex = availableTimes
                  .indexWhere((t) => t['time'].toString() == selectedTime);

              if (specificTimeIndex != -1) {
                List<String> existingReservedSeats = List<String>.from(
                    availableTimes[specificTimeIndex]['reservedSeats'] ?? []);

                // ✅ تحديث المقاعد المحجوزة وإضافة الجديدة
                existingReservedSeats.addAll(newSelectedSeats);
                existingReservedSeats =
                    existingReservedSeats.toSet().toList(); // إزالة التكرارات

                availableTimes[specificTimeIndex]['reservedSeats'] =
                    existingReservedSeats;
                timesList[timeIndex]['time'] = availableTimes;
                moviesList[movieIndex]['times'] = timesList;

                // ✅ تحديث Firestore
                await cinemaRef.update({'movies': moviesList});
              } else {
                // print("❌ لم يتم العثور على الوقت المحدد داخل قائمة الأوقات!");
              }
            } else {
              // print("❌ لم يتم العثور على الوقت المحدد في القائمة!");
            }
          } else {
            // print("❌ لم يتم العثور على الفيلم المحدد!");
          }
        } else {
          // print("❌ لا يوجد أفلام مسجلة في السينما!");
        }
      } else {
        // print("❌ لم يتم العثور على السينما!");
      }
    } catch (e) {
      // print("❌ خطأ أثناء تحديث البيانات: $e");
    }
  }

  Future<void> _handlePaymentSuccess(String title, String body) async {
    if (HiveStorage.get(HiveKeys.role) == Role.google.toString()) {
      setState(() {
        currentUser = HiveStorage.getGoogleUser();
      });
    } else {
      setState(() {
        currentUser = HiveStorage.getDefaultUser();
      });
      // AppLogs.successLog(currentUser.toString());
    }

    String userEmail = currentUser?.email ?? "unknown@email.com";

    await updateReservedSeatsAndSaveTicket(
      cinemaId: widget.cinemaId,
      movieName: widget.model.name.toString(),
      selectedTime: widget.time,
      selectedDate: widget.date,
      newSelectedSeats: widget.seats,
    );

    // 🔹 حفظ التذكرة للمستخدم
    await saveUserTicket(
      email: userEmail,
      orderId: widget.orderId,
      hall: widget.hall,
      cinemaId: widget.cinemaId,
      movieName: widget.model.name.toString(),
      selectedTime: widget.time,
      selectedDate: widget.date,
      selectedSeats: widget.seats,
      seatCategory: widget.seatCategory,
      totalPrice: widget.price,
    );

    // 🔹 حفظ التذكرة داخل السينما
    await saveCinemaTicket(
      email: userEmail,
      orderId: widget.orderId,
      hall: widget.hall,
      cinemaId: widget.cinemaId,
      movieName: widget.model.name.toString(),
      selectedTime: widget.time,
      selectedDate: widget.date,
      selectedSeats: widget.seats,
      seatCategory: widget.seatCategory,
      totalPrice: widget.price,
    );

//تم حجز التذكره بنجاح استمتع ب المشاهده

    await NotificationsManager.showLocalNotification(title, body,"تم حجز تذكرتك بنجاح ✅","تم حجز التذكرة بنجاح استمتع بمشاهدة الفيلم");

    // await NotificationsManager.showLocalNotification(title, body);

    navigateAndRemoveUntil(
      context: context,
      screen: PaymentSuccessful(
        orderId: widget.orderId,
        hall: widget.hall,
        model: widget.model,
        seatCategory: widget.seatCategory,
        seats: widget.seats,
        price: widget.price,
        location: widget.location,
        date: widget.date,
        time: widget.time,
        cinemaId: widget.cinemaId,
      ),
    );
  }

  Future<void> saveUserTicket({
    required String email,
    required String orderId,
    required String cinemaId,
    required String movieName,
    required String selectedTime,
    required String selectedDate,
    required List<String> selectedSeats,
    required String seatCategory,
    required num totalPrice,
    required String hall,
  }) async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(email);

      // 🔹 جلب بيانات المستخدم
      DocumentSnapshot userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        // 🔹 إنشاء المستخدم إذا لم يكن موجودًا
        await userRef.set({
          'email': email,
          'myTickets': [] // إنشاء حقل التذاكر فارغًا
        });
      }

      // 🔹 إنشاء بيانات التذكرة بدون `serverTimestamp()`
      Map<String, dynamic> ticketData = {
        "poster_image": widget.model.posterImage,
        "status": "active",
        "orderId": orderId,
        "hall": hall,
        "movieName": movieName,
        "cinemaId": cinemaId,
        "date": selectedDate,
        "time": selectedTime,
        "seats": selectedSeats,
        "seatCategory": seatCategory,
        "totalPrice": totalPrice,
        "duration": widget.model.duration,
        "category": widget.model.category,
      };

      // 🔹 إضافة التذكرة إلى `myTickets`
      await userRef.update({
        'myTickets': FieldValue.arrayUnion([ticketData])
      });

      // 🔹 تحديث `purchaseTime` بشكل منفصل
      await userRef.update({
        'purchaseTime': FieldValue.serverTimestamp(),
      });

      // print("✅ تم حفظ التذكرة بنجاح في حساب المستخدم!");
    } catch (e) {
      // print("❌ خطأ أثناء حفظ التذكرة للمستخدم: $e");
    }
  }

  Future<void> saveCinemaTicket({
    required String cinemaId,
    required String orderId,
    required String movieName,
    required String selectedTime,
    required String selectedDate,
    required List<String> selectedSeats,
    required String seatCategory,
    required num totalPrice,
    required String hall,
    required String email,
  }) async {
    try {
      DocumentReference cinemaRef =
          FirebaseFirestore.instance.collection('Cinemas').doc(cinemaId);

      // 🔹 إنشاء بيانات التذكرة بدون `serverTimestamp()`
      Map<String, dynamic> ticketData = {
        "poster_image": widget.model.posterImage,
        "status": "active",
        "orderId": orderId,
        "hall": hall,
        "movieName": movieName,
        "date": selectedDate,
        "time": selectedTime,
        "seats": selectedSeats,
        "seatCategory": seatCategory,
        "totalPrice": totalPrice,
        "userEmail": email,
        "duration": widget.model.duration,
        "category": widget.model.category,
      };

      // 🔹 إضافة التذكرة إلى `tickets`
      await cinemaRef.update({
        'tickets': FieldValue.arrayUnion([ticketData])
      });

      // 🔹 تحديث `purchaseTime` بشكل منفصل
      await cinemaRef.update({
        'purchaseTime': FieldValue.serverTimestamp(),
      });

      // print("✅ تم حفظ التذكرة في قسم التذاكر الخاص بالسينما!");
    } catch (e) {
      // print("❌ خطأ أثناء حفظ التذكرة في مجموعة السينما: $e");
    }
  }
}
