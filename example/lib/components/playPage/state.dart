import 'package:dva_dart/dva_dart.dart';

class PlayerState implements State {
  final bool isInitial;
  final bool isPlaying;
  final bool isPaused;
  final bool isStopped;
  final String status;

  PlayerState.initial(
      {this.isInitial = true,
      this.isPlaying = false,
      this.isPaused = false,
      this.isStopped = false,
      this.status = 'Ready'});

  PlayerState.playing(
      {this.isInitial = false,
      this.isPlaying = true,
      this.isPaused = false,
      this.isStopped = false,
      this.status = 'Playing'});

  PlayerState.paused(
      {this.isInitial = false,
      this.isPlaying = false,
      this.isPaused = true,
      this.isStopped = false,
      this.status = 'Paused'});

  PlayerState.stopped(
      {this.isInitial = false,
      this.isPlaying = false,
      this.isPaused = false,
      this.isStopped = true,
      this.status = 'Stopped'});
}
