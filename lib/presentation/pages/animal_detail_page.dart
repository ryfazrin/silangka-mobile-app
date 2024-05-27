import 'package:flutter/material.dart';
import 'package:silangka/presentation/models/animals_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:silangka/config/resources/app_colors.dart';
import 'package:silangka/config/resources/app_resources.dart';
import 'package:silangka/presentation/widgets/indicator.dart';
import 'package:silangka/config/config.dart';

class AnimalDetailPage extends StatefulWidget {
  final Animal animal;

  AnimalDetailPage({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  final String baseUrl = Config.baseUrl;
  int touchedIndex = -1;

  final List<Color> pieColors = [
    AppColors.contentColorPurple,
    AppColors.contentColorYellow,
    AppColors.contentColorBlue,
    AppColors.contentColorGreen,
    AppColors.contentColorRed,
    AppColors.contentColorPink,
    AppColors.contentColorCyan,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.animal.name,
          style: const TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
            color: Color(0xFFF8ED8E),
          ),
        ),
        backgroundColor: const Color(0xFF58A356),
        foregroundColor: const Color(0xFFF8ED8E),
        scrolledUnderElevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.animal.imageUrl.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Border radius 8.0
                    child: Image.network(
                      '$baseUrl/animals/images/${widget.animal.imageUrl}',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/image-not-found.png', // Path to your placeholder image
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Nama Hewan          ',
                      style: TextStyle(
                        fontFamily: 'Nexa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                    TextSpan(
                      text: ': ${widget.animal.name}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Nama Latin              ',
                      style: TextStyle(
                        fontFamily: 'Nexa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                    TextSpan(
                      text: ': ${widget.animal.latinName}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Distribusi',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.animal.distribution}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Karakteristik',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.animal.characteristics}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Habitat',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.animal.habitat}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Jenis Makanan',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.animal.foodType}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Perilaku Unik',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.animal.uniqueBehavior}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Periode Kehamilan',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.animal.gestationPeriod}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (widget.animal.estimationAmounts != null && widget.animal.estimationAmounts!.isNotEmpty) ...[
                AspectRatio(
                  aspectRatio: 1.0,
                  child: PieChart(
                    PieChartData(
                      sections: showingSections(widget.animal.estimationAmounts!),
                      centerSpaceRadius: 80,
                      sectionsSpace: 0,
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: List.generate(widget.animal.estimationAmounts!.length, (index) {
                    return Indicator(
                      color: pieColors[index % pieColors.length],
                      text: 'Area: ${widget.animal.estimationAmounts![index].area ?? '-'}',
                      isSquare: true,
                    );
                  }),
                ),
              ] else ...[
                const Text(
                    'Tidak ada jumlah estimasi yang tersedia.',
                    style: TextStyle(
                      fontFamily: 'Nexa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      List<EstimationAmount> estimationAmounts) {
    List<PieChartSectionData> sections = [];

    for (int i = 0; i < estimationAmounts.length; i++) {
      final estimationAmount = estimationAmounts[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadow = [Shadow(color: Colors.black, blurRadius: 2)];

      if (estimationAmount.total != null) {
        final double? totalValue = double.tryParse(estimationAmount.total!);
        if (totalValue != null) {
          sections.add(
            PieChartSectionData(
              color: pieColors[i % pieColors.length],
              value: totalValue,
              title: '${estimationAmount.total ?? '-'} ekor',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadow,
              ),
            ),
          );
        }
      }
    }
    return sections;
  }
}
