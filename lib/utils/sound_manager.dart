// lib/utils/sound_manager.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:flutter/foundation.dart';

/// Manages all audio playback within the application, including sound effects (SFX)
/// for game actions and status-related sounds (win, lose, etc.).
class SoundManager {
  /// Dedicated player for short, frequent sound effects like moves or captures.
  final AudioPlayer _sfxPlayer = AudioPlayer();
  
  /// Dedicated player for status-related sounds that may overlap with game SFX.
  final AudioPlayer _statusPlayer = AudioPlayer();
  
  /// Provider to check if sound effects are enabled in user settings.
  final SettingsProvider _settingsProvider;

  SoundManager(this._settingsProvider) {
    // Configure players to release resources after finishing playback.
    _sfxPlayer.setReleaseMode(ReleaseMode.release);
    _statusPlayer.setReleaseMode(ReleaseMode.release);
  }

  /// Plays a standard click sound for UI interactions.
  void playClickSound() => _playSound('sounds/audiomass-output.wav', player: _sfxPlayer);
  
  /// Plays a sound when a piece is moved.
  void playMoveSound() => _playSound('sounds/move.wav', player: _sfxPlayer);
  
  /// Plays a sound when a piece is captured.
  void playCaptureSound() => _playSound('sounds/capture.wav', player: _sfxPlayer);
  
  /// Plays a sound when a piece is promoted to a King.
  void playPromoteSound() => _playSound('sounds/promote.wav', player: _sfxPlayer);

  /// Plays a sound at the start of a game.
  void playStartSound() => _playSound('sounds/start.wav', player: _statusPlayer);
  
  /// Plays a triumphant sound when the player wins.
  void playWinSound() => _playSound('sounds/win.wav', player: _statusPlayer);
  
  /// Plays a sound when the player loses.
  void playLoseSound() => _playSound('sounds/lose.wav', player: _statusPlayer);
  
  /// Plays a sound when the game ends in a draw.
  void playDrawSound() => _playSound('sounds/draw.wav', player: _statusPlayer);

  /// Internal helper to handle sound playback logic.
  /// 
  /// Checks if sounds are enabled in [SettingsProvider] before attempting playback.
  /// If the player is already playing a sound, it stops it first to ensure
  /// the new sound plays immediately and clearly.
  Future<void> _playSound(String soundPath, {required AudioPlayer player}) async {
    // Only play sounds if enabled in the application settings.
    if (!_settingsProvider.soundEffectsEnabled) return;
    
    try {
      // To prevent multiple sounds from playing simultaneously on the same player,
      // stop the current sound before starting the next one.
      if (player.state == PlayerState.playing) {
        await player.stop();
      }
      
      // Load and play the sound from the assets folder.
      await player.play(AssetSource(soundPath));
    } catch (e) {
      // Log errors if a sound file fails to play.
      debugPrint("An error occurred while playing the sound file ('$soundPath'): $e");
    }
  }

  /// Releases audio resources when the [SoundManager] is no longer needed.
  void dispose() {
    _sfxPlayer.dispose();
    _statusPlayer.dispose();
  }
}
