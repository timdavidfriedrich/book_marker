import Flutter
import UIKit

private let channelName = "de.timdavidfriedrich.book_marker/jpeg_encoder"
private let encodeMethod = "encode"
private let bytesPerPixel = 4
private let maximumQuality = 100.0

final class JpegEncoder {
  private let channel: FlutterMethodChannel
  private let queue = DispatchQueue(label: channelName, qos: .userInitiated)

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == encodeMethod else {
        result(FlutterMethodNotImplemented)
        return
      }
      guard let arguments = call.arguments as? [String: Any],
        let pixels = arguments["pixels"] as? FlutterStandardTypedData,
        let width = arguments["width"] as? Int,
        let height = arguments["height"] as? Int,
        let quality = arguments["quality"] as? Int
      else {
        result(
          FlutterError(
            code: "invalid_arguments",
            message: "pixels, width, height and quality are required",
            details: nil))
        return
      }
      self?.queue.async {
        let encoded = JpegEncoder.encode(
          pixels.data, width: width, height: height, quality: quality)
        DispatchQueue.main.async {
          guard let encoded else {
            result(
              FlutterError(
                code: "encode_failed", message: "could not encode the image", details: nil))
            return
          }
          result(FlutterStandardTypedData(bytes: encoded))
        }
      }
    }
  }

  private static func encode(_ data: Data, width: Int, height: Int, quality: Int) -> Data? {
    let bytesPerRow = width * bytesPerPixel
    guard data.count >= bytesPerRow * height,
      let provider = CGDataProvider(data: data as CFData),
      let image = CGImage(
        width: width,
        height: height,
        bitsPerComponent: 8,
        bitsPerPixel: bytesPerPixel * 8,
        bytesPerRow: bytesPerRow,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue),
        provider: provider,
        decode: nil,
        shouldInterpolate: false,
        intent: .defaultIntent)
    else {
      return nil
    }
    return UIImage(cgImage: image).jpegData(compressionQuality: Double(quality) / maximumQuality)
  }
}
