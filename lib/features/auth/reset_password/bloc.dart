

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';


part 'states.dart';
part 'events.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents,ResetPasswordStates> {
  final DioHelper dioHelper;
  ResetPasswordBloc(this.dioHelper) : super(ResetPasswordStates()){
    on<PostResetPasswordDataEvent>(_postData);
  }
 late String phone,code;
  final newPasswordController=TextEditingController();
  final confirmNewPasswordController=TextEditingController();
 Future <void> _postData (PostResetPasswordDataEvent event,Emitter<ResetPasswordStates> emit)async{
     emit(ResetPasswordLoadingState());
   final map ={
     "phone":phone,
     "code":code,
     "password":confirmNewPasswordController.text,

   };
   final response =await dioHelper.post("reset_password",data: map);
   if(response.isSuccess){
     emit(ResetPasswordSuccessState(message: response.message));
     debugPrint(response.message);

   }else{
     emit(ResetPasswordErrorState(
       message: response.message,
       statueCode: response.response?.statusCode??200,
     ));

     debugPrint(response.message);
   }
 }
}