import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController =TextEditingController();

  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {
            if(state is ShopLoginSuccessState){
                if(state.loginModel.status){
                  CacheHelper.saveData(
                      key: 'token',
                      value: state.loginModel.data.token
                  ).then((value) {
                    token =state.loginModel.data.token;
                    navigateToAndFinish(context,const ShopLayout());
                  });

                } else {
                  print(state.loginModel.message);
                  showToast(
                    color: Colors.red,
                    message: state.loginModel.message,
                  );
                }
            }

        },
        builder: (context,state){

          var cubit = ShopLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 35
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'login now to browse our offers',
                          style:Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 30),
                        defaultFormField(
                            controller: emailController,
                            type:TextInputType.emailAddress,
                            labelText: "Email Address",
                            prefix: Icons.email_outlined,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Email Address';
                              }
                            }
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            labelText: "Password",
                            isPassword:cubit.isPassword,
                            prefix: Icons.lock,
                            suffix: cubit.suffix,
                            suffixpressed: (){
                              cubit.changePasswordVisibility();
                            },
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Password';
                              }
                            }
                        ),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context){
                              return defaultButton(
                                text: "LOGIN",
                                onPressed:(){
                                  if(formKey.currentState.validate()){
                                    cubit.userLogin(
                                       email: emailController.text,
                                       password: passwordController.text
                                   );
                                  }
                                },
                              );
                            },
                            fallback: (context)=>const Center(child: CircularProgressIndicator(),)
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text(
                              "I've not an account?",
                            ),
                            defaultTextButton(
                                text: "Register",
                                onPressed: (){
                                  navigateTo(context,ShopRegisterScreen());
                                }
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



