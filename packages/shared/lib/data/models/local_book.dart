// * plaintext, unlike the row it comes from. The data source decrypts on the
// * way out and encrypts on the way in, so the mappers above it never learn
// * that anything is encrypted
class const LocalBook({
  required final String id,
  required final String title,
  required final List<String> authors,
  required final String? isbn,
  required final String? thumbnailUrl,
  required final String? coverPath,
  required final String status,
  required final DateTime createdAt,
  required final DateTime lastUsedAt,
});
