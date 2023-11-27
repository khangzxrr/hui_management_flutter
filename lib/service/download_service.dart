
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DownloadService {
  TaskEither<Exception, void> download(Uint8List bytes) => TaskEither.tryCatch(
      () async => kIsWeb
          ? await WebImageDownloader.downloadImageFromUInt8List(
              uInt8List: bytes,
              name: 'giay_giao_hui.png',
            )
          : await ImageGallerySaver.saveImage(
              bytes,
              name: 'giay_giao_hui',
              quality: 100,
            ),
      (error, stackTrace) => error as Exception);
}
