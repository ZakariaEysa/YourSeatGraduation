import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/network_image/image_replacer.dart';
import '../../../../../utils/notifications_manager.dart';
import 'vertical_status_card.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final bool isFirstTicket;
  final VoidCallback onCancel;

  const TicketCard({
    super.key,
    required this.ticket,
    this.isFirstTicket = false,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15.h),
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        height: 200.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: ImageReplacer(
                height: double.infinity,
                width: 120.w,
                imageUrl: ticket.imageUrl,
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ticket.movieName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoRow(context, 'assets/icons/clock_icon.png',
                      '${ticket.time}  |  ${ticket.date}'),
                  _buildInfoRow(context, 'assets/icons/location_icon.png',
                      ticket.location),
                  _buildInfoRow(context, 'assets/icons/Group 4.png',
                      'Seat: ${ticket.seats}'),
                  _buildInfoRow(
                      context, 'assets/icons/price-tag 2.png', ticket.price),
                  if (ticket.status == "active")
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            minimumSize: Size(120.w, 35.h),
                            side: BorderSide(
                              color: const Color(0xFFBD1A2F),
                              width: 1.5.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          onPressed: () {
                            onCancel();
                            NotificationsManager.showLocalNotification(
                                "Action Cancelled ✅",
                                "You have canceled your ticket",
                                "  ✅تم إلغاء الإجراء ",
                                "لقد قمت بإلغاء تذكرتك");
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            VerticalStatusCard(
              status: ticket.status,
              imagePath: ticket.statusImage,
              imageWidth: ticket.statusImageWidth,
              imageHeight: ticket.statusImageHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String iconPath, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 18.w,
            height: 18.h,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          SizedBox(width: 5.w),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Ticket {
  final String movieName;
  final String location;
  final String imageUrl;
  final String time;
  final String date;
  final String seats;
  final String price;
  final String status;
  final String statusImage;
  final double statusImageWidth;
  final double statusImageHeight;
  final String orderId;

  Ticket({
    required this.movieName,
    required this.orderId,
    required this.location,
    required this.imageUrl,
    required this.time,
    required this.date,
    required this.seats,
    required this.price,
    required this.status,
    required this.statusImage,
    required this.statusImageWidth,
    required this.statusImageHeight,
  });
}
