import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/services/disease_provider.dart';
import 'package:plant_disease_detector/services/hive_database.dart';
import 'package:plant_disease_detector/src/home_page/models/disease_model.dart';
import 'package:plant_disease_detector/src/suggestions_page/suggestions.dart';

// class HistorySection extends SliverFixedExtentList {
//   HistorySection(Size size, BuildContext context, DiseaseService diseaseService,
//       {Key? key})
//       : super(
//           key: key,
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, index) {
//               return ValueListenableBuilder<Box<Disease>>(
//                 valueListenable: Boxes.getDiseases().listenable(),
//                 builder: (context, box, _) {
//                   final diseases = box.values.toList().cast<Disease>();

//                   if (diseases.isNotEmpty) {
//                     return Padding(
//                       padding: EdgeInsets.fromLTRB((0.053 * size.height * 0.3),
//                           (0.053 * size.height * 0.3), 0, 0),
//                       child: SizedBox(
//                           width: size.width,
//                           child: ListView.builder(
//                             itemCount: diseases.length,
//                             padding: EdgeInsets.symmetric(
//                                 vertical: (0.035 * size.height * 0.3)),
//                             itemExtent: size.width * 0.9,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return _returnHistoryContainer(diseases[index],
//                                   context, diseaseService, size);
//                             },
//                           )),
//                     );
//                   } else {
//                     return _returnNothingToShow(size);
//                   }
//                 },
//               );
//             },
//             childCount: 1,
//           ),
//           itemExtent: size.height * 0.3,
//         );
// }

class HistorySection extends StatefulWidget {
  final Size size;
  final DiseaseService diseaseService;

  const HistorySection(
      {Key? key, required this.size, required this.diseaseService})
      : super(key: key);

  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Disease>>(
      valueListenable: Boxes.getDiseases().listenable(),
      builder: (context, box, _) {
        final diseases = box.values.toList().cast<Disease>();

        if (diseases.isNotEmpty) {
          return SizedBox(
              width: widget.size.width,
              height: Dimensions.height45 * 5,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: diseases.length,
                itemExtent: widget.size.width * 0.9,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _returnHistoryContainer(diseases[index], context,
                      widget.diseaseService, widget.size);
                },
              ));
        } else {
          return _returnNothingToShow(widget.size);
        }
      },
    );
  }
}

Widget _returnHistoryContainer(Disease disease, BuildContext context,
    DiseaseService diseaseService, Size size) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        (0.053 * size.height * 0.3), 0, (0.053 * size.height * 0.3), 0),
    child: GestureDetector(
      onTap: () {
        // Set disease for Disease Service
        diseaseService.setDiseaseValue(disease);

        Navigator.restorablePushNamed(
          context,
          Suggestions.routeName,
        );
      },
      child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.file(
                  File(disease.imagePath),
                ).image,
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kAccent,
                  spreadRadius: 0.5,
                  blurRadius: (0.022 * size.height * 0.3),
                ),
              ],
              color: AppColors.kSecondary,
              borderRadius: BorderRadius.circular((0.053 * size.height * 0.3))),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Disease: ${disease.name}',
                    style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: (0.066 * size.height * 0.3),
                      fontFamily: 'SFBold',
                    )),
                Text(
                    'Date: ${disease.dateTime.day}/${disease.dateTime.month}/${disease.dateTime.year}',
                    style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: (0.066 * size.height * 0.3),
                      fontFamily: 'SFBold',
                    )),
              ],
            ),
          )),
    ),
  );
}

Widget _returnNothingToShow(Size size) {
  return Padding(
    padding: EdgeInsets.fromLTRB((0.053 * size.height * 0.3),
        (0.053 * size.height * 0.3), (0.053 * size.height * 0.3), 0),
    child: Container(
        height: Dimensions.height45 * 4.5,
        decoration: BoxDecoration(
            color: AppColors.kMain,
            borderRadius: BorderRadius.circular((0.053 * size.height * 0.3))),
        child: Center(
            child: Text(
          'Nothing to show',
          style: TextStyle(
            color: AppColors.kWhite,
            fontSize: Dimensions.font20,
          ),
        ))),
  );
}
