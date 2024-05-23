import 'package:blogger/core/common/entities/user.dart';
import 'package:blogger/core/error/failures.dart';
import 'package:blogger/core/usecase/usecase.dart';
import 'package:blogger/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
