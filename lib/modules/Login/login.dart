import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:matjree/layout/shop_layout.dart';
import 'package:matjree/modules/sign_up/SignUp_Screen.dart';
import 'package:matjree/network/local/cache_helper.dart';
import 'package:matjree/shared/components/components.dart';
import 'package:matjree/shared/components/constants.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),

      child: BlocConsumer <LoginCubit, LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState)
            {
              if(state.loginModel.status)
              {
                CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data.token).
                then((value)
                {
                navigateAndFinish(context, HomeLayout());
                });
              }
              else
                {
                  showToast(text: state.loginModel.message, state: ToastStates.ERROR);
                }
            }
        },
        builder: (context,state)=>Scaffold(
            appBar: AppBar(
              title: Text(
                'sign-in',style: TextStyle(color: Colors.grey),),
              centerTitle: true,
            ),
            body: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                              children: [

                                Row(
                                  children: [
                                    Text(
                                      "Welcome Back !",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30
                                      ),
                                    ),
                                    Lottie.asset('assets/lottie/hello.json', width: 90),
                                  ],
                                ),
                                SizedBox(height: 20),
                                signInForm(
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'please enter your email address';
                                    }
                                  },
                                  controller: emailController,
                                  label: "E-mail",
                                  type: TextInputType.emailAddress,
                                  suffix: Icons.email_outlined,
                                  hint: "Enter your email",
                                ),
                                SizedBox(height: 35),
                                signInForm(
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'password is too short';
                                      }
                                    },
                                    controller: passwordController,
                                    label: "Password",
                                    isPassword: LoginCubit.get(context).isPassword,
                                    type: TextInputType.visiblePassword,
                                    suffix: LoginCubit.get(context).suffix,
                                    hint: "Enter your password",
                                    suffixPressed: (){
                                      LoginCubit.get(context).changePasswordVisibility();
                                    },
                                  onSubmit: (value)
                                  {
                                    if (formKey.currentState.validate()) {
                                      LoginCubit.get(context)
                                          .userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  }
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                        'Remember me',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: kSecondaryColor

                                        )),
                                    Checkbox(value: false, onChanged: (value){}),
                                    Spacer(),
                                    Text(
                                      'Forget password ?',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 13,

                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),

                                 ConditionalBuilder
                                   (
                                   condition: state is! LoginLoadingState ,
                                   builder: (context)=>defaultButton(
                                       function: () {
                                         if (formKey.currentState.validate()) {
                                           LoginCubit.get(context)
                                               .userLogin(
                                             email: emailController.text,
                                             password: passwordController.text,
                                           );
                                         }
                                       },
                                       text: 'Login',
                                       radius: 20,
                                       background: primaryColor),
                                   fallback:(context)=> Center(
                                     child: Lottie.asset('assets/lottie/loader.json',width: 100),
                                   ) ,
                                 ),

                                SizedBox(height: 70),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don’t have an account? ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kSecondaryColor
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    defaultTextButton(
                                      function: () {navigateTo(context, SignUpScreen());} ,
                                      text: 'Sign Up',
                                      color: primaryColor,
                                    ),
                                  ],
                                )]),
                        ),
                      ),
                    ),
                  ),
                ))
        ),
      ),
    );
  }
}
