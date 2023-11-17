import 'package:contadores_invia/Util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Database/database_helper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<dynamic, dynamic>> notifications = [];
  bool _markedAsRead = false;
  Future<void> _selectNotifications() async {
    List<Map<dynamic, dynamic>> notificationsList =
        await DatabaseHelper.selectNotifications();
    setState(() {
      notifications = notificationsList;
    });
    debugPrint(notifications.toString());
  }

  @override
  void initState() {
    _selectNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: HexColor(darkBlue),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor(darkBlue),
          systemNavigationBarColor: HexColor(darkBlue),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Excluir notificações'),
                    content: const Text(
                        'Tem certeza que deseja excluir todas as notificações? Essa ação não pode ser desfeita.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          DatabaseHelper.deleteNotifications();
                          _selectNotifications();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: const Text('Confirmar'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _markedAsRead = !_markedAsRead;
              });
            },
            icon: const Icon(Icons.mark_chat_read),
          ),
        ],
      ),
      body: notifications.length != 0
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 24.0.h, horizontal: 24.0.w),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0.0,
                        child: InkWell(
                          splashColor: Colors.black12,
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w, vertical: 8.0.h),
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/ic_launcher.png'),
                              title: Text(
                                notifications[index]['title'].toString(),
                                style: !_markedAsRead
                                    ? const TextStyle(
                                        fontWeight: FontWeight.bold)
                                    : const TextStyle(),
                              ),
                              subtitle: Text(
                                notifications[index]['body'].toString(),
                                style: !_markedAsRead
                                    ? const TextStyle(
                                        fontWeight: FontWeight.bold)
                                    : const TextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text('No data saved'),
            ),
    );
  }
}
