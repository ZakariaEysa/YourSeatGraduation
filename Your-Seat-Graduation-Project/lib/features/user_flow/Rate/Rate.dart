import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/scaffold/scaffold_f.dart';
import 'Rating.dart';

class Rate extends StatelessWidget {
  const Rate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldF(
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 130.h), Rating()],
        ),
      ),
    );
  }
}
