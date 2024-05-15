import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:silangka/config/API/API-GetContacts.dart';
import 'package:silangka/lib/clipboard_utils.dart';
import 'package:silangka/presentation/models/contacts_model.dart';
import 'package:icons_plus/icons_plus.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);
  static const String routeName = '/contacts';

  @override
  _ContactsPage createState() => _ContactsPage();
}

class _ContactsPage extends State<ContactsPage> {
  final _apiContacts = ApiContacts();
  Contact? _contact;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final contact = await _apiContacts.fetchContact();
      setState(() {
        _contact = contact;
        _isLoading = false;
        print('Contact data: $_contact');
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      print('Error fetching contacts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4F3C4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD4F3C4),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Hubungi Kami',
                style: TextStyle(
                  fontFamily: 'Nexa',
                  color: Color(0xFF58A356),
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _contact != null
                      ? Card(
                          color: const Color(0xFF58A356),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        BoxIcons.bx_photo_album,
                                                        size: 25,
                                                        color:
                                                            Color(0xFFF8ED8E)),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      '${_contact!.fax}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFFF8ED8E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                      BoxIcons.bx_copy),
                                                  color: Color(0xFFF8ED8E),
                                                  onPressed: () {
                                                    copyToClipboardAndShowSnackbar(
                                                        context, _contact!.fax);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        BoxIcons.bx_phone,
                                                        size: 25,
                                                        color:
                                                            Color(0xFFF8ED8E)),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      '${_contact!.phone}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFFF8ED8E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                      BoxIcons.bx_copy),
                                                  color: Color(0xFFF8ED8E),
                                                  onPressed: () {
                                                    copyToClipboardAndShowSnackbar(
                                                        context,
                                                        _contact!.phone);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        BoxIcons.bx_envelope,
                                                        size: 25,
                                                        color:
                                                            Color(0xFFF8ED8E)),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      '${_contact!.email}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFFF8ED8E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                      BoxIcons.bx_copy),
                                                  color: Color(0xFFF8ED8E),
                                                  onPressed: () {
                                                    copyToClipboardAndShowSnackbar(
                                                        context,
                                                        _contact!.email);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      BoxIcons.bxl_instagram,
                                                      size: 25,
                                                      color: Color(0xFFF8ED8E),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      _contact!.instagram,
                                                      style: const TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFFF8ED8E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                      BoxIcons.bx_copy),
                                                  color: Color(0xFFF8ED8E),
                                                  onPressed: () {
                                                    copyToClipboardAndShowSnackbar(
                                                        context,
                                                        _contact!.instagram);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        BoxIcons.bxl_facebook,
                                                        size: 25,
                                                        color:
                                                            Color(0xFFF8ED8E)),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      '${_contact!.facebook}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFFF8ED8E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                      BoxIcons.bx_copy),
                                                  color: Color(0xFFF8ED8E),
                                                  onPressed: () {
                                                    copyToClipboardAndShowSnackbar(
                                                        context,
                                                        _contact!.facebook);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Icon(BoxIcons.bx_home,
                                                    size: 25,
                                                    color: Color(0xFFF8ED8E)),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    '${_contact!.address}',
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 13,
                                                      color: Color(0xFFF8ED8E),
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                      BoxIcons.bx_copy),
                                                  color:
                                                      const Color(0xFFF8ED8E),
                                                  onPressed: () {
                                                    copyToClipboardAndShowSnackbar(
                                                        context,
                                                        _contact!.address);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : const Text('Tidak ada data kontak'),
            ],
          ),
        ),
      ),
    );
  }
}
