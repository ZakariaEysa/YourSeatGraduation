import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/dialog_utilits.dart';
import '../views/route_map.dart';
import '../../../../../widgets/network_image/image_replacer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../../../home/presentation/views/home_layout.dart';

class CinemaHeaderDescription extends StatelessWidget {
  final Map<String, dynamic> cinemaData;

  CinemaHeaderDescription({super.key, required this.cinemaData});

  @override
  Widget build(BuildContext context) {
    // AppLogs.errorLog(cinemaData["lat"].toString()); // Removed: was used for logging latitude
    // AppLogs.errorLog(cinemaData["lng"].toString()); // Removed: was used for logging longitude

    final theme = Theme.of(context);
    var lang = S.of(context);
    final cinemaName = cinemaData['name'] ?? 'Cinema';
    final description = cinemaData['description'] ?? 'لا يوجد وصف متاح';
    final imageUrl = cinemaData['poster_image'] ?? '';
    final rating = (cinemaData['rating'] ?? 0.0).toDouble();
    final ratingCount = cinemaData['rating_count'] ?? 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        imageUrl.isNotEmpty
            ? ImageReplacer(
                imageUrl: imageUrl,
                width: 1.sw,
                height: 0.3.sh,
                fit: BoxFit.cover,
              )
            : Container(
                width: 1.sw,
                height: 0.3.sh,
                color: Colors.grey,
                child: const Icon(Icons.image, color: Colors.white),
              ),
        Padding(
          padding: EdgeInsets.only(top: 50.0.h, left: 20.w),
          child: IconButton(
            onPressed: () {
              navigateTo(context: context, screen: const HomeLayout());
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          ),
        ),
        Positioned(
          bottom: -50.h,
          left: 20.w,
          child: Container(
            padding: EdgeInsets.all(12.sp),
            width: 0.88.sw,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cinemaName,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xFFD4D0D0),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      lang.review,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(width: 8.w),
                    Image.asset(
                      'assets/images/cinemastar.png',
                      width: 14.w,
                      height: 13.h,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${rating.toStringAsFixed(1)} ($ratingCount)',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white, fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  itemSize: 25.sp, // حجم النجوم متجاوب
                  itemCount: 5,
                  itemBuilder: (context, index) => Icon(
                    rating >= index + 1 ? Icons.star : Icons.star_border,
                    color: rating >= index + 1
                        ? const Color(0xFFCCC919)
                        : const Color(0xFF575757),
                  ),

                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 40.w,
          top: 124.h,
          child: GestureDetector(
            onTap: () {
              // AppLogs.successLog('Navigate to RouteMapPage'); // Removed: was used for logging navigation to RouteMapPage
              // AppLogs.successLog(cinemaData["lat"].toString()); // Removed: was used for logging latitude
              // AppLogs.successLog(cinemaData["lng"].toString()); // Removed: was used for logging longitude

              // printUserLocation();

              if (cinemaData["lat"] != null && cinemaData["lng"] != null) {
                navigateTo(
                  context: context,
                  screen: RouteMapPage(
                    destinationLat: cinemaData["lat"],
                    destinationLng: cinemaData["lng"],
                  ),
                );
              } else {
                showCenteredSnackBar(
                    context, "No Address Specified Yet From The Owner");
                // AppLogs.errorLog("Latitude or Longitude is null"); // Removed: was used for logging null lat/lng
              }
            },
            child: Container(
              width: 28.w,
              height: 28.h,
              color: Colors.transparent, // تأكد من الشفافية
              child: Image.asset('assets/images/location.png'),
            ),
          ),
        ),
      ],
    );
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void _showMessage(String message) {
    showLocalNotification("📢 تنبيه", message); // Notification local
  }

  Future<void> showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default_channel_id',
      'default_notifications',
      channelDescription: 'YourSeat channel ',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      33, // notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // Future<void> printUserLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     _showMessage('Location services are disabled. Please enable them.');
  //     await Geolocator.openLocationSettings();
  //     return;
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       _showMessage('Location permissions are denied.');
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     _showMessage(
  //         'Location permissions are permanently denied. Please enable them from app settings.');
  //     await Geolocator.openAppSettings();
  //     return;
  //   }

  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     // String message =
  //     //     'User location: ${position.latitude}, ${position.longitude}';
  //     // print(message);
  //   } catch (e) {
  //     // print('Error getting location: $e');
  //     _showMessage('Error getting location: $e');
  //   }
  // }
}
