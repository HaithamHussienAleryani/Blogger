import 'package:blogger/core/usecase/usecase.dart';
import 'package:blogger/features/auth/domain/entities/user.dart';
import 'package:blogger/features/auth/domain/usecases/current_user.dart';
import 'package:blogger/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blogger/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserSignIn userSignIn,
      required CurrentUser currentUser})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthCurrentUser>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(AuthCurrentUser event, Emitter emit) async {
    final response = await _currentUser(NoParams());
    response.fold((failure) => emit(AuthFailure(failure.message)), (user) {
      debugPrint("User info:${user.name}");
      emit(AuthSuccess(user));
    });
  }

  void _onAuthSignUp(event, emit) async {
    final response = await _userSignUp(UserSignUpParams(
        email: event.email, name: event.name, password: event.password));
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _onAuthSignIn(event, emit) async {
    final response = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }
}
