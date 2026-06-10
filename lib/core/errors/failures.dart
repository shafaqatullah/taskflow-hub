import 'package:equatable/equatable.dart';

/// Base failure type for domain-layer error handling.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to access local storage.']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
