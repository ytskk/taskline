import 'package:flutter/gestures.dart';

/// A simple [GestureRecognizer] that combines [TapGestureRecognizer] and [LongPressGestureRecognizer]
/// It only supports two simple callbacks [onTap] and [onLongPress]
///
class TapAndLongPressGestureRecognizer extends PrimaryPointerGestureRecognizer {
  /// Creates a gesture recognizer.
  TapAndLongPressGestureRecognizer({
    Duration? duration,
    double? postAcceptSlopTolerance,
    Set<PointerDeviceKind>? supportedDevices,
    Object? debugOwner,
  }) : super(
          deadline: duration ?? kLongPressTimeout,
          postAcceptSlopTolerance: postAcceptSlopTolerance,
          supportedDevices: supportedDevices,
          debugOwner: debugOwner,
        );

  bool _longPressAccepted = false;

  // The buttons sent by `PointerDownEvent`. If a `PointerMoveEvent` comes with a
  // different set of buttons, the gesture is canceled.
  int? _initialButtons;

  bool _sentTapDown = false;
  bool _wonArenaForPrimaryPointer = false;

  PointerDownEvent? _down;
  PointerUpEvent? _up;

  /// Called when a long press gesture by a primary button has been recognized.
  ///
  GestureLongPressCallback? onLongPress;

  /// A pointer has stopped contacting the screen, which is recognized as a tap
  /// of a primary button.
  ///
  /// This triggers on the up event, if the recognizer wins the arena with it
  /// or has previously won, immediately following [onTapUp].
  ///
  GestureTapCallback? onTap;

  VelocityTracker? _velocityTracker;

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    switch (event.buttons) {
      case kPrimaryButton:
        if (onLongPress == null) {
          return false;
        }
        break;
      default:
        return false;
    }

    return super.isPointerAllowed(event);
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (state == GestureRecognizerState.ready) {
      // If there is no result in the previous gesture arena,
      // we ignore them and prepare to accept a new pointer.
      if (_down != null && _up != null) {
        assert(_down!.pointer == _up!.pointer);
        _resetTap();
      }

      assert(_down == null && _up == null);
      // `_down` must be assigned in this method instead of `handlePrimaryPointer`,
      // because `acceptGesture` might be called before `handlePrimaryPointer`,
      // which relies on `_down` to call `handleTapDown`.
      _down = event;
    }
    if (_down != null) {
      // This happens when this tap gesture has been rejected while the pointer
      // is down (i.e. due to movement), when another allowed pointer is added,
      // in which case all pointers are simply ignored. The `_down` being null
      // means that _reset() has been called, since it is always set at the
      // first allowed down event and will not be cleared except for reset(),
      super.addAllowedPointer(event);
    }
  }

  @override
  void didExceedDeadline() {
    // Exceeding the deadline puts the gesture in the accepted state.
    resolve(GestureDisposition.accepted);
    _longPressAccepted = true;
    super.acceptGesture(primaryPointer!);
    _checkLongPressStart();
  }

  @override
  void handlePrimaryPointer(PointerEvent event) {
    if (!event.synthesized) {
      if (event is PointerDownEvent) {
        _velocityTracker = VelocityTracker.withKind(event.kind);
        _velocityTracker!.addPosition(event.timeStamp, event.localPosition);
      }
      if (event is PointerMoveEvent) {
        assert(_velocityTracker != null);
        _velocityTracker!.addPosition(event.timeStamp, event.localPosition);
      }
    }

    if (event is PointerUpEvent) {
      if (_longPressAccepted) {
        _checkLongPressEnd(event);
        _resetTap();
      } else {
        _up = event;
        _checkTapUp();
      }
      _resetLongPress();
    } else if (event is PointerCancelEvent) {
      _resetLongPress();
      if (_sentTapDown) {
        _checkTapCancel(event, '');
      }
      _resetTap();
    } else if (event is PointerDownEvent) {
      _initialButtons = event.buttons;
      _down = event;
      _checkTapDown();
    } else if (event is PointerMoveEvent) {
      if (event.buttons != _initialButtons) {
        resolve(GestureDisposition.rejected);
        stopTrackingPointer(primaryPointer!);
      }
    }
  }

  void _checkTapUp() {
    if (!_wonArenaForPrimaryPointer || _up == null) {
      return;
    }
    assert(_up!.pointer == _down!.pointer);
    switch (_down!.buttons) {
      case kPrimaryButton:
        if (onTap != null) {
          invokeCallback<void>('onTap', onTap!);
        }
        break;
      default:
    }
    _resetTap();
  }

  void _checkTapDown() {
    if (_sentTapDown) {
      return;
    }
    _sentTapDown = true;
  }

  void _checkTapCancel(PointerCancelEvent? event, String note) {}

  void _resetTap() {
    _sentTapDown = false;
    _wonArenaForPrimaryPointer = false;
    _up = null;
    _down = null;
  }

  void _checkLongPressStart() {
    switch (_initialButtons) {
      case kPrimaryButton:
        if (onLongPress != null) {
          invokeCallback<void>('onLongPress', onLongPress!);
        }
        break;
      default:
        assert(false, 'Unhandled button $_initialButtons');
    }
  }

  void _checkLongPressEnd(PointerEvent event) {
    _velocityTracker = null;
  }

  void _resetLongPress() {
    _longPressAccepted = false;
    _initialButtons = null;
    _velocityTracker = null;
  }

  @override
  void resolve(GestureDisposition disposition) {
    if (disposition == GestureDisposition.rejected) {
      if (_longPressAccepted) {
        // This can happen if the gesture has been canceled. For example when
        // the buttons have changed.
        _resetLongPress();
      }

      if (_wonArenaForPrimaryPointer && _sentTapDown) {
        // This can happen if the gesture has been canceled. For example, when
        // the pointer has exceeded the touch slop, the buttons have been changed,
        // or if the recognizer is disposed.
        _checkTapCancel(null, 'spontaneous');
        _resetTap();
      }
    }
    super.resolve(disposition);
  }

  @override
  void acceptGesture(int pointer) {
    if (pointer == primaryPointer && _down != null) {
      _checkTapDown();
      _wonArenaForPrimaryPointer = true;
      _checkTapUp();
    }
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);
    if (pointer == primaryPointer) {
      // Another gesture won the arena.
      assert(state != GestureRecognizerState.possible);
      if (_sentTapDown) {
        _checkTapCancel(null, 'forced');
      }
      _resetTap();
    }
  }

  @override
  String get debugDescription => 'tap or long press';
}
