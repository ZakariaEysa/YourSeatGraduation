import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/cubit/settings_cubit.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => CountryState();
}

class CountryState extends State<Country> {
  final List<String> countries = [
    "Fayoum",
    "Cairo",
    "Alex",
    "Giza",
  ];
  bool validateCountry() {
    return SettingsCubit.get(context).selectedCountry != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownWidget(
                hintText: 'city',
                selectedValue: SettingsCubit.get(context).selectedCountry,
                itemsList: countries,
                onChanged: (String? newValue) {
                  setState(() {
                    SettingsCubit.get(context).selectedCountry = newValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final String hintText;
  final String? selectedValue;
  final List<String> itemsList;
  final ValueChanged<String?> onChanged;

  const DropdownWidget({
    required this.hintText,
    required this.selectedValue,
    required this.itemsList,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      width: 40.w,
      height: 51.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEB68E3)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text(
          hintText,
          style: const TextStyle(color: Colors.black),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          size: 10.sp,
          color: const Color(0XFFEB68E3),
        ),
        items: itemsList.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
