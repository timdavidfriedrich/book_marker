import 'package:flutter/foundation.dart';

const bool isInDebugMode = bool.fromEnvironment("DEBUG_MODE") || kDebugMode || kProfileMode;

const String apiBaseUrl = String.fromEnvironment("API_BASE_URL");

const String googleBooksApiKey = String.fromEnvironment("GOOGLE_BOOKS_API_KEY");

// * Dev-only: seed example data on first launch when the library is empty. Set to
// * false (or remove with sample_data_seeder.dart) to disable.
const bool seedSampleData = true;
