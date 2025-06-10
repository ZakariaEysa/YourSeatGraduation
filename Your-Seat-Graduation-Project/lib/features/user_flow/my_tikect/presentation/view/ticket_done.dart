import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/presentation/views/home_layout.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../generated/l10n.dart';
import '../widget/center_text.dart';
import '../../../../../widgets/app_bar/head_appbar.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../widget/dashed_line_painter.dart';
import '../widget/head_myticket.dart';
import '../widget/qr_state/qr_widget.dart';

class TicketDone extends StatelessWidget {
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
  final String status;

  const TicketDone(
      {super.key,
      required this.model,
      required this.seats,
      required this.seatCategory,
      required this.price,
      required this.location,
      required this.date,
      required this.time,
      required this.cinemaId,
      required this.hall,
      required this.status,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return ScaffoldF(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              navigateAndRemoveUntil(context: context, screen: HomeLayout());
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            )),
        title: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 45.w, top: 0, bottom: 15.h),
          child: HeadAppBar(
            title: lang.myTicket,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Add scroll functionality
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 20.w, top: 50.h, end: 20.w, bottom: 50.h),
              child: Container(
                  width: 1.sw, // Make it responsive
                  height:
                      1.sh * 0.8, // Set height as a fraction of screen height
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 2.w,
                    ),
                  )),
            ),
            HeadMyTicket(
              imageUrl: model.posterImage,
              hall: hall,
              movieCategory: model.category,
              movieDate: date,
              movieDuration: model.duration,
              movieTime: time,
              movieName: model.name,
              seatCategory: seatCategory,
              seats: seats,
            ),
            Positioned(
              bottom: 0,
              left: 342.w, // Responsive to screen width
              right: 0,
              top: 340.h, // Responsive to screen height
              child: Image.asset(
                'assets/icons/img.png',
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 545.h, 0, 0),
              child: Center(
                child: CustomPaint(
                  size: Size(310.w, 0.8.h), // Make line size responsive
                  painter: DashedLinePainter(
                    dashWidth: 10.0, // Dash width fixed, no need for responsive
                    dashSpace: 5.0, // Dash space fixed, no need for responsive
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 342.w,
              top: 340.h,
              child: Image.asset(
                'assets/icons/img_1.png',
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                width: 30.w, // Responsive width
              ),
            ),
            Divider(
              color: Color(0xff1A0E3D),
              height: 700.h,
              indent: 40.sp,
              endIndent: 40.sp,
              thickness: 1,
            ),
            CenterText(
              cinemaId: cinemaId,
              cost: price.toString(),
              location: location,
            ),
            QrWidget(
              status: status,
              orderId: orderId,
              hall: hall,
              movieCategory: model.category,
              movieDate: date,
              movieDuration: model.duration,
              movieTime: time,
              movieName: model.name,
              seatCategory: seatCategory,
              seats: seats,
              cinemaId: cinemaId,
              cost: price.toString(),
              location: location,
            )
          ],
        ),
      ),
    );
  }
}
