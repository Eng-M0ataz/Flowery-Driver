import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class ImagePick {
  Future<dynamic> pickImage({ImageSource? imageSource});
}

class FromImagePickerPackage implements ImagePick {
  FromImagePickerPackage({ImagePicker? picker})
    : imagePicker = picker ?? ImagePicker();

  final ImagePicker imagePicker;
  @override
  Future<XFile?> pickImage({ImageSource? imageSource}) async {
    return await imagePicker.pickImage(source: imageSource!);
  }
}

class FromFlutterDocScannerPackage implements ImagePick {
  @override
  Future<dynamic> pickImage({ImageSource? imageSource}) async {
    dynamic scannedDocuments;
    try {
      scannedDocuments =
          await FlutterDocScanner().getScannedDocumentAsImages(page: 1) ??
          'Unknown platform documents';
    } on PlatformException {
      scannedDocuments = 'Failed to get scanned documents.';
    }
    return scannedDocuments;
  }
}
