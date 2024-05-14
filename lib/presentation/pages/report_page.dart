import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silangka/presentation/pages/contacts.dart';
import 'package:silangka/presentation/pages/home_page.dart';
import 'package:silangka/presentation/pages/insert_page.dart';
import 'package:silangka/presentation/models/report_model.dart';
import 'package:silangka/config/API/API-GetReport.dart';
import 'package:silangka/config/API/API-DeleteReport.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);
  static const String routeName = '/reportpage';

  @override
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> {
  final formKey = GlobalKey<FormState>();
  String? selectedCategoryId;

  late XFile? image = null;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Report>>(
      future: GetReport.fetchReport(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final report = snapshot.data!;
          return ListView.builder(
            itemCount: report.length,
            itemBuilder: (context, index) {
              final reportDelete = report[index];
              final animalName = reportDelete.animal.getName();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 345,
                        ),
                        child: Container(
                          width: 345,
                          height: 185,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8ED8E),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                title: Text(
                                  reportDelete.animal.name,
                                  style: const TextStyle(
                                    fontFamily: 'Nexa',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF9CA356),
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                      Icons.delete_outline_outlined),
                                  onPressed: () {
                                    _deleteReport(reportDelete.id.toString());
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Terkirim',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 16, top: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Judul Laporan: ${reportDelete.title}',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        color: Color(0xFF9CA356),
                                      ),
                                    ),
                                    Text(
                                      'Lokasi: ${reportDelete.location}',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        color: Color(0xFF9CA356),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> _deleteReport(String reportId) async {
    try {
      final apiDelete = ApiDelete();
      await apiDelete.deleteReport(reportId);
      print('Laporan berhasil dihapus');
    } catch (e) {
      print('Error saat menghapus laporan: $e');
    }
  }
}
