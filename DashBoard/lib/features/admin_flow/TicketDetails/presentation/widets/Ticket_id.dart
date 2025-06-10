import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/TicketDetails/presentation/cubit/ticket_details_cubit.dart';

import '../../../../../widgets/button/button_builder.dart';

class TicketId extends StatefulWidget {
  const TicketId({super.key});

  @override
  State<TicketId> createState() => _TicketIdState();
}

class _TicketIdState extends State<TicketId> {
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    // findAndPrintTicket(cinemaId: "Plaza Cinema", orderId: "304514032");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.w, right: 80.w),
      child: Container(
        width: 600.w,
        height: 169.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.black,
            width: 0.3.w,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0.sp),
                  child: Text(
                    "Enter order ID ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 120.h,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                      right: 20.w,
                      left: 10.w,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: InputDecorationTheme(
                            errorStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 3.sp,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller:
                              TicketDetailsCubit.get(context).ticketController,
                          obscureText: false,
                          style: TextStyle(fontSize: 4.sp, color: Colors.black),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^#?\d{0,9}'),
                            ),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFDBD9D9),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ticket number';
                            } else if (!RegExp(r'^#\d{9}$').hasMatch(value)) {
                              return 'The format should be like # and nine numbers.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            ButtonBuilder(
              text: 'Ticket',
              onTap: () {
                final value =
                    TicketDetailsCubit.get(context).ticketController.text;

                if (value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your ticket number!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (!RegExp(r'^#\d{9}$').hasMatch(value)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('The format should be like # and nine numbers.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                } else {
                  TicketDetailsCubit.get(context)
                      .findAndPrintTicket(orderId: value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Ticket number accepted: $value',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              width: 40.w,
              height: 50.h,
              buttonColor: const Color(0xFF560B76),
              frameColor: Colors.black,
              borderShape: BorderRadius.circular(10.r),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 6.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
