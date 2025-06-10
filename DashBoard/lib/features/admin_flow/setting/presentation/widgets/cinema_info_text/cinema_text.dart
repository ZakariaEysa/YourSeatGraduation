import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/cubit/settings_cubit.dart';
import '../../../../../../utils/validation_utils.dart';
import '../Text_filed.dart';

class CinemaText extends StatefulWidget {
  const CinemaText({super.key});

  @override
  State<CinemaText> createState() => CinemaTextState();
}

class CinemaTextState extends State<CinemaText> {
  String? _cinemaNameError;
  String? _emailError;
  String? _phoneError;
  String? _managerError;
  late SettingsCubit cubit;
  bool validateFields() {
    if (!mounted) return false; // Check if the widget is still mounted
    setState(() {
      _cinemaNameError = validateName(cubit.cinemaNameController.text.trim());
      _emailError = validateEmail(cubit.emailController.text.trim());
      _phoneError = validatePhone(cubit.phoneController.text.trim());
      _managerError = validateName(cubit.managerController.text.trim());
    });

    return _cinemaNameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _managerError == null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = SettingsCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFiled(
                label: "Cinema Name in English*",
                controller: cubit.cinemaNameController,
                onChanged: (value) => setState(() => _cinemaNameError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _cinemaNameError = validateName(value)),
                errorText: _cinemaNameError,
                hintText: 'Musfiq  Mohammed',
              ),
            ),
            Expanded(
              child: TextFiled(
                label: "Email Address*",
                controller: cubit.emailController,
                onChanged: (value) => setState(() => _emailError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _emailError = validateEmail(value)),
                errorText: _emailError,
                hintText: 'musfiqmohammed123@gmail.com',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
              child: TextFiled(
                label: "Phone Number*",
                controller: cubit.phoneController,
                onChanged: (value) => setState(() => _phoneError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _phoneError = validatePhone(value)),
                errorText: _phoneError,
                hintText: '01025687431',
              ),
            ),
            Expanded(
              child: TextFiled(
                label: "Cinema Manager Name*",
                controller: cubit.managerController,
                onChanged: (value) => setState(() => _managerError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _managerError = validateName(value)),
                errorText: _managerError,
                hintText: 'Musfiq ',
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  // void dispose() {
  //   // Dispose controllers safely
  //   if (mounted) {
  //     cubit.cinemaNameController.dispose();
  //     cubit.emailController.dispose();
  //     cubit.phoneController.dispose();
  //     cubit.managerController.dispose();
  //   }
  //

  @override
  void dispose() {
    super.dispose();
  }
}
