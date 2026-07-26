import 'package:dartz/dartz.dart';
import '../error/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;