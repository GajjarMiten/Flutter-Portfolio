import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ptf/pages/skillPage/data/SkillObjects.dart';

class ChartCard extends StatefulWidget {
  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    showingBarGroups = List<BarChartGroupData>.generate(
      allSkill.length,
      (index) {
        final values = [90, 70, 45, 75, 80, 60, 75, 70, 70, 40, 65];
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              y: values[index].toDouble(),
              color: leftBarColor,
              width: width,
            ),
          ],
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          //  backgroundColor: const Color(0xff2c4260),
          maxY: 100,
          alignment: BarChartAlignment.spaceEvenly,
          barGroups: showingBarGroups,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(
                color: const Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              getTitles: (value) {
                return allSkill[value.toInt()].name;
              },
              rotateAngle: -60,
              margin: 50,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(
                color: const Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              getTitles: (value) {
                switch (value.toInt()) {
                  case 0:
                    return "0";
                    break;
                  case 50:
                    return "50";
                    break;
                  case 100:
                    return "100";
                    break;
                  default:
                    return "";
                }
              },
            ),
          ),
        ),
        swapAnimationDuration: Duration(milliseconds: 700),
      ),
    );
  }
}
