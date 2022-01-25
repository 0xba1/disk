# Disk

A flutter plugin for android to get storage volumes' information.

## Add package from github

```yaml
dependencies:
  disk: ^0.3.1
```

## Example

```dart
    import 'package:disk/disk.dart';


    // To get paths of all mounted `StorageVolumes`
    StorageVolumes storageVolumes = StorageVolumes();
    List<StorageVolume> storageVolumeList = await storageVolumes.list;

    storageVolumeList.forEach((storageVolume) {
      print('${storageVolume.name}: ${storageVolume.path}');
    });

    // Get Storage information
    StorageVolume storageVolume = StorageVolume('/sdcard');
    int totalSpace = await storageVolume.totalSpace;
    int usedSpace = await storageVolume.usedSpace;
    int freeSpace = await storageVolume.freeSpace;



```
