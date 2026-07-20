import 'package:flutter/foundation.dart';

enum AuthGateState { checking, signedOut, signedIn }

/// Shared, lightweight auth signal used only by the router.
final ValueNotifier<AuthGateState> authGateNotifier = ValueNotifier(
  AuthGateState.checking,
);
