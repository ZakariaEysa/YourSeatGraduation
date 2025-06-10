import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/cinema_info_text/cinema_text.dart';
import '../widgets/cinema_info_text/country.dart';
import 'user_location_service .dart';

class CinemaInfo extends StatefulWidget {
  const CinemaInfo({super.key});

  @override
  State<CinemaInfo> createState() => _CinemaInfoState();
}

class _CinemaInfoState extends State<CinemaInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLogs.debugLog(SettingsCubit.get(context).cinemaId.toString());
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        AppLogs.debugLog(state.toString());
        if (state is SettingsInitial) {
          AppLogs.debugLog("SettingsInitial");
          SettingsCubit.get(context).getCinemaData();
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingsError) {
          return Center(child: Text(state.message));
        } else {
          final cubit = SettingsCubit.get(context);
          final cinemaTextKey = GlobalKey<CinemaTextState>();
          final countryKey = GlobalKey<CountryState>();

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Container(
                    width: 959.95.w,
                    height: 668.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.h, right: 20.w, left: 10.w),
                          child: Text(
                            "Public Info",
                            style: TextStyle(
                              fontSize: 6.sp,
                              color: const Color(0XFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.w, left: 10.w),
                          child: Text(
                            "Update Your Cinema details here",
                            style: TextStyle(
                              fontSize: 5.sp,
                              color: const Color(0XFF000000),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        CinemaText(key: cinemaTextKey),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Cinema Address*",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 4.sp,
                                  ),
                                ),
                                Country(key: countryKey),
                              ],
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/Map 1 (1).png",
                                  width: 150.w,
                                  height: 159.h,
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        await UserLocationService()
                                            .getCurrentLocation(context);
                                      },
                                      child: Text(
                                        "Get Your Current Location Automatically",
                                        style: TextStyle(
                                          fontSize: 5.sp,
                                          color: const Color(0XFF6F6F6F),
                                        ),
                                      ),
                                    ),

                                    // SizedBox(width: 10.w),
                                    // TextButton(
                                    //   onPressed: () {
                                    //     navigateTo(
                                    //         context: context,
                                    //         screen: MapPickerPage());
                                    //   },
                                    //   child: Text(
                                    //     "Specify location manually",
                                    //     style: TextStyle(
                                    //       fontSize: 5.sp,
                                    //       color: const Color(0XFF6F6F6F),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80.w, top: 40.h),
                  child: Row(
                    children: [
                      ButtonBuilder(
                        text: 'Save',
                        onTap: () async {
                          AppLogs.scussessLog(
                              "Cinema info saved successfully ${cubit.selectedCountry} ${cubit.cinemaNameController.text} ${cubit.emailController.text} ${cubit.phoneController.text} ${cubit.managerController.text}");
                          bool isCinemaInfoValid =
                              cinemaTextKey.currentState?.validateFields() ??
                                  false;
                          bool isCountrySelected =
                              cubit.selectedCountry != null;
                          if (cubit.lat == null || cubit.lng == null) {
                            AppLogs.debugLog(cubit.lat.toString());
                            AppLogs.debugLog(cubit.lng.toString());
                            AppLogs.debugLog(cubit.cinemaId.toString());
                            AppLogs.debugLog(cubit.emailController.toString());

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('⚠️ Please select a location!'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            if (isCinemaInfoValid && isCountrySelected) {
                              await cubit.addOrUpdateCinemaData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('✅ Saved Successfully!'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(isCinemaInfoValid
                                      ? '⚠️ Please select a country!'
                                      : '⚠️ Please fill all fields correctly!'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        width: 45.w,
                        height: 60.h,
                        buttonColor: const Color(0xFF560B76),
                        frameColor: const Color(0xFF560B76),
                        borderShape: BorderRadius.circular(15.r),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      ButtonBuilder(
                        text: 'Cancel',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('❌ Cancelled!'),
                              backgroundColor: Colors.orange,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        width: 45.w,
                        height: 60.h,
                        buttonColor: const Color(0xFFF3F3F3),
                        frameColor: Colors.black,
                        borderShape: BorderRadius.circular(15.r),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          );
        }
      },
    );
  }
}
