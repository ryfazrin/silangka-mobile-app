import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silangka/lib/database_helper.dart';
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
  Future<List<Report>>? futureReport;
  late XFile? image = null;
  int _selectedIndex = 0;
  bool isLandscape = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        futureReport = GetReport.fetchReport();
      });
      fetchAndSyncReports();
    } else {
      setState(() {
        futureReport = DatabaseHelper().fetchReports();
      });
    }
  }

  Future<void> fetchAndSyncReports() async {
    try {
      final databaseHelper = DatabaseHelper();
      List<Report> apiReports = await GetReport.fetchReport();

      // delete all by status terkirim
      databaseHelper.deleteReportByStatusTerkirim();
      // Insert API data into SQLite
      for (var report in apiReports) {
        print(report.animal.id);
        await databaseHelper.insert({
          'idBE': report.id,
          'title': report.title,
          'location': report.location,
          'animalCount': report.animalCount,
          'image': report.imageUrl,
          'categoryId': report.animal.id,
          'desc': report.desc,
          'status': 'Terkirim',
          'createdAt': report.createdAt,
        });
      }
      // Fetch combined data from SQLite
      setState(() {
        futureReport = DatabaseHelper().fetchReports();
      });
    } catch (e) {
      print(e);
    }
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
    return Scaffold(
      body: FutureBuilder<List<Report>>(
        future: futureReport,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final report = snapshot.data!;
            return ListView.builder(
              itemCount: report.length,
              itemBuilder: (context, index) {
                final detailReport = report[index];
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
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ConstrainedBox(
                                          constraints:
                                              BoxConstraints(minHeight: 700),
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                              children: [
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize
                                                        .min, // Use min to let the content dictate the size
                                                    children: <Widget>[
                                                                                    
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: Center(
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(8), // Border radius 8.0
                                                            child: detailReport.imageUrl.startsWith('/data') // Jika gambar dari internet
                                                                ? Image.file(
                                                              width: 300,
                                                              File(detailReport.imageUrl), // Jika gambar dari local cache
                                                            )
                                                                : Image.network(
                                                              width: 300,
                                                              'https://api-arutmin.up.railway.app/reports/images/${detailReport.imageUrl}',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                                                    
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 20),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${detailReport.title}',
                                                            style:
                                                                const TextStyle(
                                                              fontFamily: 'Nexa',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Color(
                                                                  0xFF9CA356),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 15),
                                                        child: Table(
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                const Text(
                                                                  'Jumlah Hewan: ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nexa',
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xFF9CA356),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${detailReport.animalCount}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Lato',
                                                                    fontSize: 14,
                                                                    color: Color(
                                                                        0xFF9CA356),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const TableRow(
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        20), // Adding space between rows
                                                                SizedBox(
                                                                    height:
                                                                        20), // Adding space between rows
                                                              ],
                                                            ),
                                                            TableRow(
                                                              children: [
                                                                const Text(
                                                                  'Lokasi: ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nexa',
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xFF9CA356),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${detailReport.location}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Lato',
                                                                    fontSize: 14,
                                                                    color: Color(
                                                                        0xFF9CA356),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            right: 15, left:15, bottom: 10),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Informasi lain-lain: ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      'Nexa',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xFF9CA356),
                                                                ),
                                                              ),
                                                              Text(
                                                                '${detailReport.desc}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF9CA356),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  title: Text(
                                    detailReport.animal.name,
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
                                      _showDeleteDialog(context, detailReport);
                                    },
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: detailReport.status == 'Terkirim'
                                        ? Colors.green
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    detailReport.status ?? '',
                                    style: const TextStyle(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Judul Laporan: ${detailReport.title ?? ''}',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        color: Color(0xFF9CA356),
                                      ),
                                    ),
                                    Text(
                                      'Lokasi: ${detailReport.location ?? ''}',
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
  void _showDeleteDialog(BuildContext context, Report detailReport) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this report?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (detailReport.idBE != null) {
                  _deleteReport(detailReport.idBE.toString());
                } else if (detailReport.id != null) {
                  _deleteReportDatabase(detailReport.id.toString());
                } else {
                  print('Invalid IDs');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteReportDatabase(String reportId) async{
    try{
      await DatabaseHelper().deleteReportById(reportId);
      _showDeleteSuccess();
      setState(() {
        futureReport = DatabaseHelper().fetchReports();
      });
    }catch (e){
      print('Error saat menghapus draft laporan: $e');
    }
  }

  Future<void> _deleteReport(String reportIdBE) async {
    try {
      // final connectivity = await Connectivity().checkConnectivity();
      // //ketika perangkat online
      // if (connectivity != ConnectivityResult.none) {
      //   final apiDelete = ApiDelete();
      //   await apiDelete.deleteReport(reportId);
      // }
      // await DatabaseHelper().deleteReportById(reportId);
      // _showDeleteSuccess();
      final apiDelete = ApiDelete();
      await apiDelete.deleteReport(reportIdBE);
      fetchAndSyncReports();
      // setState(()  {
      //   futureReport =  DatabaseHelper().fetchReports();
      // });
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
