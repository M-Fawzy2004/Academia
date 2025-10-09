part of 'video_player_cubit.dart';

abstract class VideoPlayerState {
  const VideoPlayerState();
}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

abstract class VideoPlayerWithController extends VideoPlayerState {
  final YoutubePlayerController controller;

  const VideoPlayerWithController(this.controller);
}

class VideoPlayerLoaded extends VideoPlayerWithController {
  const VideoPlayerLoaded(super.controller);
}

class VideoPlayerPlaying extends VideoPlayerWithController {
  const VideoPlayerPlaying(super.controller);
}

class VideoPlayerPaused extends VideoPlayerWithController {
  const VideoPlayerPaused(super.controller);
}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);
}