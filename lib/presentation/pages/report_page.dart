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
  late Future<List<Report>> futureReport;
  late XFile? image = null;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureReport = GetReport.fetchReport();
  }

  final List<Widget> _pages = [
    const HomePage(),
    // const ReportPage(),
    const ContactsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _pages[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(GetReport.fetchReport());
    return Scaffold(
      body: FutureBuilder<List<Report>>(
        future: futureReport,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final report = snapshot.data!;
            return ListView.builder(
              itemCount: report.length,
              itemBuilder: (context, index) {
                final reportDelete = report[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 345),
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
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                  icon:
                                      const Icon(Icons.delete_outline_outlined),
                                  onPressed: () {
                                    _deleteReport(reportDelete.id.toString());
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Judul Laporan: ${reportDelete.title ?? ''}',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        color: Color(0xFF9CA356),
                                      ),
                                    ),
                                    Text(
                                      'Lokasi: ${reportDelete.location ?? ''}',
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
                        ),
                      ),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF58A356),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InsertPage(),
            ),
          );
        },
        child: Image.asset('assets/images/add-report.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _deleteReport(String reportId) async {
    try {
      final apiDelete = ApiDelete();
      await apiDelete.deleteReport(reportId);
      setState(() {
        futureReport = GetReport.fetchReport();
      });
      // print('Laporan berhasil dihapus');
      _showDeleteSuccess();
    } catch (e) {
      print('Error saat menghapus laporan: $e');
    }
  }

  Future<void> _showDeleteSuccess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD4F3C4),
          title: const Text(
            'Sukses',
            style: TextStyle(
              color: Color(0xFF58A356),
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Data Berhasil Dihapus.',
                  style: TextStyle(color: Color(0xFF58A356)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
