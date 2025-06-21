import 'package:faculty/domain/entities/notificationEntity.dart';
import 'package:faculty/domain/usecase/get_notification_usecase.dart';
import 'package:faculty/ui/notification/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreenViewModel extends Cubit<NotificationStates> {
  GetNotificationUseCase getNotificationUseCase;

  NotificationScreenViewModel({required this.getNotificationUseCase})
      : super(NotificationInitialStates());

  List<NotificationResponseEntity> notifications = [];


  void getNotification(String token) async {
    emit(NotificationLoadingStates(loadingMessage: 'Loading...'));
    var either = await getNotificationUseCase.invoke(token);
    either.fold(
          (l) {
        emit(NotificationErrorStates(errorMessage: l.errorMessage));
      },
          (response) {
            notifications = response;
        emit(NotificationSuccessStates(notificationResponseEntity: response));
      },
    );
  }


}
