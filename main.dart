// ignore_for_file: use_build_context_synchronously

// import 'dart:developer' as dev;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Device Name : '),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: kToolbarHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            PermissionManager(context).checkAndRequestPermission();
          },
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(side: BorderSide.none),
            ),
          ),
          child: const Text('Allow Permission'),
        ),
      ),
    );
  }
}

class PermissionManager {
  PermissionManager(this.context);
  BuildContext context;
  Future<void> checkAndRequestPermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    // if (android.version.sdkInt <= 33) {
    //   print('istrue ${android.data}');
    // }
    if (await Permission.photos.request().isGranted) {
      print('permission is granted');
    } else if (await Permission.photos.request().isDenied) {
      print('permission is Denied');
      // openAppSettings();
    } else if (await Permission.photos.request().isPermanentlyDenied) {
      print('permission is permanently Denied');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Allow Permission'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel')),
              const TextButton(
                onPressed: openAppSettings,
                child: Text('setting'),
              ),
            ],
          );
        },
      );
    }
    if (await Permission.videos.request().isGranted) {
      print('permission is video granted');
    } else if (await Permission.videos.request().isDenied) {
      print('permission is video Denied');
      // openAppSettings();
    } else if (await Permission.videos.request().isPermanentlyDenied) {
      print('permission is video permanently Denied');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Allow Permission'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              const TextButton(
                onPressed: openAppSettings,
                child: Text('setting'),
              ),
            ],
          );
        },
      );
    }
  }
}
