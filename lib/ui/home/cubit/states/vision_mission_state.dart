import 'package:faculty/data/models/response/vision_mission_model.dart';

abstract class VisionMissionState {}

class VisionMissionInitial extends VisionMissionState {}

class VisionMissionLoading extends VisionMissionState {}

class VisionMissionSuccess extends VisionMissionState {
  final List<VisionMissionModel> visionMissions;
  VisionMissionSuccess(this.visionMissions);
}

class VisionMissionError extends VisionMissionState {
  final String message;
  VisionMissionError(this.message);
} 