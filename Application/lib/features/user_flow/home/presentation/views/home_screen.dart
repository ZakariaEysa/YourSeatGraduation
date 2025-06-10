import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../Widget/Cinema_item/cinema_item.dart';
import '../Widget/chatbot_icon.dart';
import '../Widget/coming_soon/coming_soon.dart';
import '../Widget/head_widget.dart';
import '../Widget/movie_carousel_widget.dart';
import '../Widget/search/search.dart';
import '../Widget/text.dart';
import '../Widget/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    return Stack(
      children: [
        ScaffoldF(
          // appBar: AppBar(
          //   actions: [
          //     IconButton(onPressed: (){
          //       showSearch(context: context, delegate: MySearchDelegate());
          //
          //     }, icon: Icon(Icons.search))
          //   ],
          // ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const HeadWidget(),
                SearchBarWidget(),
                SizedBox(height: 20.h),
                TextWidget(
                  text: lang.nowPlaying,
                  navigateToPage: 'nowPlaying',
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 500.sp,
                  child: const MovieCarouselWidget(),
                ),
                //  SizedBox(height: 15.h,),
                TextWidget(
                  text: lang.comingSoon,
                  navigateToPage: 'comingSoon',
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 400.h,
                  child: ComingSoon(), // Horizontal list of coming soon movies
                ),
                TextS(text: lang.promoDiscount),
                Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: Image.asset("assets/images/discount.png"),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10.w, 0, 0, 0),
                    child: TextS(
                      text: lang.cinema,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: CinemaItem(),
                ),
              ],
            ),
          ),
        ),
        // Use the DraggableFloatingButton here
        const DraggableFloatingButton(),
      ],
    );
  }
}
