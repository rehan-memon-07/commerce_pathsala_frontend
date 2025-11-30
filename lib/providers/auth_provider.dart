// ============================================================================
// AUTH PROVIDER - STATE MANAGEMENT (Using Provider package)
// ============================================================================
// Manages authentication state across the app using ChangeNotifier
// Provider Pattern: Automatically notifies listeners when state changes
// Usage: context.watch<AuthProvider>() or context.read<AuthProvider>()

import 'package:flutter/material.dart';
import 'package:commerce_paathshala_app/models/user_model.dart';
import 'package:commerce_paathshala_app/repositories/user_repository.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AuthProvider extends ChangeNotifier {
  // Dependencies - can be injected in constructor for better testability
  final UserRepository _userRepository = UserRepository();

  // State variables
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  String? _authToken; // TODO: Store in SharedPreferences for persistence

  // Getters - expose state to UI
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;
  bool get isStudent => _currentUser?.role == 'student';
  bool get isTeacher => _currentUser?.role == 'teacher';

  // ========== AUTHENTICATION METHODS ==========

  /// Sign in with Google
  /// TODO: Integrate with actual Google Sign-In package:
  /// - Import: import 'package:google_sign_in/google_sign_in.dart';
  /// - Get idToken from GoogleSignInAccount
  /// - Pass to loginWithGoogle method
  Future<bool> loginWithGoogle(String googleIdToken) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _userRepository.loginWithGoogle(googleIdToken);
      
      if (user != null) {
        _currentUser = user;
        // TODO: Save token to SharedPreferences with key 'auth_token'
        // TODO: Set up HTTP interceptor to include token in future requests
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError('Login failed. Please try again.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Error during login: $e');
      _setLoading(false);
      return false;
    }
  }

  /// Get current authenticated user
  /// TODO: Call this after app startup to restore user session
  Future<void> getCurrentUser() async {
    try {
      final user = await _userRepository.getCurrentUser();
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      _setError('Error fetching user: $e');
    }
  }

  /// Logout current user
  /// TODO: Clear token from SharedPreferences and reset app state
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _userRepository.logout();
      _currentUser = null;
      _authToken = null;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError('Error during logout: $e');
      _setLoading(false);
    }
  }

  // ========== HELPER METHODS ==========

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
