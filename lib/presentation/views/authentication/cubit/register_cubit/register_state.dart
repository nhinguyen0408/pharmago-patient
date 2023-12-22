import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/shared/constants/enums/type_account_enum.dart';

import '../../../../constants/colors.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const RegisterState._();

  const factory RegisterState({
    /// This variable represent name of Team/Company
    @Default('') String name,
    @Default('') String phone,
    @Default('') String fullName,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool showConfirmPassword,
    @Default(false) bool showPassword,


    @Default(false) bool isLoading,
    @Default(AccountTypeEnum.admin) AccountTypeEnum accountType,
  }) = _RegisterState;
}

enum AccountType {
  individual(title: 'Individual', content: 'Only for one user', color: green_1, icon: Icons.person_outline),
  team(title: 'Team', content: 'Upto 20 users', color: blue_1, icon: Icons.group),
  agency(title: 'Agency', content: 'Unlimited user', color: mainColor, icon: Icons.build);

  final String title;
  final String content;
  final Color color;
  final IconData icon;

  const AccountType({
    required this.title,
    required this.content,
    required this.color,
    required this.icon,
  });
}