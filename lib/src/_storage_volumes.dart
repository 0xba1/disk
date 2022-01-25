import 'package:disk/src/_disk.dart';
import 'package:disk/src/_storage_volume.dart';
import 'package:equatable/equatable.dart';

class StorageVolumes extends Equatable {
  List<StorageVolume>? _list;

  StorageVolumes();

  int? get length => _list?.length;

  List<StorageVolume>? get listCache => _list;

  static Future<StorageVolumes> init() async {
    StorageVolumes storageVolumes = StorageVolumes();
    await storageVolumes.list;
    return storageVolumes;
  }

  Future<List<StorageVolume>> get list async {
    if (_list != null) return _list!;
    _list = (await Disk.getStorageVolumePaths())
        .map((path) => StorageVolume(path))
        .toList();
    return _list!;
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
  List<Object?> get props => [_list];

  @override
  String toString() => 'StorageVolumes(_storageVolumes: $_list)';
}
