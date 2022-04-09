import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/setting_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: ChangeNotifierProvider(
          create: (_) => SettingProvider().setup(),
          child: Consumer<SettingProvider>(
            builder: (context, value, child) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text('Restaurant Notification'),
                    ),
                    Container(
                      child: FlutterSwitch(
                        width: 125.0,
                        height: 55.0,
                        valueFontSize: 25.0,
                        toggleSize: 45.0,
                        value: value.isScheduled,
                        borderRadius: 30.0,
                        padding: 8.0,
                        showOnOff: false,
                        onToggle: (val) async {
                          await value.setScheduled(val);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
