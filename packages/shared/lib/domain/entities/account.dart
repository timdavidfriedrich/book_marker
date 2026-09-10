import 'package:dart_mappable/dart_mappable.dart';

part 'account.mapper.dart';

@MappableClass()
class const Account({
  required final String id,
  required final String? displayName,
  required final String? email,
}) with AccountMappable;
