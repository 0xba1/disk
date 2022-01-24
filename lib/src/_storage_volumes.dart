import 'package:disk/src/_disk.dart';
import 'package:disk/src/_storage_volume.dart';
import 'package:equatable/equatable.dart';

class StorageVolumes extends Equatable {
  List<StorageVolume>? _storageVolumeList;

  StorageVolumes();

  int? get length => _storageVolumeList?.length;

  List<StorageVolume>? get storageVolumeListCache => _storageVolumeList;

  static Future<StorageVolumes> init() async {
    StorageVolumes storageVolumes = StorageVolumes();
    await storageVolumes.storageVolumeList;
    return storageVolumes;
  }

  Future<List<StorageVolume>> get storageVolumeList async {
    if (_storageVolumeList != null) return _storageVolumeList!;
    _storageVolumeList = (await Disk.getStorageVolumePaths())
        .map((path) => StorageVolume(path))
        .toList();
    return _storageVolumeList!;
  }

  static Stream<StorageVolumes> stream(
      {Duration interval = const Duration(seconds: 5)}) async* {
    StorageVolumes currentStorageVolumes = await StorageVolumes.init();
    yield currentStorageVolumes;

    while (true) {
      await Future.delayed(interval);
      StorageVolumes nextStorageVolumes = await StorageVolumes.init();
      if (nextStorageVolumes != currentStorageVolumes) {
        yield nextStorageVolumes;
        currentStorageVolumes = nextStorageVolumes;
      }
    }
  }

  @override
  List<Object?> get props => [_storageVolumeList];

  @override
  String toString() => 'StorageVolumes(_storageVolumes: $_storageVolumeList)';
}
