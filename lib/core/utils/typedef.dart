

import 'package:chatapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure,T>>;

typedef ResultVoid = ResultFuture<void>;