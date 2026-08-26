import 'package:flutter/foundation.dart';

const bool isInDebugMode = bool.fromEnvironment("DEBUG_MODE") || kDebugMode || kProfileMode;

const String apiBaseUrl = String.fromEnvironment("API_BASE_URL");

const String googleBooksApiKey = String.fromEnvironment("GOOGLE_BOOKS_API_KEY");
