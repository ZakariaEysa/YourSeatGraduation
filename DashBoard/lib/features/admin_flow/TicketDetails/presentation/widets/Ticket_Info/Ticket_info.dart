import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/TicketDetails/presentation/cubit/ticket_details_cubit.dart';
import 'movie_info.dart';
import 'ticket_details_widgets.dart';

class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketDetailsCubit, TicketDetailsState>(
      builder: (context, state) {
        if (state is TicketDetailsSuccess) {
          return Padding(
            padding: EdgeInsets.only(left: 50.w, right: 80.w),
            child: Container(
              width: 400.w,
              height: 450.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.black,
                  width: 0.3.w,
                ),
              ),
              child: Column(
                children: [
                  MovieInfo(ticket: TicketDetailsCubit.get(context).ticket),
                  TicketDetails(ticket: TicketDetailsCubit.get(context).ticket),
                ],
              ),
            ),
          );
        } else if (state is TicketDetailsError) {
          return Center(child: Text(state.errorMsg));
        } else if (state is TicketDetailsInitial) {
          return Container();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
