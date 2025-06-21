import 'package:faculty/data/remote/api/api_manager.dart';
import 'package:faculty/ui/home/cubit/states/vision_mission_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class VisionMissionCubit extends Cubit<VisionMissionState> {
  VisionMissionCubit() : super(VisionMissionInitial());

  void getVisionMission() async {
    emit(VisionMissionLoading());
    try {
      final visionMissions = await ApiManager.getVisionMission();
      emit(VisionMissionSuccess(visionMissions));
    } catch (e) {
      emit(VisionMissionError(e.toString()));
    }
  }
}