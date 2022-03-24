import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/services/disease_provider.dart';
import 'package:plant_disease_detector/src/home_page/home.dart';
import 'package:plant_disease_detector/src/home_page/models/disease_model.dart';
import 'package:plant_disease_detector/src/suggestions_page/components/plant_image.dart';
import 'package:plant_disease_detector/src/widgets/app_icon.dart';
import 'package:plant_disease_detector/src/widgets/big_text.dart';
import 'package:plant_disease_detector/src/widgets/small_text.dart';
import 'package:plant_disease_detector/src/widgets/spacing.dart';
import 'package:plant_disease_detector/src/widgets/suggestion_card.dart';
import 'package:provider/provider.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({Key? key}) : super(key: key);

  static const routeName = '/suggestions';

  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);

    Disease _disease = _diseaseService.disease;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bgr.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height45 * 11.5,
                child: Padding(
                  padding: EdgeInsets.all((0.02 * size.height)),
                  child: Column(
                    children: [
                      Flexible(
                        child: Center(
                          child: PlantImage(
                            borderColor: AppColors.kMain,
                            size: size,
                            imageFile: File(_disease.imagePath),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // icons section
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      size: Dimensions.height45,
                      icon: Icons.arrow_back_ios,
                      backgroundColor: AppColors.kMain,
                      iconColor: AppColors.kWhite,
                    ),
                  ),
                  horizontalSpacing(
                    Dimensions.screenWidth / 20,
                  ),
                  Text(
                    "Suggestions",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kMain,
                      fontFamily: "SFBold",
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.imgSize * 1.5 - 130,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height20,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.kMain,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius30),
                        topRight: Radius.circular(Dimensions.radius30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-3, -2),
                          blurRadius: 15,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: Dimensions.height10 / 2,
                        color: Color.fromARGB(172, 255, 255, 255),
                        indent: Dimensions.width30 * 4.5,
                        endIndent: Dimensions.width30 * 4.5,
                      ),
                      verticalSpacing(Dimensions.height10 * 2),
                      Container(
                        alignment: Alignment.center,
                        child: BigText(
                          text: _disease.name,
                          color: AppColors.kWhite,
                          size: Dimensions.font26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpacing(Dimensions.height10 * 2.5),
                      SmallText(
                        text: "Quick Guide",
                        color: AppColors.kWhite,
                        size: Dimensions.font16 * 1.05,
                        fontWeight: FontWeight.w600,
                      ),
                      verticalSpacing(Dimensions.height10 * 1.5),
                      Expanded(
                        child: Container(
                          height: 500,
                          child: Container(
                            child: Column(
                              children: [
                                SuggestionCard(
                                    title: "Possible causes",
                                    value: _disease.possibleCauses,
                                    assetImagePath:
                                        "assets/images/icon-leaf.png"),
                                verticalSpacing(Dimensions.height15),
                                SuggestionCard(
                                    title: "Possible Solution",
                                    value: _disease.possibleSolution,
                                    assetImagePath:
                                        "assets/images/solution.png"),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
