import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;


        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context){
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://avatars.githubusercontent.com/u/75587814?s=400&u=185dbb0b60cf484314ea7973106982fe902069e1&v=4'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        const SizedBox(height: 25,),
                        if(state is ShopGetUpdateUserLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Name';
                              }return null;
                            },
                            labelText: 'Name',
                            prefix: Icons.person
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Email Address';
                              }return null;
                            },
                            labelText: 'Email Address',
                            prefix: Icons.email_outlined
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Phone number';
                              }return null;
                            },
                            labelText: 'Phone',
                            prefix: Icons.phone
                        ),
                        const SizedBox(height: 15,),
                        defaultButton(
                            text: 'Update',
                            onPressed: (){
                              if(formKey.currentState.validate()){
                                cubit.updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }
                        ),
                        const SizedBox(height: 15,),
                        defaultButton(
                            text: 'LogOut',
                            onPressed: (){
                              signOut(context);
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          fallback: (context)=>const Center(child:CircularProgressIndicator()),
        );
      },
    );
  }
}
