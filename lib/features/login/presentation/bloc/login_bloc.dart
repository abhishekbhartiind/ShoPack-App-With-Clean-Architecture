// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/core/utilities/constants.dart';
import 'package:shop_app/features/login/domin/entities/login_entity.dart';
import 'package:shop_app/features/login/domin/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc(
    this.loginUsecase,
  ) : super(LoginInitialState()) {
    on<UserLogin>((event, emit) async {
      emit(LoginLoadingState());
      final failureOrSuccess = await loginUsecase(
          LoginUsecaseParams(email: event.email, password: event.password));
      failureOrSuccess.fold(
          (failure) => emit(LoginErrorState(mapFailureToMessage(failure))),
          (success) => emit(LoginFinishedState(data: success)));
    });
  }
}
