import 'package:faculty/domain/repository/datasource/notification_remote_datasource.dart';
import 'package:faculty/domain/usecase/get_studentportal_usecase.dart';
import 'package:faculty/domain/usecase/get_userdata_usecase.dart';
import 'package:faculty/domain/usecase/registerusecase.dart';
import '../../data/remote/api/api_manager.dart';
import '../../repository/datasource_imp/auth-remote_datasource_imp.dart';
import '../../repository/datasource_imp/dept_remote_datasource_imp.dart';
import '../../repository/datasource_imp/notification_remote_datasource_imp.dart';
import '../../repository/datasource_imp/student_remote_datasource_imp.dart';
import '../../repository/repository_imp/auth_reository_imp.dart';
import '../../repository/repository_imp/dept_repository_imp.dart';
import '../../repository/repository_imp/notification_repository_imp.dart';
import '../../repository/repository_imp/student_repository_imp.dart';
import '../repository/datasource/auth_remote_datasource.dart';
import '../repository/datasource/dept_remote_datasource.dart';
import '../repository/datasource/student_remote_datasource.dart';
import '../repository/repository/auth_repository_contract.dart';
import '../repository/repository/dept_repository_contract.dart';
import '../repository/repository/notification_repository_contract.dart';
import '../repository/repository/student_repository_contract.dart';
import 'get_all_dept_usecase.dart';
import 'get_notification_usecase.dart';
import 'get_studentservice_usecase.dart';
import 'loginusercase.dart';

AuthRepositoryContract injectAuthRepository(){
  return AuthRepositoryImp(remoteDataSource: injectAuthRemoteDataSource());
}
AuthRemoteDataSource injectAuthRemoteDataSource(){
  return AuthRemoteDataSourceImp(apiManager: ApiManager.getInstance());
}

RegisterUseCase injectRegisterUseCase(){
  return RegisterUseCase(repositoryContract: injectAuthRepository());
}


LoginUseCase injectLoginUseCase(){
  return LoginUseCase(repositoryContract: injectAuthRepository());
}

DepartmentRepositoryContract injectDepartmentRepositoryContract(){
  return DepartmentRepositoryImp(remoteDataSource: injectDeptRemoteDataSource() );
}

DepartmentRemoteDataSource injectDeptRemoteDataSource(){
  return DepartmentDataSourceImp(apiManager: ApiManager.getInstance());
}

GetAllDepartmentUseCase injectGetAllDepartmentUseCase(){
  return GetAllDepartmentUseCase(repositoryContract: injectDepartmentRepositoryContract() );
}

StudentRemoteDataSource injectStudentRemoteDataSource(){
  return StudentDataSourceImp(apiManager: ApiManager.getInstance());
}

StudentRepositoryContract injectStudentRepositoryContract(){
  return StudentRepositoryImp(remoteDataSource: injectStudentRemoteDataSource() );
}

GetStudentServiceUseCase injectGetStudentServiceUseCase(){
  return GetStudentServiceUseCase(repositoryContract: injectStudentRepositoryContract() );
}

GetStudentPortalUseCase injectGetStudentPortalUseCase(){
  return GetStudentPortalUseCase(repositoryContract: injectStudentRepositoryContract() );
}


GetUserdataUseCase injectGetUserDataServiceUseCase(){
  return GetUserdataUseCase(repositoryContract: injectAuthRepository() );
}


NotificationRemoteDataSource injectNotificationRemoteDataSource(){
  return NotificationDataSourceImp(apiManager: ApiManager.getInstance());
}

NotificationRepositoryContract injectNotificationRepositoryContract(){
  return NotificationRepositoryImp(remoteDataSource: injectNotificationRemoteDataSource() );
}

GetNotificationUseCase injectNotificationUseCase(){
  return GetNotificationUseCase(repositoryContract: injectNotificationRepositoryContract() );
}

