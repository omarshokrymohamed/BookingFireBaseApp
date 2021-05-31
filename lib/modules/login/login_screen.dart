import 'package:booking_app/layout/layout.dart';
import 'package:booking_app/modules/login/cubit/cubit.dart';
import 'package:booking_app/modules/login/cubit/states.dart';
import 'package:booking_app/modules/signup/signup_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (BuildContext context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginScreenStates>(
        builder: (BuildContext context, state) {
          List errors = LoginScreenCubit.get(context).errors;
          bool remember = LoginScreenCubit.get(context).remember;
          LoginScreenCubit.get(context).context = context;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: ConditionalBuilder(
              condition: state is! LoginScreenLoadingState,
              builder: (BuildContext context) => SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.08,
                      ),

                      Text(
                        'WelcomeBack',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(26),
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5.0),
                      ),
                      Text(
                        'Sign with your email and password',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                      Text(
                        'or continue with social media',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                      // SizedBox(
                      //   height: getProportionateScreenHeight(100.0),
                      // ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.08,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultFormField(
                                validator: (String value) {
                                  if (value.isEmpty &&
                                      !errors.contains(kEmailNullError)) {
                                    LoginScreenCubit.get(context)
                                        .addEmailNullError();
                                  } else if (!emailValidatorRegExp
                                          .hasMatch(value) &&
                                      !errors.contains(kInvalidEmailError)) {
                                    LoginScreenCubit.get(context)
                                        .addEmailNotValidError();
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty &&
                                      errors.contains(kEmailNullError)) {
                                    LoginScreenCubit.get(context)
                                        .removeEmailNullError();
                                  } else if (emailValidatorRegExp
                                          .hasMatch(value) &&
                                      errors.contains(kInvalidEmailError)) {
                                    LoginScreenCubit.get(context)
                                        .removeEmailNotValidError();
                                  }
                                  return null;
                                },
                                controller: emailController,
                                radius: 24.0,
                                labelText: 'Email',
                                hintText: 'Enter your email'),
                            SizedBox(
                              height: getProportionateScreenHeight(25.0),
                            ),
                            defaultFormField(
                                validator: (String value) {
                                  if (value.isEmpty &&
                                      !errors.contains(kPassNullError)) {
                                    LoginScreenCubit.get(context)
                                        .addPassWordNullError();
                                  } else if (value.length < 6 &&
                                      !errors.contains(kShortPassError)) {
                                    LoginScreenCubit.get(context)
                                        .addPasswordShortError();
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty &&
                                      errors.contains(kPassNullError)) {
                                    LoginScreenCubit.get(context)
                                        .removePassWordNullError();
                                  } else if (value.length >= 6 &&
                                      errors.contains(kShortPassError)) {
                                    LoginScreenCubit.get(context)
                                        .removePasswordShortError();
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                radius: 24.0,
                                labelText: 'Password ',
                                hintText: 'Enter your password',
                                isPassword: true),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25.0),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: remember,
                            activeColor: kPrimaryColor,
                            onChanged: (bool value) {
                              LoginScreenCubit.get(context).changeCheck(value);
                            },
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(4.0),
                          ),
                          Text('Remember me'),
                          Spacer(),
                          Text('Forget Password ?'),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5.0),
                      ),
                      Column(
                        children: List.generate(
                          errors.length,
                          (index) => formErrorText(error: errors[index]),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      defaultButton(
                          text: 'Continue',
                          padding: 0.0,
                          function: () {
                            if (formKey.currentState.validate()&& LoginScreenCubit.get(context).errors.isEmpty) {
                              formKey.currentState.save();
                              LoginScreenCubit.get(context).login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          radius: 24.0),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          socialItem(
                              icon: 'assets/icons/google-icon.svg',
                              function: () {}),
                          SizedBox(
                            width: getProportionateScreenWidth(15.0),
                          ),
                          socialItem(
                            icon: 'assets/icons/facebook-2.svg',
                            function: () {},
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(15.0),
                          ),
                          socialItem(
                            icon: 'assets/icons/twitter.svg',
                            function: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ? "),
                          InkWell(
                              onTap: () {
                                navigateTo(context: context , route: SignUpScreen());
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: kPrimaryColor),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (ctx) => Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.04,
                          ),

                          Text(
                            'WelcomeBack',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(26),
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5.0),
                          ),
                          Text(
                            'Sign with your email and password',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                          Text(
                            'or continue with social media',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                          // SizedBox(
                          //   height: getProportionateScreenHeight(100.0),
                          // ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.08,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                defaultFormField(
                                    validator: (String value) {
                                      if (value.isEmpty &&
                                          !errors.contains(kEmailNullError)) {
                                        LoginScreenCubit.get(context).addEmailNullError();
                                      } else if (!emailValidatorRegExp
                                          .hasMatch(value) &&
                                          !errors.contains(kInvalidEmailError)) {
                                        LoginScreenCubit.get(context).addEmailNotValidError();
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      if (value.isNotEmpty &&
                                          errors.contains(kEmailNullError)) {
                                        LoginScreenCubit.get(context).removeEmailNullError();
                                      } else if (emailValidatorRegExp
                                          .hasMatch(value) &&
                                          errors.contains(kInvalidEmailError)) {
                                        LoginScreenCubit.get(context).removeEmailNotValidError();
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                    radius: 24.0,
                                    labelText: 'Email',
                                    hintText: 'Enter your email'),
                                SizedBox(
                                  height: getProportionateScreenHeight(25.0),
                                ),
                                defaultFormField(
                                    validator: (String value) {
                                      if (value.isEmpty &&
                                          !errors.contains(kPassNullError)) {
                                        LoginScreenCubit.get(context).addPassWordNullError();
                                      } else if (value.length < 6 &&
                                          !errors.contains(kShortPassError)) {
                                        LoginScreenCubit.get(context).addPasswordShortError();
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      if (value.isNotEmpty &&
                                          errors.contains(kPassNullError)) {
                                        LoginScreenCubit.get(context).removePassWordNullError();
                                      } else if (value.length >= 6 &&
                                          errors.contains(kShortPassError)) {
                                        LoginScreenCubit.get(context).removePasswordShortError();
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    radius: 24.0,
                                    labelText: 'Password ',
                                    hintText: 'Enter your password',
                                    isPassword: true),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25.0),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: remember,
                                activeColor: kPrimaryColor,
                                onChanged: (bool value) {
                                  LoginScreenCubit.get(context).changeCheck(value);

                                },
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(4.0),
                              ),
                              Text('Remember me'),
                              Spacer(),
                              Text('Forget Password ?'),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5.0),
                          ),
                          Column(
                            children: List.generate(
                              errors.length,
                                  (index) => formErrorText(error: errors[index]),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10.0),
                          ),
                          defaultButton(
                              text: 'Continue',
                              padding: 0.0,
                              function: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  // LoginScreenCubit.get(context).login(
                                  //     username: emailController.text,
                                  //     password: passwordController.text);

                                }
                              },
                              radius: 24.0),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              socialItem(
                                  icon: 'assets/icons/google-icon.svg',
                                  function: () {}),
                              SizedBox(
                                width: getProportionateScreenWidth(15.0),
                              ),
                              socialItem(
                                icon: 'assets/icons/facebook-2.svg',
                                function: () {},
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(15.0),
                              ),
                              socialItem(
                                icon: 'assets/icons/twitter.svg',
                                function: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account ? "),
                              InkWell(
                                  onTap: () {
                                    navigateTo(context: context , route: SignUpScreen());
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: kPrimaryColor),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, state) {
          if (state is LoginScreenSuccessState) {
            navigateAndFinish(context: context , route: LayoutScreen());
          }

          if (state is LoginScreenErrorState) {
            showToast(
              text: 'Error chick your email and password again !',
              isError: true,
            );
          }
        },
      ),
    );
  }
}
