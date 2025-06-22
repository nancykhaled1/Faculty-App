import 'package:faculty/data/remote/api/api_manager.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademicTeamsCubit extends Cubit<AcademicTeamsState> {
  AcademicTeamsCubit() : super(AcademicTeamsInitial());

  void getAcademicYear(int id) async {
    emit(AcademicTeamsLoading());
    try {
      print('🔍 Fetching academic year for ID: $id');
      
      // فحص إذا كان ID صحيح
      if (id <= 0) {
        print('❌ Invalid ID: $id');
        emit(AcademicTeamsError('معرف غير صحيح'));
        return;
      }
      
      final academicYear = await ApiManager.getAcademicYear(id);
      print('✅ Academic year loaded successfully');
      emit(AcademicTeamsSuccess(academicYear));
    } catch (e) {
      print('❌ Error loading academic year: $e');
      
      // معالجة أخطاء محددة
      String errorMessage;
      if (e.toString().contains('FormatException')) {
        errorMessage = 'خطأ في تنسيق البيانات من الخادم';
      } else if (e.toString().contains('SocketException')) {
        errorMessage = 'خطأ في الاتصال بالخادم';
      } else {
        errorMessage = 'حدث خطأ في تحميل البيانات: $e';
      }
      
      emit(AcademicTeamsError(errorMessage));
    }
  }
}