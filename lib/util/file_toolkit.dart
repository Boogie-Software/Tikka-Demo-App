import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// A class providing a set of utility methods for using and managing
/// files.
class FileToolkit {
  
  // A directory owned privately by an application
  Directory? _applicationDocumentsDirectory;

  /// Gets a [File] with the given [fileName] asynchronously.
  Future<File> getFile(String fileName) async {
    final appDirectory = await getAppDocumentDirectory();
    return File('${appDirectory.path}/$fileName');
  }

  /// Gets a [File] with the given [fileName] from a directory
  /// specified by [directoryPath] asynchronously.
  Future<File> getFileInDirectory(String directoryPath, String fileName) async {
    final appDirectory = await getAppDocumentDirectory();
    return File('${appDirectory.path}/$directoryPath/$fileName');
  }

  /// Gets a [Directory] with the given [directoryPath] asynchronously.
  Future<Directory> getDirectory(String directoryName) async {
    final appDirectory = await getAppDocumentDirectory();
    return Directory('${appDirectory.path}/$directoryName');
  }

  /// Gets a list of files contained by the directory specified by the given
  /// [directoryName].
  Future<List<File>> getFilesInDirectory(String directoryName) async {
    final directory = await getDirectory(directoryName);
    final entities = await directory.list().toList();
    final List<File> files = List.empty(growable: true);

    for (var entity in entities) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }

  /// Gets the private application documents directory asynchronously.
  Future<Directory> getAppDocumentDirectory() async {
    _applicationDocumentsDirectory ??= await getApplicationDocumentsDirectory();
    return _applicationDocumentsDirectory!;
  }

  /// Creates the directory specified with the given [directoryPath]
  /// asynchronously if it doesn't already exist.
  void createDirectoryIfNotExists(String directoryPath) async {
    final appDirectory = await getAppDocumentDirectory();
    final directory = Directory('${appDirectory.path}/$directoryPath');
    final exists = await directory.exists();

    if (!exists) {
      await directory.create(recursive: true);
    }
  }

}