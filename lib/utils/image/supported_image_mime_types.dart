enum SupportedMimeTypes {
  imageJpeg,
  imageJpg,
  imagePng,
  imageGif,
  imageWebp;

  String get name {
    switch (this) {
      case imageJpg:
        return 'image/jpg';
      case imageJpeg:
        return 'image/jpeg';
      case imagePng:
        return 'image/png';
      case imageGif:
        return 'image/gif';
      case imageWebp:
        return 'image/webp';
    }
  }
}
