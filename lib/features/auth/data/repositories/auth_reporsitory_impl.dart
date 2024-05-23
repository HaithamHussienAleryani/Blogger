import 'package:blogger/core/common/entities/user.dart';
import 'package:blogger/core/error/exceptions.dart';
import 'package:blogger/core/error/failures.dart';
import 'package:blogger/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blogger/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  const AuthRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _getUser(() async => await dataSource
        .loginWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(() async =>
        await dataSource.signUpWithEmailAndPassword(
            name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      return right(await fn());
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userData = await dataSource.getCurrentUserData();
      if (userData == null) {
        return left(Failure('User is not logged in'));
      }

      return right(userData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
