import 'package:blogger/core/error/exceptions.dart';
import 'package:blogger/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get userCurrentSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Session? get userCurrentSession => client.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await client.auth
          .signInWithPassword(password: password, email: email)
          .then((res) {
        if (res.user == null) {
          throw const ServerException('User is null');
        }
        return UserModel.fromJson(res.user!.toJson());
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await client.auth.signUp(
          password: password, email: email, data: {'name': name}).then((res) {
        if (res.user == null) {
          throw const ServerException('User is null');
        }
        return UserModel.fromJson(res.user!.toJson());
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (userCurrentSession != null) {
        final userData = await client
            .from('profiles')
            .select()
            .eq('id', userCurrentSession!.user.id);
        return UserModel.fromJson(userData.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
