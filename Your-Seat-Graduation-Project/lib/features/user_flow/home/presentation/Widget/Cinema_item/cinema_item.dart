import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/navigation.dart';
import '../../../../../../widgets/loading_indicator.dart';
import '../../../../../../widgets/network_image/image_replacer.dart';
import '../../../../cinema_details/presentation/views/cinema_details.dart';
import 'Cubit/item_cubit.dart';
import 'Cubit/item_state.dart';

class CinemaItem extends StatefulWidget {
  const CinemaItem({super.key});

  @override
  State<CinemaItem> createState() => _CinemaItemState();
}

class _CinemaItemState extends State<CinemaItem> {
  @override
  void initState() {
    super.initState();
    CinemaItemCubit.get(context).fetchCinemas();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: BlocBuilder<CinemaItemCubit, CinemaItemState>(
        builder: (context, state) {
          if (state is CinemaLoading) {
            return const LoadingIndicator();
          } else if (state is CinemaFailure) {
            return Center(
              child: Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            var cinemas = CinemaItemCubit.get(context).cinemas;

            if (cinemas.isEmpty) {
              return const Center(
                child: Text("No cinemas available",
                    style: TextStyle(color: Colors.white)),
              );
            } else {
              //AppLogs.successLog("start sorting ");
              //AppLogs.successLog(cinemas.toString());

              //AppLogs.successLog("end sorting ");
            }
            //AppLogs.successLog("start viewing ");

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cinemas.length,
              itemBuilder: (context, index) {
                final cinema = cinemas[index];
                final data = cinema;

                final name = data["name"] ?? "Cinema";
                final imageUrl = data["poster_image"] ?? "";

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigateTo(
                            context: context,
                            screen: CinemaDetails(cinemaModel: data),
                          );
                        },
                        child: ImageReplacer(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                          isCircle: true,
                          width: 140.w,
                          height: 140.h,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
