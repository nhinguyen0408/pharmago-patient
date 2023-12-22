import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/base/bottom_bar.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/usecase/get_persional_profile_use_case.dart';
import 'package:pharmago_patient/presentation/views/home/cubit/home_state.dart';
import 'package:pharmago_patient/shared/constants/pref_key.dart';
import 'package:pharmago_patient/shared/constants/storage/shared_preference.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._persionalProfileUsecase) : super(HomeState());

  final PersionalProfileUsecase _persionalProfileUsecase;

  void ininttialize() async {
    final userData = AppSharedPreference.instance.getValue(PrefKeys.user) as int?;
    final userFullName =
        AppSharedPreference.instance.getValue(PrefKeys.username) as String?;
    if (userData == null) {
      final res = await getPersionalProfile();
      emit(
        state.copyWith(
          dataUser: PersionalProfileEntity(
            fullname: res?.fullname,
            id: res?.id,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          dataUser: PersionalProfileEntity(
            fullname: userFullName,
            id: userData,
          ),
        ),
      );
    }
  }

  void onPageChange(TabCode page) {
    emit(state.copyWith(pageSelected: page));
  }

  Future<PersionalProfileEntity?> getPersionalProfile() async {
    final PersionalProfileInput input = PersionalProfileInput();
    final res = await _persionalProfileUsecase.execute(input);
    return res.response.data;
  }
}
