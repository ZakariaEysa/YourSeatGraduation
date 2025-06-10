import 'package:flutter/material.dart';
import '../widgets/contract_part/contract_body.dart';

class Contract extends StatelessWidget {
  const Contract({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ContractBody(),
      ),
    );
  }
}
