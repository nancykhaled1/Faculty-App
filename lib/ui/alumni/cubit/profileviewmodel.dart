import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:faculty/domain/usecase/get_userdata_usecase.dart';
import 'package:faculty/ui/alumni/cubit/states.dart';

class ProfileViewModel extends Cubit<UserDataStates> {
  final GetUserdataUseCase getUserdataUseCase;

  ProfileViewModel({required this.getUserdataUseCase})
      : super(UserDataInitialStates());

  Future<void> getUserData(int id, String token) async {
    emit(UserDataLoadingStates(loadingMessage: 'جارٍ تحميل البيانات...'));

    final either = await getUserdataUseCase.invoke(id, token);

    either.fold(
          (failure) {
            print("❌ Failure: ${failure.detail}"); // اطبعي هنا
        emit(UserDataErrorStates(errorMessage: failure.detail));
      },
          (response) {
            print("✅ Success: ${response.graduationData?.user?.username}"); // اطبعي هنا
        emit(UserDataSuccessStates(userDataResponseEntity: response));
      },
    );
  }
}
