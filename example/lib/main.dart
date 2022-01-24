import 'package:disk/disk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Disk Details'),
        ),
        body: StreamBuilder(
          stream: StorageVolumes.stream(interval: const Duration(seconds: 10)),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            StorageVolumes storageVolumes = snapshot.data as StorageVolumes;

            return ListView.builder(
              itemCount: storageVolumes.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: storageVolumes.storageVolumeListCache![index]
                      .cacheDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    StorageVolume storageVolume =
                        storageVolumes.storageVolumeListCache![index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name: ${storageVolume.name}"),
                        Text("Path: ${storageVolume.path}"),
                        Text(
                            "Total Space: ${storageVolume.totalSpaceCache} Bytes"),
                        Text(
                            "Used Space: ${storageVolume.usedSpaceCache} Bytes"),
                        Text(
                            "Free Space: ${storageVolume.freeSpaceCache} Bytes"),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
