package de.timdavidfriedrich.book_marker

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var jpegEncoder: JpegEncoder? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        jpegEncoder = JpegEncoder(flutterEngine.dartExecutor.binaryMessenger)
    }
}
