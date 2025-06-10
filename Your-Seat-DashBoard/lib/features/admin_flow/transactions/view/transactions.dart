import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/presentation/cubit/payment_cubit.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';
import '../widgets/sales_container.dart';
import '../widgets/payment_table.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  void initState() {
    super.initState();

    PaymentCubit.get(context).resetTransactionStats();
    PaymentCubit.get(context).getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    AppLogs.errorLog(state.toString());
                    if (PaymentCubit.get(context).transactions.isNotEmpty ||
                        state is TransactionSuccess) {
                      return Column(
                        children: [
                          SalesContainer(
                              status: PaymentCubit.get(context)
                                  .getTransactionStats()),
                          SizedBox(height: 20.h),
                          SizedBox(
                              width: 760.w,
                              child: PaymentTable(
                                  transactions:
                                      PaymentCubit.get(context).transactions)),
                        ],
                      );
                    } else if (state is PaymentError) {
                      return Center(child: Text(state.error));
                    } else
                      return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
