import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/home_cubit.dart';
import '../widgets/MoviStates.dart';
import '../widgets/booking_states.dart';
import '../widgets/sales-overview.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getCinemaTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/musfiq.png",
                      width: 20.w, height: 95.h, fit: BoxFit.cover),
                  SizedBox(
                    width: 4.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Musfiq",
                        style: TextStyle(
                            fontSize: 5.sp, color: const Color(0xFF151D48)),
                      ),
                      Text("Admin",
                          style: TextStyle(
                            fontSize: 4.sp,
                            color: Colors.black,
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              const SalesOverview(),
              SizedBox(height: 30.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is TicketsStatesSuccess ||
                      HomeCubit.get(context).ticketsList.isNotEmpty) {
                    return BookingStates(
                      tickets: HomeCubit.get(context).ticketsList,
                    );
                  } else if (state is TicketsStatesError) {
                    return Center(
                      child: Text(state.errorMsg),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(height: 30.h),
              const MovieStates(),
            ],
          ),
        ),
      ),
    );
  }
}
