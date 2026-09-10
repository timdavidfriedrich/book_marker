import 'dart:typed_data';

import 'package:book_marker_client/book_marker_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_ocr_result.dart';

// * the only place the generated OCR types are used. It also translates the
// * server's two refusals into plain exceptions, so nothing above it has to
// * import a Serverpod type to tell them apart
abstract class OcrRemoteDataSource {
  Future<RemoteOcrResult> recognizePage(Uint8List image);
}

@Injectable(as: OcrRemoteDataSource)
class const OcrRemoteDataSourceImpl(
  final Client _client,
) implements OcrRemoteDataSource {
  @override
  Future<RemoteOcrResult> recognizePage(Uint8List image) async {
    try {
      final result = await _client.ocr.recognizePage(ByteData.view(image.buffer));
      return RemoteOcrResult(
        text: result.text,
        engine: result.engine,
        usedDay: result.usedDay,
        usedWeek: result.usedWeek,
        usedMonth: result.usedMonth,
      );
    } on OcrQuotaExhaustedException catch (exception) {
      throw CloudScanQuotaException(
        usedDay: exception.usedDay,
        usedWeek: exception.usedWeek,
        usedMonth: exception.usedMonth,
        limitDay: exception.limitDay,
        limitWeek: exception.limitWeek,
        limitMonth: exception.limitMonth,
      );
    } on OcrUnavailableException catch (exception) {
      throw CloudScanUnavailableException(exception.reason);
    } on Object catch (error) {
      throw CloudScanUnavailableException(error.toString());
    }
  }
}
