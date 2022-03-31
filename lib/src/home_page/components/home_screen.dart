import 'package:flutter/material.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/services/disease_provider.dart';
import 'package:plant_disease_detector/src/home_page/components/greeting.dart';
import 'package:plant_disease_detector/src/home_page/components/history.dart';
import 'package:plant_disease_detector/src/home_page/components/instructions.dart';
import 'package:plant_disease_detector/src/home_page/components/titlesection.dart';
import 'package:plant_disease_detector/src/widgets/spacing.dart';
import 'package:provider/provider.dart';

import 'package:translator/translator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);

    // Data
    Size size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
          color: AppColors.kWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            verticalSpacing(Dimensions.height30),
            TitleSection(title: "Instructions"),
            InstructionsSection(),
            verticalSpacing(Dimensions.height30),
            TitleSection(title: "History"),
            verticalSpacing(Dimensions.height20),
            HistorySection(size: size, diseaseService: _diseaseService)
          ],
        ));
  }
}
