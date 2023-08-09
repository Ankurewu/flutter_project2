


import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do_riverpod/features/auth/repository/aut_repository.dart';

final authControllerProvider= Provider((ref){
 final authRepository= ref.watch(authRepositoryprovider);
return AuthController(authRepository:authRepository);

});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});


  void verifyOtpCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }){
    authRepository.verifyOtp(
      context: context, 
      smsCodeId: smsCodeId,
       smsCode: smsCode, 
       mounted: mounted);
  }


  void sendSms({
    required BuildContext context,
    required String phone,
  }){
    authRepository.sendOtp(
      context: context, 
      phone: phone);
  }
}