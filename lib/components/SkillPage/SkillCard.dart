import 'package:flutter/material.dart';
import 'package:ptf/pages/skillPage/data/SkillObjects.dart';

import 'SkillButton.dart';

class SkillCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.center,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            spacing: 30,
            children: List.generate(
              skillsetA.length,
              (index) {
                final obj = skillsetA[index];
                return SkillButton(
                  icon: obj.icon,
                  gradient: obj.gradient,
                  name: obj.name,
                );
              },
            ).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Wrap(
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.center,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            spacing: 30,
            children: List.generate(
              skillsetB.length,
              (index) {
                final obj = skillsetB[index];
                return SkillButton(
                  icon: obj.icon,
                  gradient: obj.gradient,
                  name: obj.name,
                );
              },
            ).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Wrap(
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.center,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            spacing: 30,
            children: List.generate(
              skillsetC.length,
              (index) {
                final obj = skillsetC[index];
                return SkillButton(
                  icon: obj.icon,
                  gradient: obj.gradient,
                  name: obj.name,
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}