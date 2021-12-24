# Disk 
A flutter plugin for android to get storage volumes' information.

## Add package from github
```yaml
dependencies:
  disk:
    git:
      url: git://github.com/0xba1/disk
      ref: main
```



## Example

```dart
    import 'package:disk/disk.dart';
    
    String path = "/sdcard/";
    int totalSpace = Disk.getTotalBytes(path);
    int freeSpace = Disk.getUsedBytes(path);
    int usedSpace = totalSpace - freeSpace;
    
    // To get paths of all mounted `StorageVolumes`
    // For SDK 30 and above
    // [{"path": path, "name": name}, {"path": path, "name": name}]
    List<String> storageVolumePaths = Disk.getStorageVolumePaths();
    
    for storageVolumePath in storageVolumes {
        print("storageVolumePath");
    }
    
    
```

