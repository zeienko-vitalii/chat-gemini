String getFileExtension(String fileName) {
  return ".${fileName.split('.').last}".toLowerCase();
}

String imageMimeTypeByFilePath(String filePath) {
  final extension = getFileExtension(filePath).substring(1);
  return 'image/$extension';
}
