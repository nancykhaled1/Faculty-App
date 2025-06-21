import 'package:faculty/domain/usecase/updatedata_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:faculty/domain/usecase/get_userdata_usecase.dart';
import 'package:faculty/ui/alumni/cubit/states.dart';
import '../../../data/local/preferences.dart';
import '../../../data/remote/model/request/updatedataRequest.dart';

class ProfileViewModel extends Cubit<UserDataStates> {
  final GetUserdataUseCase getUserdataUseCase;
  final UpdateDataUseCase updateDataUseCase;

  ProfileViewModel({required this.getUserdataUseCase, required this.updateDataUseCase})
      : super(UserDataInitialStates());

  Future<void> getUserData(String token) async {
    emit(UserDataLoadingStates(loadingMessage: 'جارٍ تحميل البيانات...'));

    final either = await getUserdataUseCase.invoke(token);

    either.fold(
          (failure) {
            print("❌ Failure: ${failure.detail}");
        emit(UserDataErrorStates(errorMessage: failure.detail));
      },
          (response) async {
            print("✅ Success: ${response.graduationData?.user?.username}");
            // await SharedPrefsHelper.saveUserData(
            //   username: response.graduationData!.user,
            //   email: response.email,
            //   employmentStatus: response.employmentStatus,
            //   jobName: response.jobName,
            //   companyEmail: response.companyEmail,
            //   companyPhone: response.companyPhone,
            //   companyLink: response.companyLink,
            //   aboutCompany: response.aboutCompany,
            //   location: response.location,
            //   cv: response.cv,
           // );


            emit(UserDataSuccessStates(userDataResponseEntity: response));
      },
    );
  }

  // Future<void> updateData(String token, UpdateDataRequest request , AuthProvider authProvider) async {
  //   emit(UserDataLoadingStates(loadingMessage: 'جارٍ تغيير البيانات...'));
  //
  //   final either = await updateDataUseCase.invoke(token, request);
  //
  //   either.fold(
  //         (failure) {
  //       emit(UserDataErrorStates(errorMessage: failure.errorMessage));
  //     },
  //         (response) async {
  //       // 🧠 نحفظ البيانات اللي المستخدم عدّلها
  //       await SharedPrefsHelper.saveUserData(
  //         username: request.username ?? '',
  //         email: request.email ?? '',
  //         employmentStatus: request.employmentStatus ?? '',
  //         jobName: request.jobName ?? '',
  //         companyEmail: request.companyEmail ?? '',
  //         companyPhone: request.companyPhone ?? '',
  //         companyLink: request.companyLink ?? '',
  //         aboutCompany: request.aboutCompany ?? '',
  //         location: request.location ?? '',
  //         cv: request.cv,
  //       );
  //
  //       await authProvider.loadUserDataFromPrefs();
  //
  //       // ✅ نجيب البيانات الحقيقية من السيرفر ونعرضها
  //       await getUserData(token);
  //     },
  //   );
  // }

  // Future<void> updateData(UpdateDataRequest request, String token) async {
  //   emit(UserDataLoadingStates(loadingMessage: 'جار التحميل'));
  //
  //   try {
  //     await updateDataUseCase.invoke(token, request); // send patch
  //
  //     final result = await getUserdataUseCase.invoke(token); // get updated data
  //
  //     result.fold(
  //           (error) {
  //             print("❌ فشل التحديث: ${error.detail}");
  //
  //             emit(UserDataErrorStates(errorMessage: error.detail));
  //       },
  //           (user) async {
  //             await SharedPrefsHelper.saveUserData(
  //                         username: request.username ?? '',
  //                         email: request.email ?? '',
  //                         employmentStatus: request.employmentStatus ?? '',
  //                         jobName: request.jobName ?? '',
  //                         companyEmail: request.companyEmail ?? '',
  //                         companyPhone: request.companyPhone ?? '',
  //                         companyLink: request.companyLink ?? '',
  //                         aboutCompany: request.aboutCompany ?? '',
  //                         location: request.location ?? '',
  //                         cv: request.cv,
  //                       );
  //             print("✅ التحديث تم بنجاح");
  //             await getUserData(token);
  //
  //             emit(UpdateDataSuccessStates(updateDataResponseEntity: user));
  //       },
  //     );
  //   } catch (e) {
  //     emit(UserDataErrorStates(errorMessage: e.toString()));
  //   }
  // }
  Future<void> updateData(UpdateDataRequest request, String token) async {
    emit(UserDataLoadingStates(loadingMessage: 'جارٍ تحديث البيانات...'));

    final updateResult = await updateDataUseCase.invoke(token, request);

    updateResult.fold(
          (error) {
        print("❌ نوع الخطأ: ${error.runtimeType}");
        print("📩 الرسالة: ${error.errorMessage}");
        emit(UserDataErrorStates(errorMessage: error.errorMessage));
      },
          (success) async {
        print("✅ تم التحديث في الباك إند بنجاح");

        // 🧠 جلب البيانات المحدثة من السيرفر مباشرة
        final result = await getUserdataUseCase.invoke(token);

        result.fold(
              (error) {
            print("❌ فشل تحميل البيانات بعد التحديث: ${error.detail}");
            emit(UserDataErrorStates(errorMessage: error.detail));
          },
              (user) async {
            // 🗃️ تخزين البيانات المحدثة في SharedPreferences
            await SharedPrefsHelper.saveUserData(
              username: user.graduationData?.user?.username ?? '',
              email: user.graduationData?.user?.email ?? '',
              employmentStatus: user.graduationData?.employmentStatus ?? '',
              jobName: user.graduationData?.jobName ?? '',
              companyEmail: user.graduationData?.companyEmail ?? '',
              companyPhone: user.graduationData?.companyPhone ?? '',
              companyLink: user.graduationData?.companyLink ?? '',
              aboutCompany: user.graduationData?.aboutCompany ?? '',
              location: user.graduationData?.location ?? '',
              cv: user.graduationData?.cv,
            );

            print("✅ تم تخزين البيانات بعد التحديث");

            emit(UpdateDataSuccessStates(updateDataResponseEntity: user));
          },
        );
      },
    );
  }



}
