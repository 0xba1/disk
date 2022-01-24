import 'package:disk/src/_disk.dart';
import 'package:equatable/equatable.dart';

class StorageVolume extends Equatable {
  final String _path;
  int? _totalSpace;
  int? _usedSpace;
  int? _freeSpace;

  StorageVolume(this._path);

  String get path => _path;

  String get name {
    return path.split("/").last;
  }

  // In Bytes
  Future<int> get totalSpace async {
    _totalSpace = await Disk.getTotalBytes(_path);
    return _totalSpace!;
  }

  // In Bytes
  Future<int> get usedSpace async {
    _usedSpace = await Disk.getUsedBytes(_path);
    return _usedSpace!;
  }

  // In Bytes
  Future<int> get freeSpace async {
    _freeSpace = await Disk.getFreeBytes(_path);
    return _freeSpace!;
  }

  Future<void> cacheDetails() async {
    await totalSpace;
    await usedSpace;
    await freeSpace;
  }

  // Cache
  int? get totalSpaceCache => _totalSpace;
  int? get usedSpaceCache => _usedSpace;
  int? get freeSpaceCache => _freeSpace;

  @override
  List<Object?> get props => [_path];

  @override
  String toString() {
    return "StorageVolume(path: $_path, totalSpace: $_totalSpace, usedSpace: $_usedSpace, freeSpace: $_freeSpace)";
  }
}
