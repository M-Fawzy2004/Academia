// ignore_for_file: invalid_use_of_internal_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  YoutubePlayerController? _controller;
  YoutubePlayerController? get controller => _controller;

  Future<void> initializePlayer(String videoUrl) async {
    try {
      emit(VideoPlayerLoading());

      final videoId = YoutubePlayerController.convertUrlToId(videoUrl);

      if (videoId == null) {
        emit(const VideoPlayerError('Invalid YouTube URL'));
        return;
      }

      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          captionLanguage: 'ar',
          mute: false,
          showFullscreenButton: true,
          loop: false,
          enableCaption: true,
          strictRelatedVideos: true,
        ),
      );

      await _controller!.init();

      emit(VideoPlayerLoaded(_controller!));
    } catch (e) {
      emit(VideoPlayerError('Failed to load video: ${e.toString()}'));
    }
  }

  Future<void> togglePlayPause() async {
    if (_controller == null) return;

    try {
      final playerState = await _controller!.playerState;

      if (playerState == PlayerState.playing) {
        await _controller!.pauseVideo();
        emit(VideoPlayerPaused(_controller!));
      } else {
        await _controller!.playVideo();
        emit(VideoPlayerPlaying(_controller!));
      }
    } catch (e) {
      emit(VideoPlayerError('Failed to toggle playback: ${e.toString()}'));
    }
  }

  Future<void> seekForward() async {
    if (_controller == null) return;

    try {
      final currentTime = await _controller!.currentTime;
      final playerState = await _controller!.playerState;

      await _controller!.seekTo(
        seconds: currentTime + 10,
        allowSeekAhead: true,
      );

      if (playerState == PlayerState.playing) {
        emit(VideoPlayerPlaying(_controller!));
      } else {
        emit(VideoPlayerPaused(_controller!));
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> seekBackward() async {
    if (_controller == null) return;

    try {
      final currentTime = await _controller!.currentTime;
      final playerState = await _controller!.playerState;
      final newTime = (currentTime - 10).clamp(0.0, double.infinity);

      await _controller!.seekTo(
        seconds: newTime,
        allowSeekAhead: true,
      );

      if (playerState == PlayerState.playing) {
        emit(VideoPlayerPlaying(_controller!));
      } else {
        emit(VideoPlayerPaused(_controller!));
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Future<void> close() async {
    await _controller?.close();
    return super.close();
  }
}
