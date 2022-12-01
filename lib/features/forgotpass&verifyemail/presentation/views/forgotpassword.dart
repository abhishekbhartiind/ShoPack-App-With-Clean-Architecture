import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/local/shared_preference.dart';
import 'package:shop_app/core/utilities/enums.dart';
import 'package:shop_app/core/utilities/routes.dart';
import 'package:shop_app/core/utilities/strings.dart';
import '../../../../core/colors/colors.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../login/presentation/widgets/maintextformfield.dart';
import '../forgotpass&verifyemail_bloc/forgotpass&verifyemail_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController inputController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  VerifyStatus status = VerifyStatus.forgotPassword;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ForgetpasswordAndeVerifyEmailBloc,
              ForgetpasswordAndeVerifyEmailState>(
            builder: (context, state) {
              status =
                  BlocProvider.of<ForgetpasswordAndeVerifyEmailBloc>(context)
                      .status;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status == VerifyStatus.forgotPassword
                          ? AppStrings.forgetPasswordtext
                          : AppStrings.verify,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.dark,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      status == VerifyStatus.forgotPassword
                          ? AppStrings.enteremail
                          : AppStrings.enterLink,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: status == VerifyStatus.forgotPassword
                          ? MainTFF(
                              labelText: AppStrings.email,
                              hintText: AppStrings.email,
                              controller: inputController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.emptyEmail;
                                } else {
                                  if (!value.contains('@')) {
                                    return AppStrings.invalidEmail;
                                  }
                                }
                                return null;
                              },
                              isPassword: false,
                              borderRadius: 16,
                              inputType: TextInputType.emailAddress)
                          : MainTFF(
                              labelText: AppStrings.link,
                              hintText: AppStrings.link,
                              controller: inputController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.emptyLink;
                                } else {
                                  if (value.length < 9) {
                                    return AppStrings.invalidLink;
                                  }
                                }
                                return null;
                              },
                              isPassword: false,
                              borderRadius: 16,
                              inputType: TextInputType.text),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocConsumer<ForgetpasswordAndeVerifyEmailBloc,
                        ForgetpasswordAndeVerifyEmailState>(
                      listener: (context, state) {
                        if (state is ForgetpasswordFinishedState) {
                          showSnackbar(
                              state.data.message, context, ColorManager.green);
                        } else if (state is ForgetpasswordErrorState) {
                          showSnackbar(state.message, context, Colors.red);
                        }
                      },
                      builder: (context, state) {
                        return state is ForgetpasswordLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : status == VerifyStatus.forgotPassword
                                ? MainButton(
                                    text: AppStrings.send.toUpperCase(),
                                    ontab: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<
                                                    ForgetpasswordAndeVerifyEmailBloc>(
                                                context)
                                            .add(
                                                SendLink(inputController.text));
                                        formKey.currentState!.reset();
                                      }
                                    })
                                : MainButton(
                                    text: AppStrings.send.toUpperCase(),
                                    ontab: () {
                                      if (formKey.currentState!.validate()) {
                                        PreferenceHelper
                                            .saveDataInSharedPreference(
                                                key: "Link",
                                                value: inputController.text);
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.setPassword);
                                      }
                                    });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}