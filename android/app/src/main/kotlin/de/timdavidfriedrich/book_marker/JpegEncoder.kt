package de.timdavidfriedrich.book_marker

import android.graphics.Bitmap
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer
import java.util.concurrent.Executors

private const val CHANNEL_NAME = "de.timdavidfriedrich.book_marker/jpeg_encoder"
private const val ENCODE_METHOD = "encode"

class JpegEncoder(messenger: BinaryMessenger) {
    private val channel = MethodChannel(messenger, CHANNEL_NAME)
    private val executor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())

    init {
        channel.setMethodCallHandler { call, result ->
            if (call.method != ENCODE_METHOD) {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val pixels = call.argument<ByteArray>("pixels")
            val width = call.argument<Int>("width")
            val height = call.argument<Int>("height")
            val quality = call.argument<Int>("quality")
            if (pixels == null || width == null || height == null || quality == null) {
                result.error("invalid_arguments", "pixels, width, height and quality are required", null)
                return@setMethodCallHandler
            }
            executor.execute {
                val encoded = runCatching { encode(pixels, width, height, quality) }
                mainHandler.post {
                    encoded.fold(
                        onSuccess = { result.success(it) },
                        onFailure = { result.error("encode_failed", it.message, null) },
                    )
                }
            }
        }
    }

    private fun encode(pixels: ByteArray, width: Int, height: Int, quality: Int): ByteArray {
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        try {
            bitmap.copyPixelsFromBuffer(ByteBuffer.wrap(pixels))
            val stream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.JPEG, quality, stream)
            return stream.toByteArray()
        } finally {
            bitmap.recycle()
        }
    }
}
